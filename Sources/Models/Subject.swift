import Foundation
import SwiftData

@Model
final class Subject {
    var id: UUID
    var name: String
    var shortName: String
    var iconName: String
    var colorHex: String
    var progressXP: Int
    var totalXP: Int
    var isUnlocked: Bool
    var orderIndex: Int
    
    init(name: String, shortName: String, iconName: String, colorHex: String, orderIndex: Int) {
        self.id = UUID()
        self.name = name
        self.shortName = shortName
        self.iconName = iconName
        self.colorHex = colorHex
        self.progressXP = 0
        self.totalXP = 0
        self.isUnlocked = orderIndex < 3
        self.orderIndex = orderIndex
    }
    
    var progress: Double {
        guard totalXP > 0 else { return 0 }
        return min(Double(progressXP) / Double(totalXP), 1.0)
    }
}
