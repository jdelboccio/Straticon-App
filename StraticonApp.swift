import SwiftUI

enum UserRole {
    case employee
    case candidate
    case intern
    case client
}

@main
struct StraticonApp: App {
    @State private var isLoggedIn: Bool = false
    @State private var userRole: UserRole = .employee
    @Environment(\.colorScheme) var colorScheme

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                switch userRole {
                case .employee:
                    MainTabView()
                        .environment(\.colorScheme, .dark)
                case .candidate, .intern:
                    RestrictedTabView()
                        .environment(\.colorScheme, .dark)
                case .client:
                    ClientTabView()
                        .environment(\.colorScheme, .dark)
                }
            } else {
                LoginView()
                    .onLoginSuccess { role in
                        userRole = role
                        isLoggedIn = true
                    }
                    .environment(\.colorScheme, .dark)
            }
        }
    }
}

extension LoginView {
    func onLoginSuccess(perform action: @escaping () -> Void) -> some View {
        self.modifier(LoginSuccessModifier(action: action))
    }
}

struct LoginSuccessModifier: ViewModifier {
    let action: () -> Void
    @State private var didLogin = false

    func body(content: Content) -> some View {
        content
            .onChange(of: didLogin) { newValue in
                if newValue {
                    action()
                }
            }
            .environment(\.loginSuccessBinding, $didLogin)
    }
}

private struct LoginSuccessKey: EnvironmentKey {
    static let defaultValue: Binding<Bool>? = nil
}

extension EnvironmentValues {
    var loginSuccessBinding: Binding<Bool>? {
        get { self[LoginSuccessKey.self] }
        set { self[LoginSuccessKey.self] = newValue }
    }
}

extension LoginView {
    @Environment(\.loginSuccessBinding) private var loginSuccessBinding

    private func loginSucceeded() {
        loginSuccessBinding?.wrappedValue = true
    }
}

struct MainTabView: View {
    @Environment(\.colorScheme) var colorScheme

    init() {
        UITabBar.appearance().backgroundColor = UIColor(colorScheme == .dark ? Color.black : Color.white)
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }

    var body: some View {
        TabView {
            NewsFeedView()
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("News")
                }

            ProjectsView()
                .tabItem {
                    Image(systemName: "building.2")
                    Text("Projects")
                }

            DirectoryView()
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Directory")
                }

            SafetyDocsView()
                .tabItem {
                    Image(systemName: "doc.text")
                    Text("Safety/Docs")
                }

            MessagingView()
                .tabItem {
                    Image(systemName: "message")
                    Text("Messages")
                }
        }
        .accentColor(Color(hex: "#1976D2"))
    }
}

// Helper extension for Color from hex
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
