//
//  TestingAwsUploadApp.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 4/22/23.
//

import SwiftUI
import Amplify
import AWSCognitoAuthPlugin

@main
struct TestingAwsUploadApp: App {
    @ObservedObject var sessionManager = SessionManager()
    
    init () {
        configureAmplify()
        sessionManager.getCurrentAuthUser()
    }
    
    var body: some Scene {
            WindowGroup {
                switch sessionManager.authState {
                case .login:
                    LoginView()
                        .environmentObject(sessionManager)
                    
                case .signUp:
                    SignUpView()
                        .environmentObject(sessionManager)
                    
                case .confirmCode(let username):
                    ConfirmationView(username: username)
                        .environmentObject(sessionManager)
                    
                case .session(let user):
                    SessionView(user: user)
                        .environmentObject(sessionManager)
                }
            }
        }
        
        private func configureAmplify() {
            do {
                try Amplify.add(plugin: AWSCognitoAuthPlugin())
                try Amplify.configure()
                print("Amplify configured successfully")
                
            } catch {
                print("could not initialize Amplify", error)
            }
        }
    }
