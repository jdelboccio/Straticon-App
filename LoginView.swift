import SwiftUI
import UIHelpersNew
import LocalAuthentication
import MicrosoftAuthManager

enum UserRole {
    case employee
    case candidate
    case intern
    case client
}

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isSecure: Bool = true
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @State private var isLoading: Bool = false
    @State private var isBiometricAvailable: Bool = false
    @State private var biometricErrorMessage: String = ""
    @ObservedObject private var msalManager = MicrosoftAuthManager.shared

    var onLoginSuccess: ((UserRole) -> Void)?

    var body: some View {
        VStack(spacing: 20) {
            Text("Straticon Login")
                .interFont(size: 28, weight: .thin)
                .foregroundColor(AppTheme.primaryColor)
                .padding(.bottom, 40)

            TextField("Username", text: $username)
                .inputFieldStyle()
                .accessibilityLabel("Username")

            if isSecure {
                SecureField("Password", text: $password)
                    .inputFieldStyle()
                    .accessibilityLabel("Password")
            } else {
                TextField("Password", text: $password)
                    .inputFieldStyle()
                    .accessibilityLabel("Password")
            }

            if showError {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            Button(action: {
                login()
            }) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppTheme.secondaryColor)
                        .cornerRadius(AppTheme.cornerRadius)
                        .shadow(color: Color.black.opacity(AppTheme.shadowOpacity), radius: AppTheme.shadowRadius, x: 0, y: 2)
                } else {
                    Text("Login")
                        .interFont(size: 20, weight: .thin)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding(.top, 20)
            .accessibilityLabel("Login Button")

            if isBiometricAvailable {
                Button(action: {
                    authenticateWithBiometrics()
                }) {
                    HStack {
                        Image(systemName: "faceid")
                            .font(.title2)
                        Text("Login with Face ID")
                            .interFont(size: 18, weight: .thin)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppTheme.primaryColor.opacity(0.1))
                    .foregroundColor(AppTheme.primaryColor)
                    .cornerRadius(AppTheme.cornerRadius)
                }
                .padding(.top, 10)
                .accessibilityLabel("Login with Face ID")
            }

            Button(action: {
                msalManager.signIn { result in
                    switch result {
                    case .success(let username):
                        // For demo, assign employee role on Microsoft login
                        onLoginSuccess?(.employee)
                    case .failure(let error):
                        errorMessage = error.localizedDescription
                        showError = true
                    }
                }
            }) {
                HStack {
                    Image(systemName: "microsoft")
                        .font(.title2)
                    Text("Login with Microsoft")
                        .interFont(size: 18, weight: .thin)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black.opacity(0.1))
                .foregroundColor(Color.black)
                .cornerRadius(AppTheme.cornerRadius)
            }
            .padding(.top, 10)
            .accessibilityLabel("Login with Microsoft")

            if !biometricErrorMessage.isEmpty {
                Text(biometricErrorMessage)
                    .foregroundColor(.red)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            Spacer()
        }
        .padding()
        .background(AppTheme.backgroundLight)
        .edgesIgnoringSafeArea(.all)
        .animation(.easeInOut, value: showError)
        .onAppear {
            checkBiometricAvailability()
        }
    }

    private func login() {
        showError = false
        biometricErrorMessage = ""
        guard !username.isEmpty else {
            errorMessage = "Please enter your username."
            showError = true
            return
        }
        guard !password.isEmpty else {
            errorMessage = "Please enter your password."
            showError = true
            return
        }

        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
            // Simulate successful login
            // Determine user role based on username for demo purposes
            let role: UserRole
            if username.lowercased().contains("candidate") {
                role = .candidate
            } else if username.lowercased().contains("intern") {
                role = .intern
            } else if username.lowercased().contains("client") {
                role = .client
            } else {
                role = .employee
            }
            onLoginSuccess?(role)
        }
    }

    private func checkBiometricAvailability() {
        let context = LAContext()
        var error: NSError?
        isBiometricAvailable = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
    }

    private func authenticateWithBiometrics() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Log in with Face ID"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        // For demo, assume employee role on biometric login
                        onLoginSuccess?(.employee)
                    } else {
                        biometricErrorMessage = authenticationError?.localizedDescription ?? "Failed to authenticate"
                    }
                }
            }
        } else {
            biometricErrorMessage = "Biometric authentication not available"
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .preferredColorScheme(.light)
        LoginView()
            .preferredColorScheme(.dark)
    }
}
