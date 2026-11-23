import SwiftUI

struct QuestRow: View {
    let quest: Quest
    
    var body: some View {
        HStack {
            Image(systemName: quest.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(quest.isCompleted ? Theme.neonGreen : Theme.textDim)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(quest.title)
                    .font(.subheadline.bold())
                    .foregroundStyle(quest.isCompleted ? Theme.textSecondary : .white)
                    .strikethrough(quest.isCompleted)
                
                Text(quest.subjectName)
                    .font(.caption)
                    .foregroundStyle(Theme.textDim)
            }
            
            Spacer()
            
            if quest.isNotebookTask {
                Image(systemName: "pencil")
                    .foregroundStyle(Theme.neonOrange)
            }
            
            Text("+\(quest.xpReward)")
                .font(.caption.bold())
                .foregroundStyle(Theme.neonOrange)
        }
        .padding()
        .background(Theme.bgSecondary)
        .cornerRadius(Theme.radiusMedium)
        .overlay(
            RoundedRectangle(cornerRadius: Theme.radiusMedium)
                .stroke(quest.isCompleted ? Theme.neonGreen.opacity(0.3) : Color.clear, lineWidth: 1)
        )
    }
}