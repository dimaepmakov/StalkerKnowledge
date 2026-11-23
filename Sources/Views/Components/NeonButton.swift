import SwiftUI

struct NeonButton: View {
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .padding()
                .background(color)
                .cornerRadius(Theme.radiusMedium)
                .neonGlow(color)
        }
    }
}