//
//  SessionManager.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 7/23/23.
//
import Amplify
import SwiftUI

enum AuthState {
    case signUp
    case login
    case confirmCode(username: String)
    case session(user: AuthUser)
}

class SessionManager: ObservableObject {
    @Published var authState: AuthState = .login
    
    func getCurrentAuthUser() {
        do {
            if let user = try Amplify.Auth.getCurrentUser() {
                authState = .session(user: user)
            } else {
                authState = .login
            }
        }
        catch {
            print("couldnt get current auth user")
        }
    }
    
    func showSignUp() {
        authState = .signUp
    }
    
    func showLogin() {
        authState = .login
    }
    
    func signUp(username: String, email: String, password: String) {
        let attributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: attributes)
        
        Amplify.Auth.signUp(
            username: username,
            password: password,
            options: options
        ) { result in
            
            switch result {
            
            case .success(let signUpResult):
                print("Sign up result:", signUpResult)
                
                switch signUpResult.nextStep {
                case .done:
                    print("Finished sign up")
                    
                case .confirmUser(let details, _):
                    print(details ?? "no details")
                    
                    DispatchQueue.main.async {
                        self?.authState = .confirmCode(username: username)
                    }
                }
                
            case .failure(let error):
                print("Sing up error", error)
            }
            
        }
    }
    
    
    func confirm(username: String, code: String) {
        Amplify.Auth.confirmSignUp(
            for: username,
            confirmationCode: code
        ) { result in
            
            switch result {
            case .success(let confirmResult):
                print(confirmResult)
                if confirmResult.isSignupComplete {
                    DispatchQueue.main.async {
                        self?.showLogin()
                    }
                }
                
            case .failure(let error):
                print("failed to confirm code:", error)
            }
        }
    }
    
    func login(username: String, password: String) {
        Amplify.Auth.signIn(
            username: username,
            password: password
        ) { result in
            
            switch result {
            case .success(let signInResult):
                print(signInResult)
                if signInResult.isSignedIn {
                    DispatchQueue.main.async {
                        self.getCurrentAuthUser()
                    }
                }
                
            case .failure(let error):
                print("Login error:", error)
            }
        }
    }
    
    func signOut() {
        Amplify.Auth.signOut { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.getCurrentAuthUser()
                }
                
            case .failure(let error):
                print("Sign out error:", error)
            }
        }
    }
}
