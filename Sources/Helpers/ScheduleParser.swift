import Foundation

struct ScheduleParser {
    private static let rawSchedule: [String: [String]] = [
        "Monday": [
            "Разговоры о важном", "Иностранный язык (41/38)", "История (37)", 
            "Физра", "Алгебра (210)", "Физика (211)", "Русский язык (27)"
        ],
        "Tuesday": [
            "Информатика/Труд", "Труд/Информатика", "Химия (212)", 
            "География (33)", "Геометрия (210)", "Биология (33)", "Литература (27)"
        ],
        "Wednesday": [
            "Иностранный язык (41/38)", "Алгебра (210)", "Физика (211)", 
            "Русский язык (27)", "География (33)", "Литература (27)"
        ],
        "Thursday": [
            "История (37)", "Физика (211)", "Русский язык (27)", 
            "Литература (27)", "Химия (212)", "Геометрия (210)", "Вероятность и статистика (210)"
        ],
        "Friday": [
            "Обществознание (38)", "Иностранный язык (23/36)", "Физра", 
            "Обществознание (26)", "Русский язык (27)", "Биология (33)", "Алгебра (210)"
        ],
        "Saturday": [],
        "Sunday": []
    ]
    
    private static let subjectMapping: [String: String] = [
        "Алгебра": "algebra", "Геометрия": "geometry", "Физика": "physics",
        "Химия": "chemistry", "Биология": "biology", "История": "history",
        "География": "geography", "Русский язык": "russian", "Литература": "literature",
        "Обществознание": "social", "Иностранный язык": "english",
        "Информатика": "informatics", "Вероятность и статистика": "probability"
    ]
    
    static func getTodaysSubjects() -> [String] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "EEEE"
        let today = formatter.string(from: Date())
        
        guard let lessons = rawSchedule[today] else { return [] }
        
        var subjects: [String] = []
        for lesson in lessons {
            for (key, value) in subjectMapping {
                if lesson.contains(key) && !subjects.contains(value) {
                    subjects.append(value)
                }
            }
        }
        return subjects
    }
    
    static func getAllScheduleEntries() -> [(day: Int, subject: String, room: String, order: Int)] {
        var entries: [(Int, String, String, Int)] = []
        let dayMap = ["Monday": 1, "Tuesday": 2, "Wednesday": 3, "Thursday": 4, "Friday": 5, "Saturday": 6, "Sunday": 7]
        
        for (dayName, lessons) in rawSchedule {
            guard let dayInt = dayMap[dayName] else { continue }
            for (index, lesson) in lessons.enumerated() {
                for (key, value) in subjectMapping {
                    if lesson.contains(key) {
                        let room = lesson.components(separatedBy: "(").last?.replacingOccurrences(of: ")", with: "") ?? ""
                        entries.append((dayInt, value, room, index + 1))
                        break
                    }
                }
            }
        }
        return entries
    }
}