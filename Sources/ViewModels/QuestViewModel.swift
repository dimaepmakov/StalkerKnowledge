import Foundation
import SwiftData

@Observable
class QuestViewModel {
    var quest: Quest?
    var userAnswer: String = ""
    var showHint = false
    var showResult = false
    var isCorrect = false
    var resultMessage = ""
    
    func setup(quest: Quest) {
        self.quest = quest
        self.userAnswer = ""
        self.showHint = false
        self.showResult = false
        self.isCorrect = false
        self.resultMessage = ""
    }
    
    func submitAnswer() {
        guard let quest = quest else { return }
        
        if quest.isNotebookTask {
            isCorrect = true
            resultMessage = "Отличная работа, Сталкер! +\(quest.xpReward) XP"
            showResult = true
            return
        }
        
        if let correct = quest.correctAnswer, !correct.isEmpty {
            isCorrect = userAnswer.trimmingCharacters(in: .whitespaces).lowercased() == correct.lowercased()
            if isCorrect {
                resultMessage = "Верно! +\(quest.xpReward) XP"
            } else {
                resultMessage = "Не совсем. Попробуй ещё раз. Подсказка: \(getHint())"
            }
            showResult = true
        }
    }
    
    private func getHint() -> String {
        guard let quest = quest else { return "Проверь учебник" }
        if quest.attempts >= 1 {
            return "Ответ близок к \(quest.correctAnswer ?? "?")"
        }
        return "Перечитай условие внимательно"
    }
}