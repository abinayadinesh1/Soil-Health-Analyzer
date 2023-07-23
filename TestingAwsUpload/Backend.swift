//
//  Backend.swift
//  
//
//  Created by Abinaya on 7/20/23.
//

import Foundation
import UIKit
import Amplify
import AWSCognitoAuthPlugin


class Backend {
    static let shared = Backend()
    static func initialize() -> Backend {
        return .shared
    }
    @State var userData : UserData = .shared
    private init () {
        print(userData)
      // initialize amplify
      do {
         try Amplify.add(plugin: AWSCognitoAuthPlugin())
         try Amplify.configure()
         print("Initialized Amplify")
      } catch {
         print("Could not initialize Amplify: \(error)")
      }
        // see https://github.com/aws-amplify/amplify-swift/blob/main/Amplify/Categories/Auth/Models/AuthEventName.swift
        _ = Amplify.Hub.listen(to: .auth) { (payload) in

            switch payload.eventName {

            case HubPayload.EventName.Auth.signedIn:
                print("==HUB== User signed In, update UI")
                self.updateUserData(withSignInStatus: true)

            case HubPayload.EventName.Auth.signedOut:
                print("==HUB== User signed Out, update UI")
                self.updateUserData(withSignInStatus: false)

            case HubPayload.EventName.Auth.sessionExpired:
                print("==HUB== Session expired, show sign in UI")
                self.updateUserData(withSignInStatus: false)

            default:
                //print("==HUB== \(payload)")
                break
            }
        }
        func doRegularWork() {
            Task {
                await Backend.doAsyncWork()
            }
        }
        doRegularWork()
    } //end of private init

    func doAsyncWork() async {
        // let's check if user is signedIn or not
        Task {
            do {
                let session = try await Amplify.Auth.fetchAuthSession()

                // let's update UserData and the UI
        await self.updateUserData(withSignInStatus: session.isSignedIn)
            } catch {
                print("Fetch auth session failed with error - \(error)")
            }
        }
        print("Doing async work")
    }
    
    // MARK: - User Authentication

    // signin with Cognito web user interface

    public func signIn() async {
        do {
            let signInResult = Amplify.Auth.signInWithWebUI(presentationAnchor: UIApplication.shared.windows.first!)
            if signInResult.isSignedIn {
                print("Sign in succeeded")
            }
        } catch let error as AuthError {
            print("Sign in failed \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    // signout
    public func signOut() async {
        let result = await Amplify.Auth.signOut()
        guard let signOutResult = result as? AWSCognitoSignOutResult
    else {
            print("Signout failed")
            return
        }

        switch signOutResult {
        case .complete:
        print("Successfully signed out")

        case let .partial(revokeTokenError, globalSignOutError, hostedUIError):
            if let hostedUIError = hostedUIError {
                print("HostedUI error \(String(describing: hostedUIError))")

            }

            if let globalSignOutError = globalSignOutError {
                print("GlobalSignOut error  \(String(describing: globalSignOutError))")
            }

            if let revokeTokenError = revokeTokenError {
                print("Revoke token error  \(String(describing: revokeTokenError))")
            }

        case .failed(let error):
            // Sign Out failed with an exception, leaving the user signed in.
            print("SignOut failed with \(error)")
        }
    }

    // change our internal state, this triggers an UI update on the main thread
    func updateUserData(withSignInStatus status : Bool) async {
        await MainActor.run {
            userData.isSignedIn = status
            print("updated user data")
            print(userData)
        }
    }
    }

