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
        case .system: nil
        case .light: .light
        case .dark: .dark
        }
    }
}

enum AppLanguage: String, CaseIterable {
    case romanian = "Română"
    case english = "English"
    case german = "Deutsch"
    case french = "Français"
    case spanish = "Español"
    case italian = "Italiano"
    case portuguese = "Português"
    case polish = "Polski"
    case dutch = "Nederlands"

    var localeCode: String {
        switch self {
        case .romanian: "ro"
        case .english: "en"
        case .german: "de"
        case .french: "fr"
        case .spanish: "es"
        case .italian: "it"
        case .portuguese: "pt"
        case .polish: "pl"
        case .dutch: "nl"
        }
    }

    func translate(_ key: String) -> String {
        let translations: [String: [AppLanguage: String]] = [
            "home": [.romanian: "Acasă", .english: "Home", .german: "Start", .french: "Accueil", .spanish: "Inicio", .italian: "Home", .portuguese: "Início", .polish: "Start", .dutch: "Start"],
            "tasks": [.romanian: "Sarcini", .english: "Tasks", .german: "Aufgaben", .french: "Tâches", .spanish: "Tareas", .italian: "Attività", .portuguese: "Tarefas", .polish: "Zadania", .dutch: "Taken"],
            "settings": [.romanian: "Setări", .english: "Settings", .german: "Einstellungen", .french: "Réglages", .spanish: "Ajustes", .italian: "Impostazioni", .portuguese: "Definições", .polish: "Ustawienia", .dutch: "Instellingen"],
            "progress_title": [.romanian: "Astăzi în Familie", .english: "Today in Family", .german: "Heute in der Familie", .french: "Aujourd'hui en famille", .spanish: "Hoy en familia", .italian: "Oggi in famiglia", .portuguese: "Hoje em família", .polish: "Dziś w rodzinie", .dutch: "Vandaag in het gezin"],
            "dashboard_subtitle": [.romanian: "Vezi cine e aproape de recompensă și ce mai e de făcut.", .english: "See who is close to a reward and what is left for today.", .german: "Sieh, wer kurz vor einer Belohnung steht und was heute noch offen ist.", .french: "Vois qui est proche d'une récompense et ce qu'il reste à faire aujourd'hui.", .spanish: "Mira quién está cerca de una recompensa y qué queda por hacer hoy.", .italian: "Guarda chi è vicino a una ricompensa e cosa resta da fare oggi.", .portuguese: "Vê quem está perto de uma recompensa e o que falta fazer hoje.", .polish: "Zobacz, kto jest blisko nagrody i co zostało jeszcze do zrobienia dziś.", .dutch: "Zie wie dicht bij een beloning is en wat er vandaag nog moet gebeuren."],
            "daily_tasks": [.romanian: "Misiunile Zilei", .english: "Today's Missions", .german: "Aufgaben des Tages", .french: "Missions du jour", .spanish: "Misiones del día", .italian: "Missioni del giorno", .portuguese: "Missões do dia", .polish: "Misje dnia", .dutch: "Missies van vandaag"],
            "no_children": [.romanian: "Niciun copil adăugat", .english: "No children added", .german: "Keine Kinder hinzugefügt", .french: "Aucun enfant ajouté", .spanish: "No se ha añadido ningún niño", .italian: "Nessun bambino aggiunto", .portuguese: "Nenhuma criança adicionada", .polish: "Nie dodano dzieci", .dutch: "Geen kinderen toegevoegd"],
            "add_child_desc": [.romanian: "Adaugă primul copil și construiește rutina familiei.", .english: "Add the first child and start building the family routine.", .german: "Füge das erste Kind hinzu und starte die Familienroutine.", .french: "Ajoute le premier enfant et commence à construire la routine familiale.", .spanish: "Añade al primer niño y empieza a construir la rutina familiar.", .italian: "Aggiungi il primo bambino e inizia a creare la routine di famiglia.", .portuguese: "Adiciona a primeira criança e começa a criar a rotina da família.", .polish: "Dodaj pierwsze dziecko i zacznij budować rodzinną rutynę.", .dutch: "Voeg het eerste kind toe en begin met het opbouwen van de gezinsroutine."],
            "delete": [.romanian: "Șterge", .english: "Delete", .german: "Löschen", .french: "Supprimer", .spanish: "Eliminar", .italian: "Elimina", .portuguese: "Eliminar", .polish: "Usuń", .dutch: "Verwijderen"],
            "edit": [.romanian: "Editează", .english: "Edit", .german: "Bearbeiten", .french: "Modifier", .spanish: "Editar", .italian: "Modifica", .portuguese: "Editar", .polish: "Edytuj", .dutch: "Bewerken"],
            "theme": [.romanian: "Temă Aplicație", .english: "App Theme", .german: "App-Design", .french: "Thème de l'app", .spanish: "Tema de la app", .italian: "Tema app", .portuguese: "Tema da app", .polish: "Motyw aplikacji", .dutch: "App-thema"],
            "language": [.romanian: "Limbă", .english: "Language", .german: "Sprache", .french: "Langue", .spanish: "Idioma", .italian: "Lingua", .portuguese: "Idioma", .polish: "Język", .dutch: "Taal"],
            "add_child": [.romanian: "Adaugă Copil", .english: "Add Child", .german: "Kind hinzufügen", .french: "Ajouter un enfant", .spanish: "Añadir niño", .italian: "Aggiungi bambino", .portuguese: "Adicionar criança", .polish: "Dodaj dziecko", .dutch: "Kind toevoegen"],
            "edit_child": [.romanian: "Editează Copil", .english: "Edit Child", .german: "Kind bearbeiten", .french: "Modifier l'enfant", .spanish: "Editar niño", .italian: "Modifica bambino", .portuguese: "Editar criança", .polish: "Edytuj dziecko", .dutch: "Kind bewerken"],
            "add_task": [.romanian: "Adaugă Sarcină", .english: "Add Task", .german: "Aufgabe hinzufügen", .french: "Ajouter une tâche", .spanish: "Añadir tarea", .italian: "Aggiungi attività", .portuguese: "Adicionar tarefa", .polish: "Dodaj zadanie", .dutch: "Taak toevoegen"],
            "edit_task": [.romanian: "Editează Sarcină", .english: "Edit Task", .german: "Aufgabe bearbeiten", .french: "Modifier la tâche", .spanish: "Editar tarea", .italian: "Modifica attività", .portuguese: "Editar tarefa", .polish: "Edytuj zadanie", .dutch: "Taak bewerken"],
            "name": [.romanian: "Nume", .english: "Name", .german: "Name", .french: "Nom", .spanish: "Nombre", .italian: "Nome", .portuguese: "Nome", .polish: "Imię", .dutch: "Naam"],
            "save": [.romanian: "Salvează", .english: "Save", .german: "Speichern", .french: "Enregistrer", .spanish: "Guardar", .italian: "Salva", .portuguese: "Guardar", .polish: "Zapisz", .dutch: "Opslaan"],
            "cancel": [.romanian: "Anulează", .english: "Cancel", .german: "Abbrechen", .french: "Annuler", .spanish: "Cancelar", .italian: "Annulla", .portuguese: "Cancelar", .polish: "Anuluj", .dutch: "Annuleren"],
            "done": [.romanian: "Gata", .english: "Done", .german: "Fertig", .french: "Terminé", .spanish: "Listo", .italian: "Fatto", .portuguese: "Concluído", .polish: "Gotowe", .dutch: "Klaar"],
            "suggested": [.romanian: "Sugestii", .english: "Suggestions", .german: "Vorschläge", .french: "Suggestions", .spanish: "Sugerencias", .italian: "Suggerimenti", .portuguese: "Sugestões", .polish: "Sugestie", .dutch: "Suggesties"],
            "custom": [.romanian: "Personalizat", .english: "Custom", .german: "Benutzerdefiniert", .french: "Personnalisé", .spanish: "Personalizado", .italian: "Personalizzato", .portuguese: "Personalizado", .polish: "Własne", .dutch: "Aangepast"],
            "points": [.romanian: "Puncte", .english: "Points", .german: "Punkte", .french: "Points", .spanish: "Puntos", .italian: "Punti", .portuguese: "Pontos", .polish: "Punkty", .dutch: "Punten"],
            "main_prize": [.romanian: "Premiul surpriză", .english: "Surprise Prize", .german: "Überraschungspreis", .french: "Prix surprise", .spanish: "Premio sorpresa", .italian: "Premio sorpresa", .portuguese: "Prémio surpresa", .polish: "Nagroda niespodzianka", .dutch: "Verrassingsprijs"],
            "pts_until_prize": [.romanian: "puncte până la premiu", .english: "points to prize", .german: "Punkte bis zum Preis", .french: "points avant la récompense", .spanish: "puntos hasta el premio", .italian: "punti al premio", .portuguese: "pontos até ao prémio", .polish: "punktów do nagrody", .dutch: "punten tot prijs"],
            "select_child": [.romanian: "Alege Copilul", .english: "Select Child", .german: "Kind wählen", .french: "Choisir l'enfant", .spanish: "Elegir niño", .italian: "Scegli bambino", .portuguese: "Escolher criança", .polish: "Wybierz dziecko", .dutch: "Kies kind"],
            "rewards_section": [.romanian: "Configurare Milestones", .english: "Milestone Setup", .german: "Meilenstein-Konfiguration"],
            "milestones": [.romanian: "Milestones", .english: "Milestones", .german: "Meilensteine", .french: "Étapes", .spanish: "Hitos", .italian: "Traguardi", .portuguese: "Marcos", .polish: "Kamienie milowe", .dutch: "Mijlpalen"],
            "milestone_rewards": [.romanian: "Milestones și recompense", .english: "Milestones and rewards", .german: "Meilensteine und Belohnungen", .french: "Étapes et récompenses", .spanish: "Hitos y recompensas", .italian: "Traguardi e ricompense", .portuguese: "Marcos e recompensas", .polish: "Kamienie milowe i nagrody", .dutch: "Mijlpalen en beloningen"],
            "final_milestone": [.romanian: "Milestone final", .english: "Final milestone", .german: "Finaler Meilenstein", .french: "Étape finale", .spanish: "Hito final", .italian: "Traguardo finale", .portuguese: "Marco final", .polish: "Finałowy kamień milowy", .dutch: "Laatste mijlpaal"],
            "reward_cycle_hint": [.romanian: "Milestone-urile se resetează vizual la fiecare 100 de puncte, dar punctele totale rămân.", .english: "Milestones reset visually every 100 points, but total points stay accumulated.", .german: "Meilensteine starten visuell alle 100 Punkte neu, aber die Gesamtpunkte bleiben erhalten.", .french: "Les étapes se réinitialisent visuellement tous les 100 points, mais le total reste cumulé.", .spanish: "Los hitos se reinician visualmente cada 100 puntos, pero el total sigue acumulado.", .italian: "I traguardi si azzerano visivamente ogni 100 punti, ma il totale resta accumulato.", .portuguese: "Os marcos reiniciam visualmente a cada 100 pontos, mas o total continua acumulado.", .polish: "Kamienie milowe resetują się wizualnie co 100 punktów, ale suma punktów pozostaje.", .dutch: "Mijlpalen starten visueel opnieuw bij elke 100 punten, maar het totaal aantal punten blijft behouden."],
            "reward_25_def": [.romanian: "Înghețată", .english: "Ice Cream", .german: "Eiscreme", .french: "Glace", .spanish: "Helado", .italian: "Gelato", .portuguese: "Gelado", .polish: "Lody", .dutch: "IJsje"],
            "reward_50_def": [.romanian: "Film", .english: "Movie", .german: "Film", .french: "Film", .spanish: "Película", .italian: "Film", .portuguese: "Filme", .polish: "Film", .dutch: "Film"],
            "reward_75_def": [.romanian: "Jucărie", .english: "Toy", .german: "Spielzeug", .french: "Jouet", .spanish: "Juguete", .italian: "Giocattolo", .portuguese: "Brinquedo", .polish: "Zabawka", .dutch: "Speelgoed"],
            "reward_100_def": [.romanian: "Cofetărie Sibiu", .english: "Pastry Shop", .german: "Konditorei", .french: "Pâtisserie", .spanish: "Pastelería", .italian: "Pasticceria", .portuguese: "Pastelaria", .polish: "Cukiernia", .dutch: "Banketbakkerij"],
            "theme_system": [.romanian: "Sistem", .english: "System", .german: "System", .french: "Système", .spanish: "Sistema", .italian: "Sistema", .portuguese: "Sistema", .polish: "System", .dutch: "Systeem"],
            "theme_light": [.romanian: "Luminos", .english: "Light", .german: "Hell", .french: "Clair", .spanish: "Claro", .italian: "Chiaro", .portuguese: "Claro", .polish: "Jasny", .dutch: "Licht"],
            "theme_dark": [.romanian: "Întunecat", .english: "Dark", .german: "Dunkel", .french: "Sombre", .spanish: "Oscuro", .italian: "Scuro", .portuguese: "Escuro", .polish: "Ciemny", .dutch: "Donker"],
            "task_backpack": [.romanian: "Preparat ghiozdan", .english: "Pack backpack", .german: "Rucksack packen", .french: "Préparer le sac", .spanish: "Preparar mochila", .italian: "Preparare lo zaino", .portuguese: "Preparar mochila", .polish: "Spakować plecak", .dutch: "Rugzak inpakken"],
            "task_table": [.romanian: "Strâns masa", .english: "Clear the table", .german: "Tisch abräumen", .french: "Débarrasser la table", .spanish: "Recoger la mesa", .italian: "Sgomberare la tavola", .portuguese: "Levantar a mesa", .polish: "Posprzątać stół", .dutch: "Tafel afruimen"],
            "task_teeth": [.romanian: "Spălat pe dinți", .english: "Brush teeth", .german: "Zähne putzen", .french: "Se brosser les dents", .spanish: "Cepillarse los dientes", .italian: "Lavarsi i denti", .portuguese: "Lavar os dentes", .polish: "Umyć zęby", .dutch: "Tanden poetsen"],
            "task_room": [.romanian: "Curățenie în cameră", .english: "Clean room", .german: "Zimmer aufräumen", .french: "Ranger la chambre", .spanish: "Ordenar la habitación", .italian: "Riordinare la stanza", .portuguese: "Arrumar o quarto", .polish: "Posprzątać pokój", .dutch: "Kamer opruimen"],
            "task_bed": [.romanian: "Strâns patul", .english: "Make the bed", .german: "Bett machen", .french: "Faire le lit", .spanish: "Hacer la cama", .italian: "Fare il letto", .portuguese: "Fazer a cama", .polish: "Pościelić łóżko", .dutch: "Bed opmaken"],
            "task_homework": [.romanian: "Teme", .english: "Homework", .german: "Hausaufgaben", .french: "Devoirs", .spanish: "Deberes", .italian: "Compiti", .portuguese: "Trabalhos de casa", .polish: "Praca domowa", .dutch: "Huiswerk"],
            "version": [.romanian: "Versiune", .english: "Version", .german: "Version", .french: "Version", .spanish: "Versión", .italian: "Versione", .portuguese: "Versão", .polish: "Wersja", .dutch: "Versie"],
            "about": [.romanian: "Despre", .english: "About", .german: "Über", .french: "À propos", .spanish: "Acerca de", .italian: "Info", .portuguese: "Sobre", .polish: "O aplikacji", .dutch: "Over"],
            "family_overview": [.romanian: "Panoramă familie", .english: "Family Overview", .german: "Familienübersicht"],
            "active_children": [.romanian: "Copii activi", .english: "Active children", .german: "Aktive Kinder"],
            "total_points": [.romanian: "Puncte totale", .english: "Total points", .german: "Gesamtpunkte"],
            "completed_today": [.romanian: "Completate azi", .english: "Completed today", .german: "Heute erledigt"],
            "journey": [.romanian: "Drumul spre premiu", .english: "Journey to Reward", .german: "Weg zur Belohnung", .french: "Chemin vers la récompense", .spanish: "Camino a la recompensa", .italian: "Percorso verso la ricompensa", .portuguese: "Caminho para o prémio", .polish: "Droga do nagrody", .dutch: "Pad naar beloning"],
            "today_focus": [.romanian: "Focus azi", .english: "Today's Focus", .german: "Heutiger Fokus", .french: "Focus du jour", .spanish: "Enfoque de hoy", .italian: "Focus di oggi", .portuguese: "Foco de hoje", .polish: "Dzisiejszy fokus", .dutch: "Focus van vandaag"],
            "all_done_today": [.romanian: "Totul e bifat azi", .english: "Everything is done today", .german: "Heute ist alles erledigt", .french: "Tout est fait aujourd'hui", .spanish: "Todo está hecho hoy", .italian: "Oggi è tutto fatto", .portuguese: "Tudo feito hoje", .polish: "Wszystko gotowe na dziś", .dutch: "Alles is vandaag gedaan"],
            "tasks_left": [.romanian: "sarcini rămase", .english: "tasks left", .german: "Aufgaben offen", .french: "tâches restantes", .spanish: "tareas restantes", .italian: "attività rimaste", .portuguese: "tarefas em falta", .polish: "zadań pozostało", .dutch: "taken over"],
            "ready_for_next_reward": [.romanian: "Aproape de următorul reward", .english: "Close to the next reward", .german: "Nah an der nächsten Belohnung"],
            "create_first_task": [.romanian: "Adaugă prima misiune pentru acest copil.", .english: "Add the first mission for this child.", .german: "Füge die erste Aufgabe für dieses Kind hinzu."],
            "task_library": [.romanian: "Biblioteca de Sarcini", .english: "Task Library", .german: "Aufgabenbibliothek", .french: "Bibliothèque de tâches", .spanish: "Biblioteca de tareas", .italian: "Libreria attività", .portuguese: "Biblioteca de tarefas", .polish: "Biblioteka zadań", .dutch: "Takenbibliotheek"],
            "daily_rhythm": [.romanian: "Construiește ritmul zilnic și acordă puncte instant.", .english: "Build the daily rhythm and award points instantly.", .german: "Baue den Tagesrhythmus auf und vergebe sofort Punkte.", .french: "Construis le rythme quotidien et attribue les points instantanément.", .spanish: "Construye el ritmo diario y asigna puntos al instante.", .italian: "Crea il ritmo quotidiano e assegna punti subito.", .portuguese: "Constrói o ritmo diário e atribui pontos de imediato.", .polish: "Buduj codzienny rytm i przyznawaj punkty od razu.", .dutch: "Bouw het dagelijkse ritme op en geef direct punten."],
            "today_status": [.romanian: "Status azi", .english: "Today status", .german: "Status heute", .french: "Statut du jour", .spanish: "Estado de hoy", .italian: "Stato di oggi", .portuguese: "Estado de hoje", .polish: "Status na dziś", .dutch: "Status van vandaag"],
            "reward_preview": [.romanian: "Preview recompense", .english: "Reward preview", .german: "Belohnungsvorschau"],
            "visual_style": [.romanian: "Aspect", .english: "Appearance", .german: "Darstellung", .french: "Apparence", .spanish: "Apariencia", .italian: "Aspetto", .portuguese: "Aspeto", .polish: "Wygląd", .dutch: "Weergave"],
            "family_rewards": [.romanian: "Reward-uri familie", .english: "Family rewards", .german: "Familienbelohnungen"],
            "experience": [.romanian: "Experiență", .english: "Experience", .german: "Erlebnis"],
            "smart_defaults": [.romanian: "Setările se aplică imediat pentru toți copiii.", .english: "Settings apply instantly for every child.", .german: "Die Einstellungen gelten sofort für alle Kinder."],
            "empty_tasks_title": [.romanian: "Nicio misiune încă", .english: "No missions yet", .german: "Noch keine Aufgaben", .french: "Aucune mission pour l'instant", .spanish: "Todavía no hay misiones", .italian: "Nessuna missione ancora", .portuguese: "Ainda sem missões", .polish: "Jeszcze brak misji", .dutch: "Nog geen missies"],
            "level": [.romanian: "Nivel", .english: "Level", .german: "Level", .french: "Niveau", .spanish: "Nivel", .italian: "Livello", .portuguese: "Nível", .polish: "Poziom", .dutch: "Niveau"],
            "today": [.romanian: "Azi", .english: "Today", .german: "Heute", .french: "Aujourd'hui", .spanish: "Hoy", .italian: "Oggi", .portuguese: "Hoje", .polish: "Dziś", .dutch: "Vandaag"],
            "streak": [.romanian: "Streak", .english: "Streak", .german: "Streak", .french: "Série", .spanish: "Racha", .italian: "Serie", .portuguese: "Sequência", .polish: "Seria", .dutch: "Reeks"],
            "best_streak": [.romanian: "Cel mai bun streak", .english: "Best streak", .german: "Bester Streak", .french: "Meilleure série", .spanish: "Mejor racha", .italian: "Miglior serie", .portuguese: "Melhor sequência", .polish: "Najlepsza seria", .dutch: "Beste reeks"],
            "claim": [.romanian: "Revendică", .english: "Claim", .german: "Einlösen", .french: "Réclamer", .spanish: "Reclamar", .italian: "Riscatta", .portuguese: "Reclamar", .polish: "Odbierz", .dutch: "Claimen"],
            "claimed": [.romanian: "Revendicat", .english: "Claimed", .german: "Eingelöst", .french: "Réclamé", .spanish: "Reclamado", .italian: "Riscattato", .portuguese: "Reclamado", .polish: "Odebrane", .dutch: "Geclaimd"],
            "reward_ready": [.romanian: "Reward gata", .english: "Reward ready", .german: "Belohnung bereit"],
            "rewards_ready": [.romanian: "Reward-uri gata", .english: "Rewards ready", .german: "Belohnungen bereit"],
            "avatar": [.romanian: "Avatar", .english: "Avatar", .german: "Avatar"],
            "choose_avatar": [.romanian: "Alege un avatar pentru copil.", .english: "Choose an avatar for the child.", .german: "Wähle einen Avatar für das Kind."],
            "reward_claimed_flash": [.romanian: "Reward revendicat", .english: "Reward claimed", .german: "Belohnung eingelöst"],
            "days": [.romanian: "zile", .english: "days", .german: "Tage"],
            "family_snapshot": [.romanian: "Snapshot familie", .english: "Family snapshot", .german: "Familien-Snapshot"],
            "ready_to_claim": [.romanian: "Gata de revendicat", .english: "Ready to claim", .german: "Bereit zum Einlösen"],
            "no_rewards_ready": [.romanian: "Niciun reward gata încă.", .english: "No rewards are ready yet.", .german: "Noch keine Belohnung bereit."],
            "settings_compact_hint": [.romanian: "Păstrează doar lucrurile pe care chiar le schimbi des.", .english: "Keep only the controls you actually change often.", .german: "Behalte nur die Einstellungen, die du oft änderst."],
            "main_reward": [.romanian: "Premiu principal", .english: "Main reward", .german: "Hauptbelohnung"]
        ]
        return translations[key]?[self] ?? translations[key]?[.english] ?? key
    }
}

struct ContentView: View {
    @AppStorage("appTheme") private var selectedTheme: AppTheme = .system
    @AppStorage("appLanguage") private var selectedLanguage: AppLanguage = .romanian

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label(selectedLanguage.translate("home"), systemImage: "sparkles.rectangle.stack.fill")
                }

            TasksView()
                .tabItem {
                    Label(selectedLanguage.translate("tasks"), systemImage: "checklist.checked")
                }

            SettingsView()
                .tabItem {
                    Label(selectedLanguage.translate("settings"), systemImage: "slider.horizontal.3")
                }
        }
        .preferredColorScheme(selectedTheme.colorScheme)
        .environment(\.locale, .init(identifier: selectedLanguage.localeCode))
    }
}

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("appLanguage") private var selectedLanguage: AppLanguage = .romanian
    @AppStorage("reward25Points") private var reward25Points: Int = 25
    @AppStorage("reward25Name") private var reward25Name: String = ""
    @AppStorage("reward50Points") private var reward50Points: Int = 50
    @AppStorage("reward50Name") private var reward50Name: String = ""
    @AppStorage("reward75Points") private var reward75Points: Int = 75
    @AppStorage("reward75Name") private var reward75Name: String = ""
    @AppStorage("reward100Name") private var reward100Name: String = ""
    @Query(sort: \Child.name) private var children: [Child]

    @State private var isShowingAddChild = false
    @State private var newChildName = ""
    @State private var selectedAvatarSymbol = FamilyAvatarCatalog.symbols.first ?? "star.fill"
    @State private var editingChildID: PersistentIdentifier?
    @State private var editingChildName = ""
    @State private var editingAvatarSymbol = FamilyAvatarCatalog.symbols.first ?? "star.fill"

    private var totalPoints: Int {
        children.reduce(0) { $0 + $1.points }
    }

    private var totalTasks: Int {
        children.reduce(0) { $0 + $1.tasks.count }
    }

    private var completedToday: Int {
        children.reduce(0) { partial, child in
            partial + child.tasks.filter(\.isCompletedToday).count
        }
    }

    private var leadChild: Child? {
        children.max(by: { lhs, rhs in
            lhs.progressToNextReward < rhs.progressToNextReward
        })
    }

    private var rewardDefinitions: [RewardDefinition] {
        [
            RewardDefinition(points: reward25Points, name: reward25Name.isEmpty ? selectedLanguage.translate("reward_25_def") : reward25Name),
            RewardDefinition(points: reward50Points, name: reward50Name.isEmpty ? selectedLanguage.translate("reward_50_def") : reward50Name),
            RewardDefinition(points: reward75Points, name: reward75Name.isEmpty ? selectedLanguage.translate("reward_75_def") : reward75Name),
            RewardDefinition(points: 100, name: reward100Name.isEmpty ? selectedLanguage.translate("reward_100_def") : reward100Name)
        ]
        .sorted(by: { $0.points < $1.points })
    }

    var body: some View {
        NavigationStack {
            ZStack {
                FamilyBackground()
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        heroSection

                        if children.isEmpty {
                            emptyState
                        } else {
                            summarySection
                            focusSection
                            rewardsReadySection
                            journeySection
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 32)
                }
            }
            .navigationTitle(selectedLanguage.translate("today"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingAddChild = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3.weight(.semibold))
                    }
                }
            }
            .sheet(isPresented: $isShowingAddChild) {
                AddChildSheet(
                    newChildName: $newChildName,
                    selectedAvatarSymbol: $selectedAvatarSymbol,
                    saveAction: saveChild
                )
            }
            .sheet(item: $editingChildID) { childID in
                EditChildSheet(
                    childName: $editingChildName,
                    selectedAvatarSymbol: $editingAvatarSymbol,
                    saveAction: {
                        saveChildEdits(for: childID)
                    }
                )
            }
        }
    }

    private var heroSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(selectedLanguage.translate("progress_title"))
                .font(.system(size: 34, weight: .black, design: .rounded))
                .foregroundStyle(.primary)

            Text(selectedLanguage.translate("dashboard_subtitle"))
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)

            if let leadChild {
                HighlightBanner(child: leadChild, rewardDefinitions: rewardDefinitions)
            }
        }
    }

    private var summarySection: some View {
        CompactSummaryStrip(
            title: selectedLanguage.translate("family_snapshot"),
            value: "\(children.count) • \(totalPoints) pts • \(completedToday)/\(totalTasks)"
        )
    }

    private var focusSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(selectedLanguage.translate("today_focus"))
                .font(.headline.weight(.bold))

            ForEach(children) { child in
                DailyFocusCard(child: child)
                    .contextMenu {
                        Button {
                            beginEditing(child)
                        } label: {
                            Label(selectedLanguage.translate("edit_child"), systemImage: "pencil")
                        }

                        Button(role: .destructive) {
                            modelContext.delete(child)
                            try? modelContext.save()
                        } label: {
                            Label(selectedLanguage.translate("delete"), systemImage: "trash")
                        }
                    }
            }
        }
    }

    private var rewardsReadySection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(selectedLanguage.translate("ready_to_claim"))
                .font(.headline.weight(.bold))

            let readyItems = children.flatMap { child in
                child.availableRewards(using: rewardDefinitions).map { reward in
                    (child, reward)
                }
            }

            if readyItems.isEmpty {
                CompactSummaryStrip(
                    title: selectedLanguage.translate("reward_ready"),
                    value: selectedLanguage.translate("no_rewards_ready")
                )
            } else {
                ForEach(Array(readyItems.enumerated()), id: \.offset) { _, item in
                    RewardReadyRow(
                        child: item.0,
                        reward: item.1,
                        claimLabel: selectedLanguage.translate("claim")
                    ) {
                        claimReward(item.1, for: item.0)
                    }
                }
            }
        }
    }

    private var journeySection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(selectedLanguage.translate("journey"))
                .font(.headline.weight(.bold))

            ForEach(children) { child in
                ChildJourneyCard(child: child, rewardDefinitions: rewardDefinitions) {
                    beginEditing(child)
                }
                    .contextMenu {
                        Button {
                            beginEditing(child)
                        } label: {
                            Label(selectedLanguage.translate("edit_child"), systemImage: "pencil")
                        }

                        Button(role: .destructive) {
                            modelContext.delete(child)
                            try? modelContext.save()
                        } label: {
                            Label(selectedLanguage.translate("delete"), systemImage: "trash")
                        }
                    }
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "person.2.badge.plus")
                .font(.system(size: 48))
                .foregroundStyle(AppPalette.softAmber)

            Text(selectedLanguage.translate("no_children"))
                .font(.title3.bold())

            Text(selectedLanguage.translate("add_child_desc"))
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Button {
                isShowingAddChild = true
            } label: {
                Label(selectedLanguage.translate("add_child"), systemImage: "plus.circle.fill")
                    .font(.headline)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(
                        Capsule()
                            .fill(AppPalette.primarySoftGradient)
                    )
                    .foregroundStyle(.white)
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity)
        .padding(28)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 28, style: .continuous))
    }

    private func saveChild() {
        let trimmedName = newChildName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }

        let newChild = Child(
            name: trimmedName,
            avatarSymbol: selectedAvatarSymbol,
            avatarColorIndex: FamilyAvatarCatalog.symbols.firstIndex(of: selectedAvatarSymbol) ?? 0
        )
        modelContext.insert(newChild)
        try? modelContext.save()
        isShowingAddChild = false
        newChildName = ""
        selectedAvatarSymbol = FamilyAvatarCatalog.nextSymbol(after: selectedAvatarSymbol)
    }

    private func claimReward(_ reward: RewardDefinition, for child: Child) {
        guard child.canClaim(reward: reward) else { return }
        child.markRewardClaimed(reward)
        try? modelContext.save()
    }

    private func beginEditing(_ child: Child) {
        editingChildName = child.name
        editingAvatarSymbol = child.avatarSymbol
        editingChildID = child.id
    }

    private func saveChildEdits(for childID: PersistentIdentifier) {
        let trimmedName = editingChildName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty,
              let child = modelContext.model(for: childID) as? Child else { return }

        child.name = trimmedName
        child.avatarSymbol = editingAvatarSymbol
        child.avatarColorIndex = FamilyAvatarCatalog.symbols.firstIndex(of: editingAvatarSymbol) ?? child.avatarColorIndex
        try? modelContext.save()

        editingChildID = nil
        editingChildName = ""
        editingAvatarSymbol = FamilyAvatarCatalog.symbols.first ?? "star.fill"
    }
}

struct TasksView: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("appLanguage") private var selectedLanguage: AppLanguage = .romanian
    @Query(sort: \Child.name) private var children: [Child]

    @State private var selectedChildID: PersistentIdentifier?
    @State private var isShowingAddTask = false
    @State private var editingTaskID: PersistentIdentifier?

    private var selectedChild: Child? {
        children.first(where: { $0.id == selectedChildID })
    }

    var body: some View {
        NavigationStack {
            ZStack {
                FamilyBackground()
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        taskHeader

                        if children.isEmpty {
                            emptyTaskState
                        } else {
                            childPickerSection
                            if let selectedChild {
                                taskStatusCard(for: selectedChild)
                                taskListSection(for: selectedChild)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 32)
                }
            }
            .navigationTitle(selectedLanguage.translate("tasks"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingAddTask = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3.weight(.semibold))
                    }
                    .disabled(selectedChildID == nil)
                }
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
            .onChange(of: children.count) { _, _ in
                if selectedChildID == nil {
                    selectedChildID = children.first?.id
                }
            }
        }
    }

    private var taskHeader: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(selectedLanguage.translate("task_library"))
                .font(.system(size: 32, weight: .black, design: .rounded))
            Text(selectedLanguage.translate("daily_rhythm"))
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)
        }
    }

    private var emptyTaskState: some View {
        VStack(spacing: 16) {
            Image(systemName: "tray.and.arrow.up.fill")
                .font(.system(size: 44))
                .foregroundStyle(AppPalette.deepSlate)

            Text(selectedLanguage.translate("no_children"))
                .font(.title3.bold())

            Text(selectedLanguage.translate("add_child_desc"))
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(28)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 28, style: .continuous))
    }

    private var childPickerSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(children) { child in
                    Button {
                        selectedChildID = child.id
                    } label: {
                        HStack(spacing: 8) {
                            Circle()
                                .fill(child.accentGradient)
                                .frame(width: 10, height: 10)
                            Text(child.name)
                                .font(.subheadline.weight(.bold))
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(
                            Capsule()
                                .fill(child.id == selectedChildID ? AnyShapeStyle(child.accentGradient) : AnyShapeStyle(Color(.secondarySystemBackground)))
                        )
                        .foregroundStyle(child.id == selectedChildID ? .white : .primary)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private func taskStatusCard(for child: Child) -> some View {
        let completedCount = child.completedTasksToday
        let totalCount = child.tasks.count

        return VStack(alignment: .leading, spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(selectedLanguage.translate("today_status"))
                        .font(.headline.bold())
                    Text(child.name)
                        .font(.title3.weight(.black))
                }

                Spacer()

                Text("\(completedCount)/\(totalCount)")
                    .font(.title2.weight(.black))
            }

            ProgressView(value: totalCount == 0 ? 0 : Double(completedCount), total: Double(max(totalCount, 1)))
                .tint(.white)

            Text(totalCount == completedCount && totalCount > 0
                 ? selectedLanguage.translate("all_done_today")
                 : "\(max(totalCount - completedCount, 0)) \(selectedLanguage.translate("tasks_left"))")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.white.opacity(0.9))
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(child.accentGradient)
        )
        .foregroundStyle(.white)
    }

    private func taskListSection(for child: Child) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            if child.tasks.isEmpty {
                VStack(spacing: 10) {
                    Text(selectedLanguage.translate("empty_tasks_title"))
                        .font(.headline.bold())
                    Text(selectedLanguage.translate("create_first_task"))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(28)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
            } else {
                ForEach(child.sortedTasks) { task in
                    TaskCard(task: task) {
                        toggleTask(task)
                    }
                    .contextMenu {
                        Button {
                            editingTaskID = task.id
                        } label: {
                            Label(selectedLanguage.translate("edit"), systemImage: "pencil")
                        }

                        Button(role: .destructive) {
                            modelContext.delete(task)
                            try? modelContext.save()
                        } label: {
                            Label(selectedLanguage.translate("delete"), systemImage: "trash")
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            modelContext.delete(task)
                            try? modelContext.save()
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

    private func toggleTask(_ task: FamilyTask) {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
            if task.isCompletedToday {
                task.lastCompletedDate = nil
                if let child = task.child {
                    child.points = max(0, child.points - task.points)
                    if !child.hasCompletedTaskToday(excluding: task) {
                        child.removeCompletion(for: Date())
                    }
                }
            } else {
                task.lastCompletedDate = Date()
                task.child?.points += task.points
                if let child = task.child {
                    child.registerCompletion(on: Date())
                }
            }
            try? modelContext.save()
        }
    }
}

struct AddTaskSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @AppStorage("appLanguage") private var selectedLanguage: AppLanguage = .romanian

    let childID: PersistentIdentifier

    @State private var customTitle = ""
    @State private var customPoints = 10
    @State private var selectedSuggestionKeys: Set<String> = []
    @State private var suggestionPoints: [String: Int] = [:]

    struct SuggestedTask: Identifiable {
        var id: String { titleKey }
        let titleKey: String
        let defaultPoints: Int
    }

    let suggestions: [SuggestedTask] = [
        SuggestedTask(titleKey: "task_backpack", defaultPoints: 10),
        SuggestedTask(titleKey: "task_table", defaultPoints: 5),
        SuggestedTask(titleKey: "task_teeth", defaultPoints: 5),
        SuggestedTask(titleKey: "task_room", defaultPoints: 20),
        SuggestedTask(titleKey: "task_bed", defaultPoints: 5),
        SuggestedTask(titleKey: "task_homework", defaultPoints: 15)
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                FamilyBackground()
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 18) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(selectedLanguage.translate("suggested"))
                                .font(.headline.bold())

                            ForEach(suggestions) { suggestion in
                                SuggestionRow(
                                    title: selectedLanguage.translate(suggestion.titleKey),
                                    points: bindingForSuggestionPoints(suggestion),
                                    isSelected: selectedSuggestionKeys.contains(suggestion.titleKey)
                                ) {
                                    if selectedSuggestionKeys.contains(suggestion.titleKey) {
                                        selectedSuggestionKeys.remove(suggestion.titleKey)
                                    } else {
                                        selectedSuggestionKeys.insert(suggestion.titleKey)
                                    }
                                }
                            }
                        }
                        .padding(20)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 28, style: .continuous))

                        VStack(alignment: .leading, spacing: 14) {
                            Text(selectedLanguage.translate("custom"))
                                .font(.headline.bold())

                            TextField(selectedLanguage.translate("name"), text: $customTitle)
                                .textFieldStyle(.roundedBorder)

                            VStack(alignment: .leading, spacing: 8) {
                                Text("\(selectedLanguage.translate("points")): \(customPoints)")
                                    .font(.caption.bold())
                                    .foregroundStyle(.secondary)
                                Picker("", selection: $customPoints) {
                                    ForEach(1...100, id: \.self) { value in
                                        Text("\(value)").tag(value)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(height: 110)
                            }

                            Button {
                                addCustomTask()
                            } label: {
                                Label(selectedLanguage.translate("save"), systemImage: "plus")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(FamilyPrimaryButtonStyle(colors: AppPalette.secondaryButtonColors))
                            .disabled(customTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        }
                        .padding(20)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 28, style: .continuous))
                    }
                    .padding(20)
                }
            }
            .navigationTitle(selectedLanguage.translate("add_task"))
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if suggestionPoints.isEmpty {
                    suggestionPoints = Dictionary(
                        uniqueKeysWithValues: suggestions.map { ($0.titleKey, $0.defaultPoints) }
                    )
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(selectedLanguage.translate("cancel")) {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
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
            guard let suggestion = suggestions.first(where: { $0.titleKey == key }) else { continue }
            let newTask = FamilyTask(
                title: selectedLanguage.translate(suggestion.titleKey),
                points: suggestionPoints[key] ?? suggestion.defaultPoints,
                emoji: ""
            )
            newTask.child = child
            modelContext.insert(newTask)
        }

        try? modelContext.save()
        dismiss()
    }

    private func addCustomTask() {
        guard let child = modelContext.model(for: childID) as? Child else { return }

        let trimmedTitle = customTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else { return }

        let newTask = FamilyTask(title: trimmedTitle, points: customPoints, emoji: "")
        newTask.child = child
        modelContext.insert(newTask)
        try? modelContext.save()
        customTitle = ""
        customPoints = 10
    }

    private func bindingForSuggestionPoints(_ suggestion: SuggestedTask) -> Binding<Int> {
        Binding(
            get: { suggestionPoints[suggestion.titleKey] ?? suggestion.defaultPoints },
            set: { suggestionPoints[suggestion.titleKey] = min(max($0, 1), 100) }
        )
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
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
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
        guard let task = modelContext.model(for: taskID) as? FamilyTask else { return }

        task.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        task.points = points
        try? modelContext.save()
    }
}

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
        ]
        .sorted(by: { $0.points < $1.points })
    }

    var currentProgress: Double {
        let currentLevelPoints = points % 100
        if points > 0, currentLevelPoints == 0 {
            return 1.0
        }
        return Double(currentLevelPoints) / 100.0
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            GeometryReader { geometry in
                let width = geometry.size.width
                let markerWidth: CGFloat = 28
                let barY: CGFloat = 18

                ZStack(alignment: .topLeading) {
                    Capsule()
                        .fill(Color.white.opacity(0.14))
                        .frame(height: 12)
                        .offset(y: barY)

                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: AppPalette.progressColors,
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: width * currentProgress, height: 12)
                        .offset(y: barY)

                    ForEach(milestones) { milestone in
                        let cyclePoints = points > 0 && points % 100 == 0 ? 100 : points % 100
                        let isReached = milestone.points <= cyclePoints
                        let ratio = CGFloat(milestone.points) / 100
                        let x = min(max(width * ratio, markerWidth / 2), width - markerWidth / 2)

                        Circle()
                            .fill(isReached ? .white : .white.opacity(0.35))
                            .frame(width: milestone.points == 100 ? 14 : 12, height: milestone.points == 100 ? 14 : 12)
                            .overlay {
                                Circle()
                                    .stroke(.white.opacity(isReached ? 0.0 : 0.25), lineWidth: 1)
                            }
                        .frame(width: markerWidth)
                        .position(x: x, y: barY + 4)
                    }
                }
            }
            .frame(height: 34)

            GeometryReader { geometry in
                let width = geometry.size.width
                let labelWidth: CGFloat = 30

                ZStack(alignment: .topLeading) {
                    ForEach(milestones) { milestone in
                        let ratio = CGFloat(milestone.points) / 100
                        let x = min(max(width * ratio, labelWidth / 2), width - labelWidth / 2)

                        Text("\(milestone.points)")
                            .font(.caption2.weight(milestone.points == 100 ? .black : .semibold))
                            .foregroundStyle(.white.opacity(milestone.points == 100 ? 1 : 0.72))
                            .frame(width: labelWidth)
                            .position(x: x, y: 8)
                    }
                }
            }
            .frame(height: 16)
        }
    }
}

struct SettingsView: View {
    @Environment(\.colorScheme) private var colorScheme
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
            ZStack {
                FamilyBackground()
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(selectedLanguage.translate("experience"))
                                .font(.system(size: 32, weight: .black, design: .rounded))
                            Text(selectedLanguage.translate("settings_compact_hint"))
                                .font(.subheadline.weight(.medium))
                                .foregroundStyle(.secondary)
                        }

                        settingsCard {
                            VStack(alignment: .leading, spacing: 14) {
                                Text(selectedLanguage.translate("visual_style"))
                                    .font(.headline.bold())

                                Picker(selectedLanguage.translate("theme"), selection: $selectedTheme) {
                                    ForEach(AppTheme.allCases, id: \.self) { theme in
                                        Text(selectedLanguage.translate(theme.rawValue)).tag(theme)
                                    }
                                }
                                .pickerStyle(.segmented)

                                Divider()

                                HStack {
                                    Text(selectedLanguage.translate("language"))
                                        .font(.subheadline.weight(.semibold))
                                    Spacer()
                                    Picker(selectedLanguage.translate("language"), selection: $selectedLanguage) {
                                        ForEach(AppLanguage.allCases, id: \.self) { language in
                                            Text(language.rawValue).tag(language)
                                        }
                                    }
                                    .pickerStyle(.menu)
                                }
                            }
                        }

                        settingsCard {
                            VStack(alignment: .leading, spacing: 14) {
                                Text(selectedLanguage.translate("milestone_rewards"))
                                    .font(.headline.bold())

                                Text(selectedLanguage.translate("reward_cycle_hint"))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)

                                MilestoneEditorRow(
                                    title: selectedLanguage.translate("milestones"),
                                    points: $reward25Points,
                                    rewardName: $reward25Name,
                                    placeholder: selectedLanguage.translate("reward_25_def"),
                                    range: 1...97
                                )

                                MilestoneEditorRow(
                                    title: selectedLanguage.translate("milestones"),
                                    points: $reward50Points,
                                    rewardName: $reward50Name,
                                    placeholder: selectedLanguage.translate("reward_50_def"),
                                    range: 2...98
                                )

                                MilestoneEditorRow(
                                    title: selectedLanguage.translate("milestones"),
                                    points: $reward75Points,
                                    rewardName: $reward75Name,
                                    placeholder: selectedLanguage.translate("reward_75_def"),
                                    range: 3...99
                                )

                                FinalMilestoneRow(
                                    title: selectedLanguage.translate("final_milestone"),
                                    rewardName: $reward100Name,
                                    placeholder: selectedLanguage.translate("reward_100_def")
                                )
                            }
                        }

                        settingsCard {
                            HStack {
                                Text(selectedLanguage.translate("version"))
                                Spacer()
                                Text("1.0.0 (Build 42)")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .padding(20)
                }
            }
            .navigationTitle(selectedLanguage.translate("settings"))
            .onAppear(perform: normalizeMilestones)
            .onChange(of: reward25Points) { _, _ in normalizeMilestones() }
            .onChange(of: reward50Points) { _, _ in normalizeMilestones() }
            .onChange(of: reward75Points) { _, _ in normalizeMilestones() }
        }
    }

    private func settingsCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        content()
            .padding(18)
            .background(settingsCardBackground, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .strokeBorder(settingsCardStroke, lineWidth: 1)
            }
    }

    private var settingsCardBackground: AnyShapeStyle {
        if colorScheme == .dark {
            return AnyShapeStyle(Color.white.opacity(0.055))
        }
        return AnyShapeStyle(.ultraThinMaterial)
    }

    private var settingsCardStroke: Color {
        colorScheme == .dark ? Color.white.opacity(0.08) : Color.white.opacity(0.28)
    }

    private func normalizeMilestones() {
        reward25Points = min(max(reward25Points, 1), 97)
        reward50Points = min(max(reward50Points, reward25Points + 1), 98)
        reward75Points = min(max(reward75Points, reward50Points + 1), 99)
    }
}

struct AddChildSheet: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("appLanguage") private var selectedLanguage: AppLanguage = .romanian

    @Binding var newChildName: String
    @Binding var selectedAvatarSymbol: String
    let saveAction: () -> Void

    var body: some View {
        NavigationStack {
            ZStack {
                FamilyBackground()
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        Text(selectedLanguage.translate("add_child_desc"))
                            .font(.subheadline.weight(.medium))
                            .foregroundStyle(.secondary)

                        VStack(alignment: .leading, spacing: 10) {
                            Text(selectedLanguage.translate("avatar"))
                                .font(.headline.bold())
                            Text(selectedLanguage.translate("choose_avatar"))
                                .font(.caption)
                                .foregroundStyle(.secondary)

                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 4), spacing: 10) {
                                ForEach(FamilyAvatarCatalog.symbols, id: \.self) { symbol in
                                    Button {
                                        selectedAvatarSymbol = symbol
                                    } label: {
                                        AvatarBadge(
                                            symbol: symbol,
                                            gradient: FamilyAvatarCatalog.gradient(for: FamilyAvatarCatalog.symbols.firstIndex(of: symbol) ?? 0),
                                            size: 50,
                                            isSelected: selectedAvatarSymbol == symbol
                                        )
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }

                        TextField(selectedLanguage.translate("name"), text: $newChildName)
                            .textFieldStyle(.roundedBorder)
                            .autocorrectionDisabled()

                        Button {
                            saveAction()
                        } label: {
                            Label(selectedLanguage.translate("save"), systemImage: "sparkles")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(FamilyPrimaryButtonStyle(colors: AppPalette.primaryButtonColors))
                        .disabled(newChildName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 28)
                }
            }
            .navigationTitle(selectedLanguage.translate("add_child"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(selectedLanguage.translate("cancel")) {
                        newChildName = ""
                        selectedAvatarSymbol = FamilyAvatarCatalog.symbols.first ?? "star.fill"
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
}

struct EditChildSheet: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("appLanguage") private var selectedLanguage: AppLanguage = .romanian

    @Binding var childName: String
    @Binding var selectedAvatarSymbol: String
    let saveAction: () -> Void

    var body: some View {
        NavigationStack {
            ZStack {
                FamilyBackground()
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        Text(selectedLanguage.translate("choose_avatar"))
                            .font(.subheadline.weight(.medium))
                            .foregroundStyle(.secondary)

                        VStack(alignment: .leading, spacing: 10) {
                            Text(selectedLanguage.translate("avatar"))
                                .font(.headline.bold())

                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 4), spacing: 10) {
                                ForEach(FamilyAvatarCatalog.symbols, id: \.self) { symbol in
                                    Button {
                                        selectedAvatarSymbol = symbol
                                    } label: {
                                        AvatarBadge(
                                            symbol: symbol,
                                            gradient: FamilyAvatarCatalog.gradient(for: FamilyAvatarCatalog.symbols.firstIndex(of: symbol) ?? 0),
                                            size: 50,
                                            isSelected: selectedAvatarSymbol == symbol
                                        )
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }

                        TextField(selectedLanguage.translate("name"), text: $childName)
                            .textFieldStyle(.roundedBorder)
                            .autocorrectionDisabled()

                        Button {
                            saveAction()
                        } label: {
                            Label(selectedLanguage.translate("save"), systemImage: "checkmark")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(FamilyPrimaryButtonStyle(colors: AppPalette.primaryButtonColors))
                        .disabled(childName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 28)
                }
            }
            .navigationTitle(selectedLanguage.translate("edit_child"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(selectedLanguage.translate("cancel")) {
                        dismiss()
                    }
                }
            }
        }
        .presentationDetents([.medium, .large])
    }
}

struct HighlightBanner: View {
    @Environment(\.colorScheme) private var colorScheme
    let child: Child
    let rewardDefinitions: [RewardDefinition]
    @AppStorage("appLanguage") private var selectedLanguage: AppLanguage = .romanian

    var body: some View {
        HStack(spacing: 14) {
            AvatarBadge(symbol: child.avatarSymbol, gradient: child.accentGradient, size: 52)

            VStack(alignment: .leading, spacing: 4) {
                Text(child.availableRewards(using: rewardDefinitions).isEmpty ? selectedLanguage.translate("ready_for_next_reward") : selectedLanguage.translate("rewards_ready"))
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.white.opacity(0.85))
                Text("\(child.name) • \(child.points % 100)/100")
                    .font(.headline.weight(.black))
                Text("\(child.availableRewards(using: rewardDefinitions).count) • \(selectedLanguage.translate("streak")) \(child.currentStreak)")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.82))
            }

            Spacer()
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(highlightBackground)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .strokeBorder(highlightStroke, lineWidth: 1)
        }
        .foregroundStyle(.primary)
    }

    private var highlightBackground: Color {
        colorScheme == .dark ? Color.white.opacity(0.06) : Color.white.opacity(0.72)
    }

    private var highlightStroke: Color {
        colorScheme == .dark ? Color.white.opacity(0.08) : Color.black.opacity(0.06)
    }
}

struct OverviewStatCard: View {
    @Environment(\.colorScheme) private var colorScheme
    let title: String
    let value: String
    let symbol: String
    let colors: [Color]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: symbol)
                .font(.headline.weight(.bold))
                .foregroundStyle(.white)
                .frame(width: 34, height: 34)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing))
                )

            Text(value)
                .font(.title2.weight(.black))
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(cardBackground, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .strokeBorder(cardStroke, lineWidth: 1)
        }
    }

    private var cardBackground: AnyShapeStyle {
        if colorScheme == .dark {
            return AnyShapeStyle(Color.white.opacity(0.06))
        }
        return AnyShapeStyle(.ultraThinMaterial)
    }

    private var cardStroke: Color {
        colorScheme == .dark ? Color.white.opacity(0.08) : Color.white.opacity(0.35)
    }
}

struct DailyFocusCard: View {
    @Environment(\.colorScheme) private var colorScheme
    let child: Child
    @AppStorage("appLanguage") private var selectedLanguage: AppLanguage = .romanian

    var body: some View {
        let completed = child.completedTasksToday
        let total = child.tasks.count

        HStack(spacing: 16) {
            ProgressOrbit(progress: child.progressToNextReward, gradient: child.accentGradient)

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    HStack(spacing: 10) {
                        AvatarBadge(symbol: child.avatarSymbol, gradient: child.accentGradient, size: 34)
                        Text(child.name)
                            .font(.headline.weight(.black))
                    }
                    Spacer()
                    Text("\(child.points) pts")
                        .font(.subheadline.bold())
                        .foregroundStyle(.secondary)
                }

                Text(total == 0
                     ? selectedLanguage.translate("create_first_task")
                     : total == completed
                        ? selectedLanguage.translate("all_done_today")
                        : "\(max(total - completed, 0)) \(selectedLanguage.translate("tasks_left"))")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.secondary)

                ProgressView(value: total == 0 ? 0 : Double(completed), total: Double(max(total, 1)))
                    .tint(AppPalette.softAmber)

                Label("\(child.currentStreak) \(selectedLanguage.translate("days"))", systemImage: "flame.fill")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(AppPalette.softAmber)
            }
        }
        .padding(18)
        .background(cardBackground, in: RoundedRectangle(cornerRadius: 26, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .strokeBorder(cardStroke, lineWidth: 1)
        }
    }

    private var cardBackground: AnyShapeStyle {
        if colorScheme == .dark {
            return AnyShapeStyle(Color.white.opacity(0.055))
        }
        return AnyShapeStyle(.ultraThinMaterial)
    }

    private var cardStroke: Color {
        colorScheme == .dark ? Color.white.opacity(0.07) : Color.white.opacity(0.32)
    }
}

struct ChildJourneyCard: View {
    @Environment(\.colorScheme) private var colorScheme
    let child: Child
    let rewardDefinitions: [RewardDefinition]
    let onEdit: () -> Void
    @AppStorage("appLanguage") private var selectedLanguage: AppLanguage = .romanian

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .top) {
                HStack(spacing: 12) {
                    AvatarBadge(symbol: child.avatarSymbol, gradient: child.accentGradient, size: 48)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(child.name)
                            .font(.title3.weight(.black))
                        Text("\(selectedLanguage.translate("level")) \(child.currentLevel)")
                            .font(.caption.bold())
                            .foregroundStyle(.secondary)
                    }
                }

                Spacer()

                HStack(spacing: 8) {
                    Button(action: onEdit) {
                        Image(systemName: "pencil")
                            .font(.subheadline.weight(.bold))
                            .foregroundStyle(.secondary)
                            .frame(width: 32, height: 32)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(pillBackground)
                            )
                    }
                    .buttonStyle(.plain)

                    Text("\(child.points) pts")
                        .font(.headline.weight(.black))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(pillBackground, in: Capsule())
                }
            }

            MilestoneProgressView(points: child.points)

            HStack(spacing: 12) {
                JourneyStatPill(
                    title: selectedLanguage.translate("streak"),
                    value: "\(child.currentStreak)",
                    symbol: "flame.fill"
                )
                JourneyStatPill(
                    title: selectedLanguage.translate("best_streak"),
                    value: "\(child.bestStreak)",
                    symbol: "bolt.fill"
                )
            }

            VStack(alignment: .leading, spacing: 10) {
                Text(selectedLanguage.translate("main_reward"))
                    .font(.caption.bold())
                    .foregroundStyle(.secondary)

                Text(mainRewardName)
                    .font(.headline.weight(.bold))
                Text("\(child.remainingPointsToNextReward) \(selectedLanguage.translate("pts_until_prize"))")
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.secondary)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(cardBackground)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .strokeBorder(cardStroke, lineWidth: 1)
        }
        .foregroundStyle(.primary)
    }

    private var mainRewardName: String {
        rewardDefinitions.sorted(by: { $0.points < $1.points }).last?.name ?? ""
    }

    private var cardBackground: Color {
        colorScheme == .dark ? Color.white.opacity(0.05) : Color.white.opacity(0.78)
    }

    private var cardStroke: Color {
        colorScheme == .dark ? Color.white.opacity(0.08) : Color.black.opacity(0.06)
    }

    private var pillBackground: Color {
        colorScheme == .dark ? Color.white.opacity(0.10) : Color.black.opacity(0.05)
    }
}

struct TaskCard: View {
    @Environment(\.colorScheme) private var colorScheme
    let task: FamilyTask
    let onToggle: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(task.isCompletedToday ? AppPalette.softSage.opacity(0.20) : AppPalette.softSlate.opacity(0.16))
                .frame(width: 52, height: 52)
                .overlay {
                    Image(systemName: task.isCompletedToday ? "checkmark.circle.fill" : "circle.grid.2x2.fill")
                        .font(.headline.weight(.bold))
                        .foregroundStyle(task.isCompletedToday ? AppPalette.deepSage : AppPalette.deepSlate)
                }

            VStack(alignment: .leading, spacing: 6) {
                Text(task.title)
                    .font(.headline.weight(.bold))
                Text("+\(task.points) pts")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button(action: onToggle) {
                Image(systemName: task.isCompletedToday ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(task.isCompletedToday ? AppPalette.deepSage : AppPalette.deepSlate)
            }
            .buttonStyle(.plain)
        }
        .padding(18)
        .background(cardBackground, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .strokeBorder(cardStroke, lineWidth: 1)
        }
    }

    private var cardBackground: AnyShapeStyle {
        if colorScheme == .dark {
            return AnyShapeStyle(Color.white.opacity(0.05))
        }
        return AnyShapeStyle(.ultraThinMaterial)
    }

    private var cardStroke: Color {
        colorScheme == .dark ? Color.white.opacity(0.07) : Color.white.opacity(0.3)
    }
}

struct JourneyStatPill: View {
    @Environment(\.colorScheme) private var colorScheme
    let title: String
    let value: String
    let symbol: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: symbol)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption2.weight(.bold))
                    .foregroundStyle(.secondary)
                Text(value)
                    .font(.headline.weight(.black))
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(
            (colorScheme == .dark ? Color.white.opacity(0.08) : Color.black.opacity(0.04)),
            in: RoundedRectangle(cornerRadius: 16, style: .continuous)
        )
    }
}

struct CompactSummaryStrip: View {
    @Environment(\.colorScheme) private var colorScheme
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption.bold())
                .foregroundStyle(.secondary)
            Text(value)
                .font(.headline.weight(.bold))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(background, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .strokeBorder(stroke, lineWidth: 1)
        }
    }

    private var background: AnyShapeStyle {
        if colorScheme == .dark {
            return AnyShapeStyle(Color.white.opacity(0.05))
        }
        return AnyShapeStyle(.ultraThinMaterial)
    }

    private var stroke: Color {
        colorScheme == .dark ? Color.white.opacity(0.08) : Color.white.opacity(0.28)
    }
}

struct RewardReadyRow: View {
    @Environment(\.colorScheme) private var colorScheme
    let child: Child
    let reward: RewardDefinition
    let claimLabel: String
    let action: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            AvatarBadge(symbol: child.avatarSymbol, gradient: child.accentGradient, size: 40)

            VStack(alignment: .leading, spacing: 4) {
                Text(child.name)
                    .font(.subheadline.weight(.bold))
                Text("\(reward.points) pts • \(reward.name)")
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button(action: action) {
                Text(claimLabel)
            }
            .buttonStyle(FamilyPrimaryButtonStyle(colors: AppPalette.neutralButtonColors))
        }
        .padding(16)
        .background(background, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .strokeBorder(stroke, lineWidth: 1)
        }
    }

    private var background: AnyShapeStyle {
        if colorScheme == .dark {
            return AnyShapeStyle(Color.white.opacity(0.05))
        }
        return AnyShapeStyle(.ultraThinMaterial)
    }

    private var stroke: Color {
        colorScheme == .dark ? Color.white.opacity(0.08) : Color.white.opacity(0.28)
    }
}

struct MilestoneEditorRow: View {
    let title: String
    @Binding var points: Int
    @Binding var rewardName: String
    let placeholder: String
    let range: ClosedRange<Int>

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("\(title) • \(points) pts")
                    .font(.subheadline.bold())
                Spacer()
                Stepper("", value: $points, in: range)
                    .labelsHidden()
            }

            TextField(placeholder, text: $rewardName)
                .textFieldStyle(.roundedBorder)
        }
        .padding(14)
        .background(Color.primary.opacity(0.04), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

struct FinalMilestoneRow: View {
    let title: String
    @Binding var rewardName: String
    let placeholder: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(title) • 100 pts")
                .font(.subheadline.bold())

            TextField(placeholder, text: $rewardName)
                .textFieldStyle(.roundedBorder)
        }
        .padding(14)
        .background(Color.primary.opacity(0.04), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

struct RewardClaimCard: View {
    let reward: RewardDefinition
    let isReady: Bool
    let isClaimed: Bool
    let claimLabel: String
    let claimedLabel: String
    let claimAction: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text("\(reward.points) pts")
                    .font(.caption.bold())
                    .foregroundStyle(.white.opacity(0.78))
                Text(reward.name)
                    .font(.headline.bold())
            }

            Spacer()

            if isClaimed {
                Label(claimedLabel, systemImage: "checkmark.circle.fill")
                    .font(.caption.bold())
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(.white.opacity(0.18), in: Capsule())
            } else if isReady {
                Button(action: claimAction) {
                    Label(claimLabel, systemImage: "gift.fill")
                        .font(.caption.bold())
                }
                .buttonStyle(FamilyPrimaryButtonStyle(colors: [Color.white.opacity(0.28), Color.white.opacity(0.16)]))
            } else {
                Image(systemName: "lock.fill")
                    .foregroundStyle(.white.opacity(0.65))
            }
        }
        .padding(14)
        .background(.white.opacity(isReady ? 0.17 : 0.10), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

struct SuggestionRow: View {
    @Environment(\.colorScheme) private var colorScheme
    @AppStorage("appLanguage") private var selectedLanguage: AppLanguage = .romanian
    let title: String
    @Binding var points: Int
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline.weight(.bold))
                    Text("+\(points) pts")
                        .font(.caption.weight(.medium))
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Button(action: action) {
                    Image(systemName: isSelected ? "checkmark.circle.fill" : "plus.circle.fill")
                        .font(.title2.weight(.bold))
                        .foregroundStyle(isSelected ? AppPalette.deepSage : AppPalette.deepSlate)
                }
                .buttonStyle(.plain)
            }

            HStack {
                Text(selectedLanguage.translate("points"))
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)
                Spacer()
                Stepper(value: $points, in: 1...100) {
                    Text("\(points)")
                        .font(.subheadline.bold())
                        .monospacedDigit()
                }
                .labelsHidden()
                Text("\(points)")
                    .font(.subheadline.bold())
                    .monospacedDigit()
                    .frame(minWidth: 34, alignment: .trailing)
            }
        }
        .padding(16)
        .background(rowBackground, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .strokeBorder(rowStroke, lineWidth: 1)
        }
    }

    private var rowBackground: Color {
        colorScheme == .dark
            ? Color.white.opacity(isSelected ? 0.09 : 0.05)
            : Color(.secondarySystemBackground)
    }

    private var rowStroke: Color {
        colorScheme == .dark ? Color.white.opacity(0.08) : Color.clear
    }
}

struct AvatarBadge: View {
    let symbol: String
    let gradient: LinearGradient
    let size: CGFloat
    var isSelected: Bool = false

    var body: some View {
        ZStack {
            Circle()
                .fill(gradient)
            Image(systemName: symbol)
                .font(.system(size: size * 0.38, weight: .black))
                .foregroundStyle(.white)
        }
        .frame(width: size, height: size)
        .overlay {
            Circle()
                .strokeBorder(isSelected ? Color.primary : Color.clear, lineWidth: 2)
        }
        .shadow(color: .black.opacity(0.12), radius: 8, y: 4)
    }
}

struct ProgressOrbit: View {
    @Environment(\.colorScheme) private var colorScheme
    let progress: Double
    let gradient: LinearGradient

    var body: some View {
        ZStack {
            Circle()
                .stroke(trackColor, lineWidth: 10)
            Circle()
                .trim(from: 0, to: max(0.05, progress))
                .stroke(gradient, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .rotationEffect(.degrees(-90))
            Text("\(Int(progress * 100))")
                .font(.headline.weight(.black))
        }
        .frame(width: 64, height: 64)
    }

    private var trackColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.12) : Color(.systemGray5)
    }
}

enum FamilyAvatarCatalog {
    static let symbols = [
        "star.fill",
        "moon.stars.fill",
        "bolt.fill",
        "leaf.fill",
        "paperplane.fill",
        "heart.fill",
        "crown.fill",
        "sun.max.fill"
    ]

    static let palettes: [[Color]] = [
        [Color(red: 0.78, green: 0.60, blue: 0.47), Color(red: 0.60, green: 0.68, blue: 0.76)],
        [Color(red: 0.43, green: 0.62, blue: 0.78), Color(red: 0.63, green: 0.78, blue: 0.73)],
        [Color(red: 0.50, green: 0.70, blue: 0.56), Color(red: 0.76, green: 0.82, blue: 0.61)],
        [Color(red: 0.44, green: 0.52, blue: 0.73), Color(red: 0.68, green: 0.73, blue: 0.84)],
        [Color(red: 0.74, green: 0.54, blue: 0.47), Color(red: 0.84, green: 0.70, blue: 0.58)],
        [Color(red: 0.63, green: 0.52, blue: 0.74), Color(red: 0.79, green: 0.67, blue: 0.75)],
        [Color(red: 0.79, green: 0.69, blue: 0.42), Color(red: 0.88, green: 0.80, blue: 0.62)],
        [Color(red: 0.40, green: 0.67, blue: 0.66), Color(red: 0.65, green: 0.80, blue: 0.76)]
    ]

    static var paletteCount: Int { palettes.count }

    static func gradient(for index: Int) -> LinearGradient {
        let palette = palettes[abs(index) % palettes.count]
        return LinearGradient(colors: palette, startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    static func nextSymbol(after symbol: String) -> String {
        guard let index = symbols.firstIndex(of: symbol) else {
            return symbols.first ?? "star.fill"
        }
        return symbols[(index + 1) % symbols.count]
    }
}

struct FamilyBackground: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        LinearGradient(
            colors: backgroundColors,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .overlay {
            Rectangle()
                .fill(
                    RadialGradient(
                        colors: accentWash,
                        center: .topLeading,
                        startRadius: 40,
                        endRadius: 520
                    )
                )
                .blur(radius: colorScheme == .dark ? 20 : 32)
                .opacity(colorScheme == .dark ? 0.55 : 0.65)
        }
    }

    private var backgroundColors: [Color] {
        if colorScheme == .dark {
            return [
                Color(red: 0.08, green: 0.09, blue: 0.12),
                Color(red: 0.10, green: 0.13, blue: 0.18),
                Color(red: 0.07, green: 0.11, blue: 0.15)
            ]
        }

        return [
            Color(red: 0.98, green: 0.97, blue: 0.94),
            Color(red: 0.95, green: 0.96, blue: 0.98),
            Color(red: 0.94, green: 0.95, blue: 0.93)
        ]
    }

    private var accentWash: [Color] {
        if colorScheme == .dark {
            return [
                Color(red: 0.23, green: 0.30, blue: 0.40).opacity(0.42),
                Color(red: 0.20, green: 0.22, blue: 0.28).opacity(0.14),
                .clear
            ]
        }

        return [
            Color(red: 0.84, green: 0.89, blue: 0.96).opacity(0.58),
            Color(red: 0.95, green: 0.91, blue: 0.84).opacity(0.32),
            .clear
        ]
    }
}

struct FamilyPrimaryButtonStyle: ButtonStyle {
    let colors: [Color]

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline.weight(.bold))
            .padding(.horizontal, 18)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing))
                    .opacity(configuration.isPressed ? 0.85 : 1)
            )
            .foregroundStyle(.white)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeOut(duration: 0.18), value: configuration.isPressed)
    }
}

enum AppPalette {
    static let softAmber = Color(red: 0.76, green: 0.66, blue: 0.47)
    static let softSlate = Color(red: 0.67, green: 0.75, blue: 0.82)
    static let deepSlate = Color(red: 0.33, green: 0.46, blue: 0.61)
    static let softSage = Color(red: 0.67, green: 0.79, blue: 0.71)
    static let deepSage = Color(red: 0.34, green: 0.57, blue: 0.45)

    static let neutralButtonColors: [Color] = [
        Color(red: 0.58, green: 0.61, blue: 0.67),
        Color(red: 0.43, green: 0.47, blue: 0.56)
    ]

    static let primaryButtonColors: [Color] = [
        Color(red: 0.68, green: 0.63, blue: 0.58),
        Color(red: 0.49, green: 0.55, blue: 0.64)
    ]

    static let secondaryButtonColors: [Color] = [
        Color(red: 0.56, green: 0.68, blue: 0.78),
        Color(red: 0.60, green: 0.70, blue: 0.68)
    ]

    static let primarySoftGradient = LinearGradient(
        colors: [
            Color(red: 0.72, green: 0.67, blue: 0.60),
            Color(red: 0.55, green: 0.61, blue: 0.70)
        ],
        startPoint: .leading,
        endPoint: .trailing
    )

    static let progressColors: [Color] = [
        Color(red: 0.80, green: 0.70, blue: 0.47),
        Color(red: 0.55, green: 0.73, blue: 0.61),
        Color(red: 0.47, green: 0.62, blue: 0.78)
    ]
}

extension Child {
    private var calendar: Calendar { .current }
    private var historyDateFormatter: ISO8601DateFormatter {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate]
        return formatter
    }

    var completedTasksToday: Int {
        tasks.filter(\.isCompletedToday).count
    }

    var currentLevel: Int {
        max(1, (points / 100) + 1)
    }

    var progressToNextReward: Double {
        let currentLevelPoints = points % 100
        if points > 0, currentLevelPoints == 0 {
            return 1
        }
        return Double(currentLevelPoints) / 100
    }

    var remainingPointsToNextReward: Int {
        let remaining = 100 - (points % 100)
        return (remaining == 100 && points > 0) ? 0 : remaining
    }

    var sortedTasks: [FamilyTask] {
        tasks.sorted { lhs, rhs in
            if lhs.isCompletedToday == rhs.isCompletedToday {
                return lhs.title.localizedCaseInsensitiveCompare(rhs.title) == .orderedAscending
            }
            return !lhs.isCompletedToday && rhs.isCompletedToday
        }
    }

    var accentGradient: LinearGradient {
        FamilyAvatarCatalog.gradient(for: avatarColorIndex)
    }

    func hasCompletedTaskToday(excluding task: FamilyTask? = nil) -> Bool {
        tasks.contains { currentTask in
            if let task, currentTask.persistentModelID == task.persistentModelID {
                return false
            }
            return currentTask.isCompletedToday
        }
    }

    func registerCompletion(on date: Date) {
        var history = completionHistorySet()
        history.insert(dayKey(for: date))
        completedDayHistory = history.sorted().joined(separator: ",")
        recalculateStreaks(referenceDate: date)
    }

    func removeCompletion(for date: Date) {
        var history = completionHistorySet()
        history.remove(dayKey(for: date))
        completedDayHistory = history.sorted().joined(separator: ",")
        recalculateStreaks(referenceDate: date)
    }

    var currentRewardCycle: Int {
        guard points > 0 else { return 0 }
        return (points - 1) / 100
    }

    func rewardClaimID(for reward: RewardDefinition) -> String {
        "\(currentRewardCycle)-\(reward.points)"
    }

    func claimedRewardSet() -> Set<String> {
        Set(claimedRewardIDs.split(separator: ",").map(String.init))
    }

    func isRewardClaimed(_ reward: RewardDefinition) -> Bool {
        claimedRewardSet().contains(rewardClaimID(for: reward))
    }

    func canClaim(reward: RewardDefinition) -> Bool {
        let cyclePoints = points > 0 && points % 100 == 0 ? 100 : points % 100
        return cyclePoints >= reward.points && !isRewardClaimed(reward)
    }

    func availableRewards(using definitions: [RewardDefinition]) -> [RewardDefinition] {
        definitions.filter { canClaim(reward: $0) }
    }

    func markRewardClaimed(_ reward: RewardDefinition) {
        var claims = claimedRewardSet()
        claims.insert(rewardClaimID(for: reward))
        claimedRewardIDs = claims.sorted().joined(separator: ",")
    }

    private func completionHistorySet() -> Set<String> {
        Set(completedDayHistory.split(separator: ",").map(String.init))
    }

    private func dayKey(for date: Date) -> String {
        historyDateFormatter.string(from: date)
    }

    private func date(from dayKey: String) -> Date? {
        historyDateFormatter.date(from: dayKey)
    }

    private func recalculateStreaks(referenceDate: Date) {
        let dates = completionHistorySet()
            .compactMap(date(from:))
            .sorted()

        guard !dates.isEmpty else {
            currentStreak = 0
            lastStreakDate = nil
            return
        }

        lastStreakDate = dates.last
        bestStreak = max(bestStreak, longestConsecutiveRun(in: dates))

        let today = calendar.startOfDay(for: referenceDate)
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)
        let latest = calendar.startOfDay(for: dates.last ?? today)

        guard latest == today || latest == yesterday else {
            currentStreak = 0
            return
        }

        currentStreak = trailingConsecutiveRun(in: dates, endingAt: latest)
    }

    private func trailingConsecutiveRun(in dates: [Date], endingAt latest: Date) -> Int {
        var streak = 0
        var cursor = latest
        let daySet = Set(dates.map { calendar.startOfDay(for: $0) })

        while daySet.contains(cursor) {
            streak += 1
            guard let previous = calendar.date(byAdding: .day, value: -1, to: cursor) else { break }
            cursor = previous
        }

        return streak
    }

    private func longestConsecutiveRun(in dates: [Date]) -> Int {
        let sortedDays = Array(Set(dates.map { calendar.startOfDay(for: $0) })).sorted()
        guard !sortedDays.isEmpty else { return 0 }

        var longest = 1
        var current = 1

        for index in 1..<sortedDays.count {
            let previous = sortedDays[index - 1]
            let currentDay = sortedDays[index]
            if let nextExpected = calendar.date(byAdding: .day, value: 1, to: previous),
               calendar.isDate(nextExpected, inSameDayAs: currentDay) {
                current += 1
                longest = max(longest, current)
            } else {
                current = 1
            }
        }

        return longest
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Child.self, FamilyTask.self], inMemory: true)
}
