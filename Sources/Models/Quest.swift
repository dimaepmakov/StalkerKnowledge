import Foundation
import SwiftData

@Model
final class Quest {
    var id: UUID
    var title: String
    var descriptionText: String
    var subjectName: String
    var xpReward: Int
    var coinReward: Int
    var isCompleted: Bool
    var isNotebookTask: Bool
    var taskType: String
    var difficulty: Int
    var dateAssigned: Date
    var correctAnswer: String?
    var userAnswer: String?
    var attempts: Int
    
    init(title: String, description: String, subject: String, xp: Int, coins: Int, isNotebook: Bool, type: String, difficulty: Int = 1, answer: String? = nil) {
        self.id = UUID()
        self.title = title
        self.descriptionText = description
        self.subjectName = subject
        self.xpReward = xp
        self.coinReward = coins
        self.isCompleted = false
        self.isNotebookTask = isNotebook
        self.taskType = type
        self.difficulty = difficulty
        self.dateAssigned = Date()
        self.correctAnswer = answer
        self.userAnswer = nil
        self.attempts = 0
    }
}
