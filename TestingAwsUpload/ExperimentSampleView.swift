//
//  ExperimentSampleView.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 7/24/23.
//

import Foundation
import SwiftUI


struct ExperimentSampleView: View {
    @Binding var isEditing: Bool
    var sample: Sample
    
    var body: some View {
        VStack {
            if isEditing {
                HStack {
                    Spacer()
                    Button(action: {
                        //TODO: Delete Plot Here via AWS
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 25))
                            .foregroundColor(.green)
                    }
                    .offset(x: 10, y: -7)
                    .wiggling()
                }
                .frame(height: 20)
            }
            Image(uiImage: sample.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.brown.opacity(0.35))
            Text(sample.dateSampled.formatted(date: .abbreviated, time: .shortened))
                .foregroundColor(.brown)
                .bold()
        }
        .padding()
        .background(.green.opacity(0.1))
        .cornerRadius(10)
    }
}

