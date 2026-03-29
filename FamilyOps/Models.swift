import Foundation
import SwiftData

@Model
final class Child {
    var name: String
    var points: Int
    var avatarSymbol: String
    var avatarColorIndex: Int
    var currentStreak: Int
    var bestStreak: Int
    var lastStreakDate: Date?
    var completedDayHistory: String
    var claimedRewardIDs: String
    @Relationship(deleteRule: .cascade, inverse: \FamilyTask.child) 
    var tasks: [FamilyTask] = []
    
    init(
        name: String,
        points: Int = 0,
        avatarSymbol: String = "star.fill",
        avatarColorIndex: Int = 0,
        currentStreak: Int = 0,
        bestStreak: Int = 0,
        lastStreakDate: Date? = nil,
        completedDayHistory: String = "",
        claimedRewardIDs: String = ""
    ) {
        self.name = name
        self.points = points
        self.avatarSymbol = avatarSymbol
        self.avatarColorIndex = avatarColorIndex
        self.currentStreak = currentStreak
        self.bestStreak = bestStreak
        self.lastStreakDate = lastStreakDate
        self.completedDayHistory = completedDayHistory
        self.claimedRewardIDs = claimedRewardIDs
    }
    
    var progressToPrize: Double {
        let pointsInCurrentLevel = points % 100
        return Double(pointsInCurrentLevel) / 100.0
    }
}

struct RewardDefinition: Identifiable, Hashable {
    let points: Int
    let name: String

    var id: Int { points }
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
