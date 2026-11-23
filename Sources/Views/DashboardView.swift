import SwiftUI
import SwiftData

struct DashboardView: View {
    @Environment(\.modelContext) var modelContext
    @State private var vm = DashboardViewModel()
    @Query var quests: [Quest]
    
    var body: some View {
        ZStack {
            Theme.bgPrimary.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("ДОБРОЕ УТРО, СТАЛКЕР")
                                .font(.caption)
                                .foregroundStyle(Theme.textSecondary)
                            Text(vm.profile?.username ?? "Аноним")
                                .font(.title2.bold())
                                .foregroundStyle(.white)
                        }
                        Spacer()
                        NavigationLink(destination: ProfileView()) {
                            Image(systemName: "person.circle.fill")
                                .font(.title)
                                .foregroundStyle(Theme.neonGreen)
                        }
                    }
                    .padding(.horizontal)
                    
                    XPBar(profile: vm.profile)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("СЕГОДНЯШНИЕ КВЕСТЫ")
                                .font(.headline)
                                .foregroundStyle(Theme.neonGreen)
                            Spacer()
                            Text("\(quests.filter { $0.isCompleted }.count)/\(quests.count)")
                                .foregroundStyle(Theme.textSecondary)
                        }
                        .padding(.horizontal)
                        
                        ForEach(quests) { quest in
                            NavigationLink(destination: QuestView(quest: quest)) {
                                QuestRow(quest: quest)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    
                    HStack(spacing: 16) {
                        NavigationLink(destination: MapView()) {
                            QuickAction(icon: "map", title: "Карта", color: Theme.neonBlue)
                        }
                        QuickAction(icon: "book", title: "Тетрадь", color: Theme.neonOrange)
                        QuickAction(icon: "trophy", title: "Рейтинг", color: Theme.neonPurple)
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
            }
        }
        .onAppear {
            vm.setup(context: modelContext)
        }
        .alert("LEVEL UP!", isPresented: $vm.showLevelUp) {
            Button("Ура!") { vm.showLevelUp = false }
        } message: {
            Text(vm.levelUpMessage)
        }
    }
}

struct QuickAction: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
            Text(title)
                .font(.caption)
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Theme.bgSecondary)
        .cornerRadius(Theme.radiusMedium)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.radiusMedium)
                .stroke(color.opacity(0.3), lineWidth: 1)
        )
    }
}