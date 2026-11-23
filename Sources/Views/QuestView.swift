import SwiftUI
import SwiftData

struct QuestView: View {
    let quest: Quest
    @Environment(\.modelContext) var modelContext
    @State private var vm = QuestViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Theme.bgPrimary.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    HStack {
                        Image(systemName: "book.fill")
                            .foregroundStyle(Theme.neonGreen)
                        Text(quest.subjectName.uppercased())
                            .font(.caption.bold())
                            .foregroundStyle(Theme.neonGreen)
                        Spacer()
                        Text("+\(quest.xpReward) XP")
                            .font(.caption.bold())
                            .foregroundStyle(Theme.neonOrange)
                    }
                    .padding()
                    .background(Theme.bgSecondary)
                    .cornerRadius(Theme.radiusMedium)
                    
                    Text(quest.title)
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(quest.descriptionText)
                        .foregroundStyle(Theme.textSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Theme.bgSecondary.opacity(0.5))
                        .cornerRadius(Theme.radiusSmall)
                    
                    if quest.isNotebookTask {
                        VStack(spacing: 16) {
                            Image(systemName: "pencil.and.ruler.fill")
                                .font(.system(size: 60))
                                .foregroundStyle(Theme.neonOrange)
                            Text("Выполни задание в тетради, затем нажми кнопку")
                                .foregroundStyle(Theme.textSecondary)
                                .multilineTextAlignment(.center)
                            
                            Button {
                                vm.submitAnswer()
                            } label: {
                                Text("ВЫПОЛНЕНО В ТЕТРАДИ ✓")
                                    .font(.headline)
                                    .foregroundStyle(.black)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Theme.neonGreen)
                                    .cornerRadius(Theme.radiusMedium)
                            }
                        }
                    } else {
                        VStack(spacing: 16) {
                            TextField("Твой ответ", text: $vm.userAnswer)
                                .textFieldStyle(.plain)
                                .padding()
                                .background(Theme.bgTeritary)
                                .cornerRadius(Theme.radiusMedium)
                                .foregroundStyle(.white)
                                .keyboardType(.default)
                            
                            Button {
                                vm.submitAnswer()
                            } label: {
                                Text("ПРОВЕРИТЬ")
                                    .font(.headline)
                                    .foregroundStyle(.black)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Theme.neonBlue)
                                    .cornerRadius(Theme.radiusMedium)
                            }
                        }
                    }
                    
                    if vm.showResult {
                        VStack {
                            Text(vm.resultMessage)
                                .foregroundStyle(vm.isCorrect ? Theme.neonGreen : Theme.neonPink)
                                .multilineTextAlignment(.center)
                            
                            if vm.isCorrect {
                                Button("Забрать лут 🎁") {
                                    quest.isCompleted = true
                                    try? modelContext.save()
                                    dismiss()
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(Theme.neonGreen)
                            }
                        }
                        .padding()
                        .background(Theme.bgSecondary)
                        .cornerRadius(Theme.radiusMedium)
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Квест")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { vm.setup(quest: quest) }
    }
}