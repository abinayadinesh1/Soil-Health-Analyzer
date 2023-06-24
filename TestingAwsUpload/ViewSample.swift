//
//  ViewSample.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 6/23/23.
//

import Foundation
import SwiftUI
import Combine
import Amplify
import AWSCognitoAuthPlugin
import AWSDataStorePlugin
import AWSS3StoragePlugin
import AWSPluginsCore

struct ViewSample: View {
    var sample : Sample
    var body: some View {
        VStack {
            Text("Date Sampled: \(sample.dateSampled)")
            Image(uiImage: sample.image)
                .resizable()
                .cornerRadius(10)
                .padding(.all, 4)
                .frame(width: 200, height: 200)
                .aspectRatio(contentMode: .fill)
                .clipShape(Rectangle())
                .padding(.top, 10)
            Text("Notes: \(sample.notes)")
            Text("Color + Time Series Analysis").font(.title3)
            Image("cool_plot")
        }.padding()
    }
}
