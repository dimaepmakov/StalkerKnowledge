import SwiftUI
import SwiftData

struct MapView: View {
    @Environment(\.modelContext) var modelContext
    @State private var vm = MapViewModel()
    @Query var subjects: [Subject]
    
    var body: some View {
        ZStack {
            Theme.bgPrimary.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    Text("КАРТА ПУСТОШИ")
                        .font(.title2.bold())
                        .foregroundStyle(Theme.neonGreen)
                        .padding(.top)
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 16) {
                        ForEach(subjects) { subject in
                            SubjectCard(subject: subject)
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear { vm.loadSubjects(context: modelContext) }
    }
}

struct SubjectCard: View {
    let subject: Subject
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: subject.iconName)
                .font(.title)
                .foregroundStyle(Color(hex: subject.colorHex))
            
            Text(subject.shortName)
                .font(.caption.bold())
                .foregroundStyle(.white)
            
            ZStack {
                Circle()
                    .stroke(Theme.bgTeritary, lineWidth: 4)
                Circle()
                    .trim(from: 0, to: subject.progress)
                    .stroke(Color(hex: subject.colorHex), style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .rotationEffect(.degrees(-90))
            }
            .frame(width: 40, height: 40)
            
            Text("\(subject.progressXP) XP")
                .font(.caption2)
                .foregroundStyle(Theme.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Theme.bgSecondary)
        .cornerRadius(Theme.radiusMedium)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.radiusMedium)
                .stroke(subject.isUnlocked ? Color(hex: subject.colorHex).opacity(0.5) : Theme.textDim.opacity(0.3), lineWidth: 1)
        )
        .opacity(subject.isUnlocked ? 1 : 0.5)
    }
}