import Foundation
import MSAL
import SwiftUI

class MicrosoftAuthManager: ObservableObject {
    static let shared = MicrosoftAuthManager()

    private var applicationContext: MSALPublicClientApplication?

    @Published var isSignedIn: Bool = false
    @Published var userName: String?
    @Published var accessToken: String?

    private init() {
        do {
            let config = try MSALPublicClientApplicationConfig(clientId: "YOUR_CLIENT_ID", redirectUri: nil, authority: nil)
            applicationContext = try MSALPublicClientApplication(configuration: config)
        } catch {
            print("Unable to create MSALPublicClientApplication: \(error)")
        }
    }

    func signIn(completion: @escaping (Result<String, Error>) -> Void) {
        guard let applicationContext = applicationContext else {
            completion(.failure(NSError(domain: "MSAL", code: -1, userInfo: [NSLocalizedDescriptionKey: "MSAL not initialized"])))
            return
        }

        let webParameters = MSALWebviewParameters(authPresentationViewController: UIApplication.shared.windows.first!.rootViewController!)
        let interactiveParameters = MSALInteractiveTokenParameters(scopes: ["User.Read"], webviewParameters: webParameters)

        applicationContext.acquireToken(with: interactiveParameters) { (result, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let result = result else {
                completion(.failure(NSError(domain: "MSAL", code: -1, userInfo: [NSLocalizedDescriptionKey: "No result returned"])))
                return
            }

            DispatchQueue.main.async {
                self.isSignedIn = true
                self.userName = result.account.username
                self.accessToken = result.accessToken
                completion(.success(result.account.username))
            }
        }
    }

    func signOut(completion: @escaping (Bool) -> Void) {
        guard let applicationContext = applicationContext,
              let account = try? applicationContext.allAccounts().first else {
            completion(false)
            return
        }

        do {
            try applicationContext.remove(account)
            DispatchQueue.main.async {
                self.isSignedIn = false
                self.userName = nil
                self.accessToken = nil
                completion(true)
            }
        } catch {
            print("Failed to sign out: \(error)")
            completion(false)
        }
    }
}
