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
    @Binding var experiment:Experiment
    var sample: Sample
    
    
    var body: some View {
        VStack {
            if isEditing {
                HStack {
                    Spacer()
                    Button(action: {
                        for i in 0...experiment.samples.count-1 {
                            if (sample.id == experiment.samples[i].id){
                                experiment.samples.remove(at: i)
                            }
                        }
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

