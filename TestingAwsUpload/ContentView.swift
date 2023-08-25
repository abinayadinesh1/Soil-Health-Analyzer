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
    var body: some View {
        VStack {
            Text("content view").task {
                await performOnAppear()
            }

        }
    }
    func performOnAppear() async {
        do {
            let item = ExperimentGraphQL(id: "id1",
                            title: "Build an iOS application using Amplify")
            let savedItem = try await Amplify.DataStore.save(item)
            print("Saved item: \(savedItem.id)")
        } catch {
            print("Could not save item to DataStore: \(error)")
        }
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
