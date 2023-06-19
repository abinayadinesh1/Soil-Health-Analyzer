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
    @State var notes: String = "Found some spider mites on the plants"
    @State var image: UIImage = UIImage(imageLiteralResourceName: "green")
    var id: UUID = UUID()

    var body: some View {
        TextField("\(dateSampled)", text: $dateSampled, prompt: Text("Date Image Taken")).font(.title2).onAppear(perform: getDate)
        TextField(" ", text: $notes, prompt: Text("Additional Notes")).font(.title2)
        Text("Upload Single Image Below")
        ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
    }
    func getDate() {
        let currDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateSampled = dateFormatter.string(from: currDate)
    }
}


//    var id: UUID = UUID()
//    var body: some View {
//        Text("hello there")
//    }
