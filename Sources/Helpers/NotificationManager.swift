import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            if granted { scheduleDailyReminder() }
        }
    }
    
    func scheduleDailyReminder() {
        let content = UNMutableNotificationContent()
        content.title = "Пустошь зовёт 🌑"
        content.body = "Сталкер, аномалии знаний не подождут. Заходи за дневным лутом!"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 16
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "daily_reminder", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func sendInstantReward(title: String, xp: Int) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "+\(xp) XP получено! Проверь инвентарь."
        content.sound = .default
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false))
        UNUserNotificationCenter.current().add(request)
    }
}