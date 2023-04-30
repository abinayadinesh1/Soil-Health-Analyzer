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
        configureAmplify()
    }
    var body: some Scene {
        WindowGroup {
            ContentView(image: UIImage(systemName: "house")!)
        }
    }
    
    //configure auth and storage categories for amplify
    private func configureAmplify(){
        do{
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.add(plugin: AWSS3StoragePlugin())
            
            try Amplify.configure()
            print("Successfully configured Amplify w S3 and Auth")
    
        } catch {
            print("Could not configure Amplify", error)
            
        }
    }
}
