import SwiftUI

// Primary button style with orange background, rounded corners, and shadow
struct PrimaryButtonStyle: ButtonStyle {
    var backgroundColor: Color = Color(hex: "#FF9800")

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(configuration.isPressed ? 0.1 : 0.2), radius: 4, x: 0, y: 2)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

// TextField style modifier for consistent input styling
struct InputFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(hex: "#F5F5F5"))
            .cornerRadius(8)
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
