//
//  ContentView.swift
//  FamilyOps
//
//  Created by Florin Sima on 14.03.2026.
//

import SwiftUI
import SwiftData

enum AppTheme: String, CaseIterable {
    case system = "theme_system"
    case light = "theme_light"
    case dark = "theme_dark"
    
    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}

enum AppLanguage: String, CaseIterable {
    case romanian = "Română"
    case english = "English"
    case german = "Deutsch"
    
    var localeCode: String {
        switch self {
        case .romanian: return "ro"
        case .english: return "en"
        case .german: return "de"
        }
    }
    
    func translate(_ key: String) -> String {
        let translations: [String: [AppLanguage: String]] = [
            "home": [.romanian: "Acasă", .english: "Home", .german: "Start"],
            "tasks": [.romanian: "Sarcini", .english: "Tasks", .german: "Aufgaben"],
            "settings": [.romanian: "Setări", .english: "Settings", .german: "Einstellungen"],
            "progress_title": [.romanian: "Progresul Copiilor", .english: "Children's Progress", .german: "Fortschritt der Kinder"],
            "daily_tasks": [.romanian: "Sarcini Zilnice", .english: "Daily Tasks", .german: "Tägliche Aufgaben"],
            "no_children": [.romanian: "Niciun copil adăugat", .english: "No children added", .german: "Keine Kinder hinzugefügt"],
            "add_child_desc": [.romanian: "Adaugă copiii folosind butonul +.", .english: "Add children using the + button.", .german: "Kinder mit der + Taste hinzufügen."],
            "delete": [.romanian: "Șterge", .english: "Delete", .german: "Löschen"],
            "edit": [.romanian: "Editează", .english: "Edit", .german: "Bearbeiten"],
            "theme": [.romanian: "Temă Aplicație", .english: "App Theme", .german: "App-Design"],
            "language": [.romanian: "Limbă", .english: "Language", .german: "Sprache"],
            "add_child": [.romanian: "Adaugă Copil", .english: "Add Child", .german: "Kind hinzufügen"],
            "add_task": [.romanian: "Adaugă Sarcină", .english: "Add Task", .german: "Aufgabe hinzufügen"],
            "edit_task": [.romanian: "Editează Sarcină", .english: "Edit Task", .german: "Aufgabe bearbeiten"],
            "name": [.romanian: "Nume", .english: "Name", .german: "Name"],
            "save": [.romanian: "Salvează", .english: "Save", .german: "Speichern"],
            "cancel": [.romanian: "Anulează", .english: "Cancel", .german: "Abbrechen"],
            "done": [.romanian: "Gata", .english: "Done", .german: "Fertig"],
            "suggested": [.romanian: "Sugestii", .english: "Suggestions", .german: "Vorschläge"],
            "custom": [.romanian: "Personalizat", .english: "Custom", .german: "Benutzerdefiniert"],
            "points": [.romanian: "Puncte", .english: "Points", .german: "Punkte"],
            "main_prize": [.romanian: "Premiul surpriză", .english: "Surprise Prize", .german: "Überraschungspreis"],
            "pts_until_prize": [.romanian: "pts până la premiu", .english: "pts to prize", .german: "pts zum Preis"],
            "select_child": [.romanian: "Alege Copilul", .english: "Select Child", .german: "Kind wählen"],
            "rewards_section": [.romanian: "Configurare Milestones", .english: "Milestone Setup", .german: "Meilenstein-Konfiguration"],
            "reward_25_def": [.romanian: "Înghețată", .english: "Ice Cream", .german: "Eiscreme"],
            "reward_50_def": [.romanian: "Film", .english: "Movie", .german: "Film"],
            "reward_75_def": [.romanian: "Jucărie", .english: "Toy", .german: "Spielzeug"],
            "reward_100_def": [.romanian: "Cofetărie Sibiu", .english: "Pastry Shop", .german: "Konditorei"],
            "theme_system": [.romanian: "Sistem", .english: "System", .german: "System"],
            "theme_light": [.romanian: "Luminos", .english: "Light", .german: "Hell"],
            "theme_dark": [.romanian: "Întunecat", .english: "Dark", .german: "Dunkel"],
            "task_backpack": [.romanian: "Preparat ghiozdan", .english: "Pack backpack", .german: "Rucksack packen"],
            "task_table": [.romanian: "Strâns masa", .english: "Clear the table", .german: "Tisch abräumen"],
            "task_teeth": [.romanian: "Spălat pe dinți", .english: "Brush teeth", .german: "Zähne putzen"],
            "task_room": [.romanian: "Curățenie în cameră", .english: "Clean room", .german: "Zimmer aufräumen"],
            "task_bed": [.romanian: "Strâns patul", .english: "Make the bed", .german: "Bett machen"],
            "task_homework": [.romanian: "Teme", .english: "Homework", .german: "Hausaufgaben"]
        ]
        return translations[key]?[self] ?? key
    }
}

struct ContentView: View {
    @AppStorage("appTheme") private var selectedTheme: AppTheme = .system
    @AppStorage("appLanguage") private var selectedLanguage: AppLanguage = .romanian
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label(selectedLanguage.translate("home"), systemImage: "house.fill")
                }
            
            TasksView()
                .tabItem {
                    Label(selectedLanguage.translate("tasks"), systemImage: "checkmark.seal.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label(selectedLanguage.translate("settings"), systemImage: "gearshape.fill")
                }
        }
        .preferredColorScheme(selectedTheme.colorScheme)
        .environment(\.locale, .init(identifier: selectedLanguage.localeCode))
    }
}

// MARK: - Home Tab
struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("appLanguage") private var selectedLanguage: AppLanguage = .romanian
    @Query(sort: \Child.name) private var children: [Child]
    
    @State private var isShowingAddChild = false
    @State private var newChildName = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    Text(selectedLanguage.translate("progress_title"))
                        .font(.largeTitle.bold())
                        .padding(.horizontal)
                    
                    if children.isEmpty {
                        ContentUnavailableView(
                            selectedLanguage.translate("no_children"),
                            systemImage: "person.2.badge.plus",
                            description: Text(selectedLanguage.translate("add_child_desc"))
                        )
                    } else {
                        VStack(spacing: 20) {
                            ForEach(children) { child in
                                ChildCard(child: child)
                                    .contextMenu {
                                        Button(role: .destructive) {
                                            modelContext.delete(child)
                                        } label: {
                                            Label(selectedLanguage.translate("delete"), systemImage: "trash")
                                        }
                                    }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle(selectedLanguage.translate("home"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingAddChild = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                    }
                }
            }
            .sheet(isPresented: $isShowingAddChild) {
                NavigationStack {
                    Form {
                        TextField(selectedLanguage.translate("name"), text: $newChildName)
                            .autocorrectionDisabled()
                    }
                    .navigationTitle(selectedLanguage.translate("add_child"))
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button(selectedLanguage.translate("cancel")) {
                                isShowingAddChild = false
                                newChildName = ""
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button(selectedLanguage.translate("save")) {
                                saveChild()
                            }
                            .disabled(newChildName.trimmingCharacters(in: .whitespaces).isEmpty)
                        }
                    }
                }
                .presentationDetents([.fraction(0.3)])
            }
        }
    }
    
    private func saveChild() {
        let trimmedName = newChildName.trimmingCharacters(in: .whitespaces)
        guard !trimmedName.isEmpty else { return }
        let newChild = Child(name: trimmedName)
        modelContext.insert(newChild)
        try? modelContext.save()
        isShowingAddChild = false
        newChildName = ""
    }
}

// MARK: - Tasks Tab
struct TasksView: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("appLanguage") private var selectedLanguage: AppLanguage = .romanian
    @Query(sort: \Child.name) private var children: [Child]
    
    @State private var selectedChildID: PersistentIdentifier?
    @State private var isShowingAddTask = false
    @State private var editingTaskID: PersistentIdentifier?
    
    var selectedChild: Child? {
        children.first(where: { $0.id == selectedChildID })
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if !children.isEmpty {
                    Picker(selectedLanguage.translate("select_child"), selection: $selectedChildID) {
                        ForEach(children) { child in
                            Text(child.name).tag(child.id as PersistentIdentifier?)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                }
                
                List {
                    if children.isEmpty {
                        ContentUnavailableView(selectedLanguage.translate("no_children"), systemImage: "person.2.badge.plus")
                    } else if let child = selectedChild {
                        if child.tasks.isEmpty {
                            ContentUnavailableView(selectedLanguage.translate("tasks"), systemImage: "list.bullet.clipboard")
                        } else {
                            ForEach(child.tasks) { task in
                                TaskRow(task: task) {
                                    toggleTask(task)
                                }
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    Button(role: .destructive) {
                                        modelContext.delete(task)
                                    } label: {
                                        Label(selectedLanguage.translate("delete"), systemImage: "trash")
                                    }
                                    
                                    Button {
                                        editingTaskID = task.id
                                    } label: {
                                        Label(selectedLanguage.translate("edit"), systemImage: "pencil")
                                    }
                                    .tint(.orange)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(selectedLanguage.translate("daily_tasks"))
            .toolbar {
                Button {
                    isShowingAddTask = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title3)
                }
                .disabled(selectedChildID == nil)
            }
            .sheet(isPresented: $isShowingAddTask) {
                if let selectedChildID {
                    AddTaskSheet(childID: selectedChildID)
                }
            }
            .sheet(item: $editingTaskID) { id in
                EditTaskSheet(taskID: id)
            }
            .onAppear {
                if selectedChildID == nil {
                    selectedChildID = children.first?.id
                }
            }
        }
    }
    
    private func toggleTask(_ task: FamilyTask) {
        withAnimation(.spring()) {
            if task.isCompletedToday {
                task.lastCompletedDate = nil
                if let child = task.child {
                    child.points = max(0, child.points - task.points)
                }
            } else {
                task.lastCompletedDate = Date()
                task.child?.points += task.points
                if let child = task.child, child.points > 0 && child.points % 100 == 0 {
                    child.level += 1
                }
            }
            try? modelContext.save()
        }
    }
}

// MARK: - Task Helpers
extension PersistentIdentifier: Identifiable {
    public var id: String { self.description }
}

struct AddTaskSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @AppStorage("appLanguage") private var selectedLanguage: AppLanguage = .romanian
    
    let childID: PersistentIdentifier
    
    @State private var customTitle = ""
    @State private var customPoints = 10
    @State private var selectedSuggestionKeys: Set<String> = []
    
    struct SuggestedTask: Identifiable {
        var id: String { titleKey }
        let titleKey: String
        let points: Int
    }
    
    let suggestions: [SuggestedTask] = [
        SuggestedTask(titleKey: "task_backpack", points: 10),
        SuggestedTask(titleKey: "task_table", points: 5),
        SuggestedTask(titleKey: "task_teeth", points: 5),
        SuggestedTask(titleKey: "task_room", points: 20),
        SuggestedTask(titleKey: "task_bed", points: 5),
        SuggestedTask(titleKey: "task_homework", points: 15)
    ]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(selectedLanguage.translate("suggested")) {
                    ForEach(suggestions) { suggestion in
                        Button {
                            if selectedSuggestionKeys.contains(suggestion.titleKey) {
                                selectedSuggestionKeys.remove(suggestion.titleKey)
                            } else {
                                selectedSuggestionKeys.insert(suggestion.titleKey)
                            }
                        } label: {
                            HStack {
                                Text(selectedLanguage.translate(suggestion.titleKey))
                                Spacer()
                                if selectedSuggestionKeys.contains(suggestion.titleKey) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(.green)
                                } else {
                                    Text("+\(suggestion.points)")
                                        .font(.caption.bold())
                                        .foregroundStyle(.blue)
                                }
                            }
                        }
                        .foregroundStyle(.primary)
                    }
                }
                
                Section(selectedLanguage.translate("custom")) {
                    TextField(selectedLanguage.translate("name"), text: $customTitle)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("\(selectedLanguage.translate("points")): \(customPoints)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Picker("", selection: $customPoints) {
                            ForEach(1...100, id: \.self) { num in
                                Text("\(num)").tag(num)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 100)
                    }
                    
                    Button {
                        addCustomTask()
                    } label: {
                        HStack {
                            Text(selectedLanguage.translate("save"))
                            Spacer()
                            Image(systemName: "plus")
                        }
                    }
                    .disabled(customTitle.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .navigationTitle(selectedLanguage.translate("add_task"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(selectedLanguage.translate("done")) {
                        saveAndDismiss()
                    }
                    .bold()
                }
            }
        }
    }
    
    private func saveAndDismiss() {
        guard let child = modelContext.model(for: childID) as? Child else { return }
        
        for key in selectedSuggestionKeys {
            if let suggestion = suggestions.first(where: { $0.titleKey == key }) {
                let newTask = FamilyTask(title: selectedLanguage.translate(suggestion.titleKey), 
                                       points: suggestion.points, 
                                       emoji: "")
                newTask.child = child
                modelContext.insert(newTask)
            }
        }
        try? modelContext.save()
        dismiss()
    }
    
    private func addCustomTask() {
        guard let child = modelContext.model(for: childID) as? Child else { return }
        let newTask = FamilyTask(title: customTitle, points: customPoints, emoji: "")
        newTask.child = child
        modelContext.insert(newTask)
        customTitle = "" 
    }
}

struct EditTaskSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @AppStorage("appLanguage") private var selectedLanguage: AppLanguage = .romanian
    
    let taskID: PersistentIdentifier
    
    @State private var title = ""
    @State private var points = 10
    
    var body: some View {
        NavigationStack {
            Form {
                Section(selectedLanguage.translate("edit_task")) {
                    TextField(selectedLanguage.translate("name"), text: $title)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("\(selectedLanguage.translate("points")): \(points)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Picker("", selection: $points) {
                            ForEach(1...100, id: \.self) { num in
                                Text("\(num)").tag(num)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 100)
                    }
                }
            }
            .navigationTitle(selectedLanguage.translate("edit_task"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(selectedLanguage.translate("cancel")) { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(selectedLanguage.translate("save")) {
                        saveChanges()
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let task = modelContext.model(for: taskID) as? FamilyTask {
                    title = task.title
                    points = task.points
                }
            }
        }
    }
    
    private func saveChanges() {
        if let task = modelContext.model(for: taskID) as? FamilyTask {
            task.title = title
            task.points = points
            try? modelContext.save()
        }
    }
}

// MARK: - Evolution UI Components
struct Milestone: Identifiable {
    var id: Int { points }
    let points: Int
    let name: String
}

struct MilestoneProgressView: View {
    let points: Int
    @AppStorage("appLanguage") private var selectedLanguage: AppLanguage = .romanian
    
    @AppStorage("reward25Points") private var reward25Points: Int = 25
    @AppStorage("reward25Name") private var reward25Name: String = ""
    
    @AppStorage("reward50Points") private var reward50Points: Int = 50
    @AppStorage("reward50Name") private var reward50Name: String = ""
    
    @AppStorage("reward75Points") private var reward75Points: Int = 75
    @AppStorage("reward75Name") private var reward75Name: String = ""
    
    @AppStorage("reward100Name") private var reward100Name: String = ""

    var milestones: [Milestone] {
        [
            Milestone(points: reward25Points, name: reward25Name.isEmpty ? selectedLanguage.translate("reward_25_def") : reward25Name),
            Milestone(points: reward50Points, name: reward50Name.isEmpty ? selectedLanguage.translate("reward_50_def") : reward50Name),
            Milestone(points: reward75Points, name: reward75Name.isEmpty ? selectedLanguage.translate("reward_75_def") : reward75Name),
            Milestone(points: 100, name: reward100Name.isEmpty ? selectedLanguage.translate("reward_100_def") : reward100Name)
        ].sorted(by: { $0.points < $1.points })
    }
    
    var currentProgress: Double {
        let currentLevelPoints = points % 100
        if points > 0 && currentLevelPoints == 0 { return 1.0 }
        return Double(currentLevelPoints) / 100.0
    }
    
    var body: some View {
        VStack(spacing: 8) {
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemGray5))
                        .frame(height: 12)
                        .position(x: geo.size.width / 2, y: 50)
                    
                    let fillWidth = (geo.size.width - 20) * CGFloat(currentProgress)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(LinearGradient(colors: [.pink, .orange], startPoint: .leading, endPoint: .trailing))
                        .frame(width: max(0, fillWidth), height: 12)
                        .position(x: 10 + (fillWidth / 2), y: 50)
                    
                    ForEach(milestones) { ms in
                        let currentLevelPoints = points % 100
                        let isReached = (points > 0 && currentLevelPoints == 0) || currentLevelPoints >= ms.points
                        let xPos = 10 + (geo.size.width - 20) * CGFloat(Double(ms.points) / 100.0)
                        
                        Text(ms.name)
                            .font(.system(size: 8, weight: .bold))
                            .lineLimit(2)
                            .multilineTextAlignment(ms.points == 100 ? .trailing : (ms.points < 15 ? .leading : .center))
                            .frame(width: 50, alignment: ms.points == 100 ? .trailing : (ms.points < 15 ? .leading : .center))
                            .opacity(isReached ? 1.0 : 0.4)
                            .position(x: ms.points == 100 ? xPos - 20 : (ms.points < 15 ? xPos + 20 : xPos), y: 20)
                        
                        Circle()
                            .fill(isReached ? .orange : Color(.systemGray4))
                            .frame(width: 14, height: 14)
                            .overlay(Circle().stroke(.white, lineWidth: 2))
                            .position(x: xPos, y: 50)
                    }
                }
            }
            .frame(height: 75)
        }
    }
}

struct ChildCard: View {
    let child: Child
    @AppStorage("appLanguage") private var selectedLanguage: AppLanguage = .romanian
    @AppStorage("reward100Name") private var reward100Name: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(child.name)
                        .font(.title3.bold())
                    Text("Nivel \(child.level)")
                        .font(.caption.bold())
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Text("\(child.points) pts")
                    .font(.headline)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.pink.opacity(0.1))
                    .clipShape(Capsule())
            }
            
            MilestoneProgressView(points: child.points)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top, spacing: 6) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.orange)
                        .font(.subheadline)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(selectedLanguage.translate("main_prize"))
                            .font(.caption.bold())
                            .foregroundStyle(.secondary)
                        
                        Text(reward100Name.isEmpty ? selectedLanguage.translate("reward_100_def") : reward100Name)
                            .font(.subheadline.bold())
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                
                let remaining = 100 - (child.points % 100)
                let actualRemaining = (remaining == 0 && child.points > 0) ? 0 : remaining
                Text("\(actualRemaining) \(selectedLanguage.translate("pts_until_prize"))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .italic()
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

// MARK: - Settings Tab
struct SettingsView: View {
    @AppStorage("appTheme") private var selectedTheme: AppTheme = .system
    @AppStorage("appLanguage") private var selectedLanguage: AppLanguage = .romanian
    
    @AppStorage("reward25Points") private var reward25Points: Int = 25
    @AppStorage("reward25Name") private var reward25Name: String = ""
    
    @AppStorage("reward50Points") private var reward50Points: Int = 50
    @AppStorage("reward50Name") private var reward50Name: String = ""
    
    @AppStorage("reward75Points") private var reward75Points: Int = 75
    @AppStorage("reward75Name") private var reward75Name: String = ""
    
    @AppStorage("reward100Name") private var reward100Name: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(selectedLanguage.translate("settings")) {
                    Picker(selectedLanguage.translate("theme"), selection: $selectedTheme) {
                        ForEach(AppTheme.allCases, id: \.self) { theme in
                            Text(selectedLanguage.translate(theme.rawValue)).tag(theme)
                        }
                    }
                    
                    Picker(selectedLanguage.translate("language"), selection: $selectedLanguage) {
                        ForEach(AppLanguage.allCases, id: \.self) { lang in
                            Text(lang.rawValue).tag(lang)
                        }
                    }
                }
                
                Section(selectedLanguage.translate("rewards_section")) {
                    milestoneEditor(pts: $reward25Points, name: $reward25Name, defKey: "reward_25_def")
                    milestoneEditor(pts: $reward50Points, name: $reward50Name, defKey: "reward_50_def")
                    milestoneEditor(pts: $reward75Points, name: $reward75Name, defKey: "reward_75_def")
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("100 pts (" + selectedLanguage.translate("main_prize") + ")")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        TextField(selectedLanguage.translate("reward_100_def"), text: $reward100Name)
                            .textFieldStyle(.roundedBorder)
                    }
                }
                
                Section("About") {
                    HStack {
                        Text(selectedLanguage.translate("version"))
                        Spacer()
                        Text("1.0.0 (Build 42)")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle(selectedLanguage.translate("settings"))
        }
    }
    
    private func milestoneEditor(pts: Binding<Int>, name: Binding<String>, defKey: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(pts.wrappedValue) pts")
                .font(.subheadline.bold())
            
            Picker("", selection: pts) {
                ForEach(1...99, id: \.self) { num in
                    Text("\(num)").tag(num)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 80)
            
            TextField(selectedLanguage.translate(defKey), text: name)
                .textFieldStyle(.roundedBorder)
        }
        .padding(.vertical, 4)
    }
}

struct TaskRow: View {
    let task: FamilyTask
    var onCheck: () -> Void
    
    var body: some View {
        HStack(spacing: 15) {
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.body.weight(.medium))
                Text("\(task.points) pts")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Button(action: onCheck) {
                Image(systemName: task.isCompletedToday ? "checkmark.circle.fill" : "circle")
                    .font(.title)
                    .foregroundStyle(task.isCompletedToday ? .green : .blue)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Child.self, FamilyTask.self], inMemory: true)
}

