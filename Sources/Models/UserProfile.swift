import Foundation
import SwiftData

@Model
final class UserProfile {
    var id: UUID
    var username: String
    var totalXP: Int
    var level: Int
    var coins: Int
    var streakDays: Int
    var lastActiveDate: Date?
    var completedQuestsCount: Int
    var failedQuestsCount: Int
    var notificationsEnabled: Bool
    var preferredDifficulty: Int
    
    init(username: String) {
        self.id = UUID()
        self.username = username
        self.totalXP = 0
        self.level = 1
        self.coins = 100
        self.streakDays = 0
        self.lastActiveDate = nil
        self.completedQuestsCount = 0
        self.failedQuestsCount = 0
        self.notificationsEnabled = true
        self.preferredDifficulty = 1
    }
    
    var xpForNextLevel: Int { level * 500 }
    var currentLevelProgress: Double { Double(totalXP % 500) / 500.0 }
    
    func addXP(_ amount: Int) {
        totalXP += amount
        let newLevel = (totalXP / 500) + 1
        if newLevel > level {
            level = newLevel
        }
    }
    
    func addCoins(_ amount: Int) { coins += amount }
    func spendCoins(_ amount: Int) -> Bool {
        guard coins >= amount else { return false }
        coins -= amount; return true
    }
}