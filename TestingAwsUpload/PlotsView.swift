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
    @State var showAll : Bool = true
    let columns = Array(repeating: GridItem(.flexible()), count: 3)

    var body: some View {
        VStack(){
            Image("pos_logo_2").resizable().scaledToFill()
                .frame(width: 100, height: 100)
            Text("Your Plots").foregroundColor(.green).font(.largeTitle)
            GridView()
//            GridView(columns: columns, showAll: showAll)

        }
    }
    
}
