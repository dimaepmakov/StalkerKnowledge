import SwiftUI
import SwiftData

@main
struct StalkerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Subject.self, Quest.self, UserProfile.self, ScheduleEntry.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @State private var showOnboarding = true
    
    var body: some Scene {
        WindowGroup {
            if showOnboarding {
                OnboardingView()
                    .onAppear {
                        let context = sharedModelContainer.mainContext
                        let descriptor = FetchDescriptor<UserProfile>()
                        if let existing = try? context.fetch(descriptor), !existing.isEmpty {
                            showOnboarding = false
                        }
                    }
            } else {
                DashboardView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
