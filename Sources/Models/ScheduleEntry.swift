import Foundation
import SwiftData

@Model
final class ScheduleEntry {
    var id: UUID
    var dayOfWeek: Int
    var subjectName: String
    var room: String
    var order: Int
    
    init(day: Int, subject: String, room: String, order: Int) {
        self.id = UUID()
        self.dayOfWeek = day
        self.subjectName = subject
        self.room = room
        self.order = order
    }
}