//
//  Sample.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 6/18/23.
//

import Foundation
import SwiftUI


struct Sample: View, Identifiable {
    @State var dateSampled: String = "MM-DD-YYYY"
    @State var notes: String = "Found some spider mites on the plants, cleaned with diluted dish soap and praying they wont come back "
    @State var image: UIImage = UIImage(imageLiteralResourceName: "green")
    @State var id = UUID()
    var body: some View{
        Spacer()
    }
}
