import Foundation
import SwiftData

@Model
final class Child {
    var name: String
    var points: Int
    var level: Int
    @Relationship(deleteRule: .cascade, inverse: \FamilyTask.child) 
    var tasks: [FamilyTask] = []
    
    init(name: String, points: Int = 0, level: Int = 1) {
        self.name = name
        self.points = points
        self.level = level
    }
    
    var progressToPrize: Double {
        let pointsInCurrentLevel = points % 100
        return Double(pointsInCurrentLevel) / 100.0
    }
}

enum TaskFrequency: String, Codable, CaseIterable {
    case daily = "Zilnic"
    case weekly = "Săptămânal"
}

@Model
final class FamilyTask {
    var title: String
    var points: Int
    var emoji: String
    var frequency: TaskFrequency
    var lastCompletedDate: Date?
    var child: Child? // Legătura către copil
    
    init(title: String, points: Int, emoji: String, frequency: TaskFrequency = .daily) {
        self.title = title
        self.points = points
        self.emoji = emoji
        self.frequency = frequency
    }
    
    var isCompletedToday: Bool {
        guard let lastDate = lastCompletedDate else { return false }
        return Calendar.current.isDateInToday(lastDate)
    }
}
