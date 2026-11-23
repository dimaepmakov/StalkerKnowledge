import SwiftUI

struct Theme {
    static let bgPrimary = Color(hex: "0A0A0F")
    static let bgSecondary = Color(hex: "12121A")
    static let bgTeritary = Color(hex: "1A1A2E")
    
    static let neonGreen = Color(hex: "00FF88")
    static let neonBlue = Color(hex: "00D4FF")
    static let neonPink = Color(hex: "FF006E")
    static let neonOrange = Color(hex: "FF9F1C")
    static let neonPurple = Color(hex: "BC13FE")
    
    static let textPrimary = Color.white
    static let textSecondary = Color(hex: "A0A0B0")
    static let textDim = Color(hex: "606070")
    
    static func font(_ style: Font.TextStyle, weight: Font.Weight = .regular, design: Font.Design = .monospaced) -> Font {
        .system(style, design: design, weight: weight)
    }
    
    static let radiusSmall: CGFloat = 8
    static let radiusMedium: CGFloat = 16
    static let radiusLarge: CGFloat = 24
    
    static func neonShadow(_ color: Color, radius: CGFloat = 10) -> ShadowStyle {
        ShadowStyle(color: color, radius: radius)
    }
    
    struct ShadowStyle: ViewModifier {
        let color: Color
        let radius: CGFloat
        func body(content: Content) -> some View {
            content
                .shadow(color: color.opacity(0.5), radius: radius, x: 0, y: 0)
                .shadow(color: color.opacity(0.3), radius: radius * 2, x: 0, y: 0)
        }
    }
}

extension View {
    func neonGlow(_ color: Color = Theme.neonGreen, radius: CGFloat = 10) -> some View {
        modifier(Theme.ShadowStyle(color: color, radius: radius))
    }
    
    func cardStyle() -> some View {
        self
            .background(Theme.bgSecondary)
            .cornerRadius(Theme.radiusMedium)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.radiusMedium)
                    .stroke(Theme.neonGreen.opacity(0.3), lineWidth: 1)
            )
    }
}