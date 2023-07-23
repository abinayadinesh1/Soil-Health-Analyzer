//
//  NewBackend.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 7/23/23.
//

import Foundation
import Amplify
import AWSCognitoAuthPlugin


class Backend : ObservableObject {
    static let shared = Backend()
    @Published var userData: UserData
    
    static func initialize() -> Backend {
        return .shared
    }
    private init () {
        // initialize amplify
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            print("Initialized Amplify")
        } catch {
            print("Could not initialize Amplify: \(error)")
        }

    } //end of private init
//    
//    // change our internal state, this triggers an UI update on the main thread
//    func updateUserData(withSignInStatus status : Bool) async {
//        await MainActor.run {
//            var userData : UserData = .shared
//            userData.isSignedIn = status
//            print("updated user data")
//            print(userData)
//        }
//    }
//    
//    private func initialize() async throws {
//        do {
//            let session = try await Amplify.Auth.fetchAuthSession()
//            await updateUserData(withSignInStatus: session.isSignedIn)
//        } catch {
//            print("Fetch auth session failed with error - \(error)")
//            throw error
//        }
//    }
    
}
