//
//  HomeScreen.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 5/21/23.
//

import Foundation
import SwiftUI


struct PlotsView: View {
    @State var plots : [String] = []
    let columns = Array(repeating: GridItem(.flexible()), count: 3)

    var body: some View {
        VStack(){
            Image("pos_logo_2").resizable().scaledToFill()
                .frame(width: 100, height: 100)
            Text("Your Plots").foregroundColor(.green).font(.largeTitle)
            LazyVGrid(columns: columns) {
                ForEach(0...3, id: \.self) { value in
                    IndividualPlot(previewImage: "pos_logo_2")
                }
            }
        }
    }
    
}

struct IndividualPlot: View {
    var previewImage: String
    var body: some View {
        Image(previewImage).resizable().scaledToFill()
            .frame(width: 150, height: 150)
    }
}
