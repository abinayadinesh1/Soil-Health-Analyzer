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
    init() {
        // initialize Amplify
        Backend.initialize()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
