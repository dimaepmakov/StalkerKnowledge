import SwiftUI
import SwiftData

struct OnboardingView: View {
    @Environment(\.modelContext) var modelContext
    @State private var username = ""
    @State private var selectedClass = "9В"
    @State private var showMain = false
    
    let classes = ["9А", "9Б", "9В", "9Г", "9Д"]
    
    var body: some View {
        ZStack {
            Theme.bgPrimary.ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("STALKER KNOWLEDGE")
                    .font(.system(size: 32, weight: .black, design: .monospaced))
                    .foregroundStyle(Theme.neonGreen)
                    .neonGlow(Theme.neonGreen)
                
                Text("Пустошь знаний ждёт тебя, Сталкер")
                    .foregroundStyle(Theme.textSecondary)
                
                VStack(spacing: 16) {
                    TextField("Имя сталкера", text: $username)
                        .textFieldStyle(.plain)
                        .padding()
                        .background(Theme.bgSecondary)
                        .cornerRadius(Theme.radiusMedium)
                        .foregroundStyle(.white)
                    
                    Picker("Класс", selection: $selectedClass) {
                        ForEach(classes, id: \.self) { cls in
                            Text(cls).tag(cls)
                        }
                    }
                    .pickerStyle(.segmented)
                    .colorMultiply(Theme.neonGreen)
                }
                .padding(.horizontal)
                
                Button {
                    createProfile()
                } label: {
                    Text("ВОЙТИ В ПУСТОШЬ")
                        .font(.headline)
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Theme.neonGreen)
                        .cornerRadius(Theme.radiusMedium)
                }
                .padding(.horizontal)
                .disabled(username.isEmpty)
            }
        }
        .fullScreenCover(isPresented: $showMain) {
            DashboardView()
        }
    }
    
    func createProfile() {
        let profile = UserProfile(username: username)
        modelContext.insert(profile)
        try? modelContext.save()
        
        let entries = ScheduleParser.getAllScheduleEntries()
        for e in entries {
            let entry = ScheduleEntry(day: e.day, subject: e.subject, room: e.room, order: e.order)
            modelContext.insert(entry)
        }
        try? modelContext.save()
        
        NotificationManager.shared.requestPermission()
        showMain = true
    }
}