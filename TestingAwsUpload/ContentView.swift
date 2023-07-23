//
//  ContentView.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 4/22/23.
//
import SwiftUI

struct ContentView: View {
    

    var inputImage : UIImage = UIImage(named: "garden")!
    var body: some View {
//        ExperimentsView()
        ZStack {
            if (userData.isSignedIn) {
                NavigationView {
                    List {
                        ForEach(userData.notes) { note in
                            ListRow(note: note)
                        }
                    }
                    .navigationBarTitle(Text("Notes"))
                    .navigationBarItems(leading: SignOutButton())
                }
            } else {
                SignInButton()
            }
        }
    }

    }

struct SignInButton: View {
    var body: some View {
        Button(
            action: {
                Task { await Backend.shared.signIn() }
            },
            label: {
                HStack {
                    Image(systemName: "person.fill")
                        .scaleEffect(1.5)
                        .padding()
                    Text("Sign In")
                        .font(.largeTitle)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(30)
            }
        )
    }
}

struct SignOutButton : View {
    var body: some View {
        Button(
            action: {
                Task { await Backend.shared.signOut() }
            },
            label: { Text("Sign Out") }
        )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
