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
        ExperimentsView()
    }

    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
