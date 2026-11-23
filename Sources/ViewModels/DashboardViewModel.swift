import Foundation
import SwiftData

@Observable
class DashboardViewModel {
    var modelContext: ModelContext?
    var profile: UserProfile?
    
    var todaysQuests: [Quest] = []
    var isLoading = false
    var showLevelUp = false
    var levelUpMessage = ""
    
    func setup(context: ModelContext) {
        self.modelContext = context
        loadProfile()
        generateTodaysQuests()
    }
    
    func loadProfile() {
        guard let context = modelContext else { return }
        let descriptor = FetchDescriptor<UserProfile>()
        if let existing = try? context.fetch(descriptor).first {
            profile = existing
        } else {
            let newProfile = UserProfile(username: "Сталкер")
            context.insert(newProfile)
            try? context.save()
            profile = newProfile
        }
    }
    
    func generateTodaysQuests() {
        guard let context = modelContext else { return }
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let descriptor = FetchDescriptor<Quest>(
            predicate: #Predicate { quest in
                quest.dateAssigned < today
            }
        )
        if let old = try? context.fetch(descriptor) {
            for q in old { context.delete(q) }
        }
        
        let todayDescriptor = FetchDescriptor<Quest>()
        if let existing = try? context.fetch(todayDescriptor), !existing.isEmpty {
            todaysQuests = existing
            return
        }
        
        let subjects = ScheduleParser.getTodaysSubjects()
        var quests: [Quest] = []
        
        for subject in subjects.prefix(2) {
            let templates = ContentDatabase.questTemplates[subject]?.values.flatMap { $0 } ?? []
            if let template = templates.randomElement() {
                quests.append(Quest(
                    title: template.title,
                    description: template.desc,
                    subject: subject,
                    xp: template.xp,
                    coins: template.coins,
                    isNotebook: template.type == "notebook",
                    type: template.type,
                    difficulty: template.diff,
                    answer: template.answer
                ))
            } else {
                let stubs = ContentDatabase.generateStubQuests(for: subject, count: 1)
                if let stub = stubs.first {
                    quests.append(Quest(
                        title: stub.title, description: stub.desc, subject: subject,
                        xp: stub.xp, coins: stub.coins, isNotebook: true,
                        type: stub.type, difficulty: stub.diff
                    ))
                }
            }
        }
        
        let allSubjects = ["algebra", "physics", "geometry", "chemistry", "biology", "history", "geography", "russian", "literature", "social", "english", "informatics", "probability"]
        let backlogSubject = allSubjects.filter { !subjects.contains($0) }.randomElement() ?? "algebra"
        let backlogTemplates = ContentDatabase.questTemplates[backlogSubject]?.values.flatMap { $0 } ?? []
        if let template = backlogTemplates.randomElement() {
            quests.append(Quest(
                title: "🔥 Бэклог: \(template.title)",
                description: template.desc,
                subject: backlogSubject,
                xp: template.xp + 20,
                coins: template.coins + 10,
                isNotebook: template.type == "notebook",
                type: template.type,
                difficulty: template.diff,
                answer: template.answer
            ))
        }
        
        for q in quests {
            context.insert(q)
        }
        try? context.save()
        todaysQuests = quests
    }
    
    func completeQuest(_ quest: Quest, success: Bool) {
        guard let context = modelContext, let profile = profile else { return }
        
        if success {
            quest.isCompleted = true
            profile.addXP(quest.xpReward)
            profile.addCoins(quest.coinReward)
            profile.completedQuestsCount += 1
            
            let oldLevel = profile.level
            if profile.level > oldLevel {
                showLevelUp = true
                levelUpMessage = "Новый уровень: \(profile.level)!"
            }
            
            NotificationManager.shared.sendInstantReward(title: "Квест выполнен!", xp: quest.xpReward)
            
            let subjectDescriptor = FetchDescriptor<Subject>(predicate: #Predicate { $0.name == quest.subjectName })
            if let subject = try? context.fetch(subjectDescriptor).first {
                subject.progressXP += quest.xpReward
                subject.totalXP += quest.xpReward
            }
        } else {
            quest.attempts += 1
            if quest.attempts >= 2 {
                quest.difficulty = max(1, quest.difficulty - 1)
                quest.xpReward = max(20, quest.xpReward - 10)
            }
            profile.failedQuestsCount += 1
        }
        
        try? context.save()
        
        if let index = todaysQuests.firstIndex(where: { $0.id == quest.id }) {
            todaysQuests[index] = quest
        }
    }
}