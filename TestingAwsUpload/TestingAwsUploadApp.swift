//
//  TestingAwsUploadApp.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 4/22/23.
//

import SwiftUI
import Amplify
import AWSCognitoAuthPlugin
import AWSS3StoragePlugin

@main
struct TestingAwsUploadApp: App {
    @EnvironmentObject private var backend = Backend.shared
    init() {
        Task.detached {
            do {
                try await backend.initialize()
                print("Backend initialized successfully!")
            } catch {
                print("Error initializing backend - \(error)")
            }
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(backend)
        }
    }
}

