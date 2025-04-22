import SwiftUI

// AppTheme struct to centralize colors and fonts for sleek dark mode
struct AppTheme {
    // Dark mode monochromatic palette with energy saver in mind
    static let primaryColor = Color(red: 0.2, green: 0.6, blue: 0.9) // Slightly muted blue
    static let secondaryColor = Color.orange.opacity(0.85) // Warm orange accent
    static let backgroundDark = Color(red: 0.05, green: 0.05, blue: 0.05) // Almost black background
    static let backgroundLight = Color(red: 0.12, green: 0.12, blue: 0.12) // Dark gray for cards and containers
    static let cornerRadius: CGFloat = 8
    static let shadowRadius: CGFloat = 2
    static let shadowOpacity: Double = 0.15
}

// Primary button style with sleek dark mode styling
struct PrimaryButtonStyle: ButtonStyle {
    var backgroundColor: Color = AppTheme.secondaryColor

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.black)
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(AppTheme.cornerRadius)
            .shadow(color: Color.black.opacity(configuration.isPressed ? 0.05 : AppTheme.shadowOpacity), radius: AppTheme.shadowRadius, x: 0, y: 1)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}

// TextField style modifier for sleek dark mode input styling
struct InputFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(AppTheme.backgroundLight)
            .cornerRadius(AppTheme.cornerRadius)
            .font(.system(size: 18, weight: .thin, design: .default))
            .foregroundColor(.white)
            .autocapitalization(.none)
            .disableAutocorrection(true)
    }
}

extension View {
    func inputFieldStyle() -> some View {
        self.modifier(InputFieldModifier())
    }
}

// Font modifier to apply Inter font with thin weight for elegance
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

// Card view modifier for sleek dark mode card styling
struct CardViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(AppTheme.backgroundLight)
            .cornerRadius(AppTheme.cornerRadius)
            .shadow(color: Color.black.opacity(AppTheme.shadowOpacity), radius: AppTheme.shadowRadius, x: 0, y: 1)
            .padding(.vertical, 6)
            .padding(.horizontal, 4)
    }
}

extension View {
    func cardStyle() -> some View {
        self.modifier(CardViewModifier())
    }
}
