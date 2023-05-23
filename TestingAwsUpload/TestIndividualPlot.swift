//
//  TestIndividualPlot.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 5/23/23.
//

import Foundation
import SwiftUI

struct TestIndividualPlot: View, Identifiable {
    @State private var data: String = ""
    var id: UUID = UUID()
    var body: some View {
        VStack {
            TextField("Enter data", text: $data)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
            
            Text("Entered data: \(data)")
                .foregroundColor(.blue)
        }
    }
}
