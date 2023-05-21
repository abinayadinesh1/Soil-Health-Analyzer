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
            Image("logo")
            Text("Your Plots").foregroundColor(.green)
            LazyVGrid(columns: columns) {
                ForEach(0...3, id: \.self) { value in
                    Text(String(value))
                    Color.red.frame(width: 30)
                    Image("pos_logo_2.png")
                    
                }
            }
        }
    }
    
}
