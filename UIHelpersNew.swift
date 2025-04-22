import SwiftUI

// AppTheme struct to centralize colors and fonts
struct AppTheme {
    static let primaryColor = Color(hex: "#1976D2")
    static let secondaryColor = Color(hex: "#FF9800")
    static let backgroundLight = Color(hex: "#FFFFFF")
    static let backgroundGray = Color(hex: "#F5F5F5")
    static let cornerRadius: CGFloat = 10
    static let shadowRadius: CGFloat = 4
    static let shadowOpacity: Double = 0.2
}

// Primary button style with orange background, rounded corners, and shadow
struct PrimaryButtonStyle: ButtonStyle {
    var backgroundColor: Color = AppTheme.secondaryColor

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(AppTheme.cornerRadius)
            .shadow(color: Color.black.opacity(configuration.isPressed ? 0.1 : AppTheme.shadowOpacity), radius: AppTheme.shadowRadius, x: 0, y: 2)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

// TextField style modifier for consistent input styling
struct InputFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(AppTheme.backgroundGray)
            .cornerRadius(AppTheme.cornerRadius)
            .font(.system(size: 18, weight: .regular, design: .default))
            .autocapitalization(.none)
            .disableAutocorrection(true)
    }
}

extension View {
    func inputFieldStyle() -> some View {
        self.modifier(InputFieldModifier())
    }
}

// Font modifier to apply Inter font or fallback system font
struct InterFontModifier: ViewModifier {
    var size: CGFloat
    var weight: Font.Weight

    func body(content: Content) -> some View {
        content.font(.custom("Inter", size: size).weight(weight))
            .environment(\.sizeCategory, .large)
    }
}

extension View {
    func interFont(size: CGFloat, weight: Font.Weight) -> some View {
        self.modifier(InterFontModifier(size: size, weight: weight))
    }
}

// Card view modifier for consistent card styling
struct CardViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(AppTheme.backgroundLight)
            .cornerRadius(AppTheme.cornerRadius)
            .shadow(color: Color.black.opacity(AppTheme.shadowOpacity), radius: AppTheme.shadowRadius, x: 0, y: 2)
            .padding(.vertical, 8)
            .padding(.horizontal, 4)
    }
}

extension View {
    func cardStyle() -> some View {
        self.modifier(CardViewModifier())
    }
}
