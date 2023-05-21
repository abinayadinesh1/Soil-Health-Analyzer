//
//  NewPlotView.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 5/21/23.
//

import Foundation
import SwiftUI


struct NewPlotView: View {
    @State var showModal : Bool = false
    
    var body: some View {
        Button(action: {
                print("Button Pushed")
                self.showModal = true
            }) {
                Text("Show Modal")
        }    }
    
}



struct ModalView: View {
    var body: some View {
        Text("This is a modal")
    }
}
