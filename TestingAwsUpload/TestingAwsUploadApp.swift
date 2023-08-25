//
//  TestingAwsUploadApp.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 4/22/23.
//

import SwiftUI
import Amplify
import AWSDataStorePlugin

@main
struct TestingAwsUploadApp: App {
    
    init() {
        configureAmplify()
    }
    
    var body: some Scene {
        WindowGroup {
            ExperimentsView()
        }
    }
    
    func configureAmplify() {
        let dataStorePlugin = AWSDataStorePlugin(modelRegistration: AmplifyModels())
        do {
            try Amplify.add(plugin: dataStorePlugin)
            try Amplify.configure()
            print("Initialized Amplify");
        } catch {
            // simplified error handling for the tutorial
            print("Could not initialize Amplify: \(error)")
        }
    }
}
