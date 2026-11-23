import Foundation
import SwiftData

@Observable
class MapViewModel {
    var subjects: [Subject] = []
    var selectedSubject: Subject?
    
    func loadSubjects(context: ModelContext) {
        let descriptor = FetchDescriptor<Subject>(sortBy: [SortDescriptor(\.orderIndex)])
        if let existing = try? context.fetch(descriptor), !existing.isEmpty {
            subjects = existing
            return
        }
        
        let defaultSubjects: [(String, String, String, String)] = [
            ("Алгебра", "Алг.", "function", "#00FF88"),
            ("Геометрия", "Геом.", "triangle", "#00D4FF"),
            ("Физика", "Физ.", "bolt", "#FF9F1C"),
            ("Химия", "Хим.", "flask", "#FF006E"),
            ("Биология", "Био.", "leaf", "#00FF88"),
            ("История", "Ист.", "book", "#BC13FE"),
            ("География", "Гео.", "globe", "#00D4FF"),
            ("Русский язык", "Рус.", "textformat", "#FF9F1C"),
            ("Литература", "Лит.", "book.closed", "#FF006E"),
            ("Обществознание", "Общ.", "person.2", "#BC13FE"),
            ("Английский язык", "Англ.", "globe.americas", "#00FF88"),
            ("Информатика", "Инф.", "cpu", "#00D4FF"),
            ("Вероятность и статистика", "Верст.", "chart.bar", "#FF9F1C")
        ]
        
        for (index, (name, short, icon, color)) in defaultSubjects.enumerated() {
            let subject = Subject(name: name, shortName: short, iconName: icon, colorHex: color, orderIndex: index)
            context.insert(subject)
        }
        try? context.save()
        loadSubjects(context: context)
    }
}