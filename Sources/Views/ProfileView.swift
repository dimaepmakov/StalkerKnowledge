import SwiftUI
import SwiftData

struct ProfileView: View {
    @Environment(\.modelContext) var modelContext
    @Query var profiles: [UserProfile]
    
    var profile: UserProfile? { profiles.first }
    
    var body: some View {
        ZStack {
            Theme.bgPrimary.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    ZStack {
                        Circle()
                            .fill(Theme.bgSecondary)
                            .frame(width: 120, height: 120)
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 80))
                            .foregroundStyle(Theme.neonGreen)
                    }
                    .neonGlow(Theme.neonGreen)
                    
                    Text(profile?.username ?? "Сталкер")
                        .font(.title.bold())
                        .foregroundStyle(.white)
                    
                    HStack(spacing: 20) {
                        StatCard(title: "Уровень", value: "\(profile?.level ?? 1)", color: Theme.neonGreen)
                        StatCard(title: "XP", value: "\(profile?.totalXP ?? 0)", color: Theme.neonBlue)
                        StatCard(title: "Монеты", value: "\(profile?.coins ?? 0)", color: Theme.neonOrange)
                    }
                    
                    VStack {
                        HStack {
                            Image(systemName: "flame.fill")
                                .foregroundStyle(Theme.neonPink)
                            Text("Серия: \(profile?.streakDays ?? 0) дней")
                                .foregroundStyle(.white)
                        }
                        .padding()
                        .background(Theme.bgSecondary)
                        .cornerRadius(Theme.radiusMedium)
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("НАСТРОЙКИ")
                            .font(.headline)
                            .foregroundStyle(Theme.neonGreen)
                        
                        Toggle("Уведомления", isOn: Binding(
                            get: { profile?.notificationsEnabled ?? true },
                            set: { profile?.notificationsEnabled = $0; try? modelContext.save() }
                        ))
                        .tint(Theme.neonGreen)
                    }
                    .padding()
                    .background(Theme.bgSecondary)
                    .cornerRadius(Theme.radiusMedium)
                }
                .padding()
            }
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack {
            Text(value)
                .font(.title2.bold())
                .foregroundStyle(color)
            Text(title)
                .font(.caption)
                .foregroundStyle(Theme.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Theme.bgSecondary)
        .cornerRadius(Theme.radiusMedium)
    }
}