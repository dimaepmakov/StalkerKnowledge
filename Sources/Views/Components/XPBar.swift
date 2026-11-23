import SwiftUI

struct XPBar: View {
    let profile: UserProfile?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Уровень \(profile?.level ?? 1)")
                    .font(.caption.bold())
                    .foregroundStyle(Theme.neonGreen)
                Spacer()
                Text("\(profile?.totalXP ?? 0)/\((profile?.level ?? 1) * 500) XP")
                    .font(.caption)
                    .foregroundStyle(Theme.textSecondary)
            }
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Theme.bgTeritary)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(
                            LinearGradient(colors: [Theme.neonGreen, Theme.neonBlue], startPoint: .leading, endPoint: .trailing)
                        )
                        .frame(width: geo.size.width * (profile?.currentLevelProgress ?? 0))
                        .neonGlow(Theme.neonGreen, radius: 4)
                }
            }
            .frame(height: 8)
        }
    }
}