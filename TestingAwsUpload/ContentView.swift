//
//  ContentView.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 4/22/23.
//
import SwiftUI
import Amplify

struct ContentView: View {
    @State var authStatus: String?
    func checkAuthStatus() {
        Amplify.Auth.fetchAuthSession { (result) in
            switch result {
            case .success(let authSession):
                print("the current use is signed in: \(authSession.isSignedIn)")
                if authSession.isSignedIn {
                    authStatus = "User is signed in"
                } else {
                    authStatus = "User is signed out"
                }
            case .failure(let authError):
                print("failed to fetch auth session", authError)
            }
        }
    }
    var body: some View {
        VStack {
            if let authStatus = self.authStatus { //as long as its not nil
                Text(authStatus).padding()
            }
            Button("Get Status", action: checkAuthStatus).padding()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
