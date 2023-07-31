//
//  SampleDetailView.swift
//  TestingAwsUpload
//
//  Created by Justin Wong on 7/8/23.
//

import SwiftUI

struct SampleDetailView: View {
    var sample: Sample

    @State private var presentAddSampleModal = false
    @State private var isPresentingEditPlotModal = false
    @State private var isEditingSample = false
    @State private var isPresentingPhotoPicker = false
    
    @State private var newSelectedDateSampled = Date()
    @State private var textEditorText = ""
    
    private var sampleDateAndTime = ""
    
    init(sample: Sample) {
        self.sample = sample
        _newSelectedDateSampled = State(initialValue: sample.dateSampled)
        sampleDateAndTime = sample.dateSampled.formatted(date: .abbreviated, time: .shortened)
        _textEditorText = State(initialValue: sample.notes)
    }

    var body: some View {
        VStack {
            dateSampledSection

            Image(uiImage: sample.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .cornerRadius(6)
            
            if isEditingSample {
                uploadPhotoButton
            }
            sampleNotesSection
            colorTimeSeriesAnalaysisSection
        }
        .padding()
        .navigationTitle(sampleDateAndTime)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    withAnimation {
                        isEditingSample.toggle()
                    }
                }) {
                    Group {
                        if isEditingSample {
                            Text("Save")
                                .bold()
                        } else {
                            Text("Edit")
                                
                        }
                    }
                    .foregroundColor(.green)
                }
            }
        }
    }
    
    private var dateSampledSection: some View {
        HStack {
            Text("Date Sampled:")
                .foregroundColor(.gray)
                .bold()
            
            if isEditingSample {
                DatePicker("", selection: $newSelectedDateSampled, displayedComponents: [.date])
            } else {
                Text(sampleDateAndTime)
            }
        }
    }
    
    @ViewBuilder
    private var sampleNotesSection: some View {
        if isEditingSample {
            TextEditor(text: $textEditorText)
                .foregroundColor(.gray)
                .frame(height: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(uiColor: .lightGray), lineWidth: 2)
                )
        } else {
            Text(sample.notes)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
        }
    }
    
    private var colorTimeSeriesAnalaysisSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Color + Time Series Analysis")
                .font(.title2.bold())
                .multilineTextAlignment(.center)
            
            Image(sample.waterAnalysis)
            Text("Water Content Over Time")
                .font(.title2.bold())
            Image(sample.OMAnalysis)
            
            Text("Organic Matter Content Over Time")
                .font(.title2.bold())
            VStack{
                Text("Water Content:")
                    .foregroundColor(.black)
                    .bold()
                Text("Decreased 11% percentage over past 3 days. Approximately 2 days left before next watering needed to prevent the plant from drying.").multilineTextAlignment(.leading)
            }
            VStack{
                Text("Organic Matter Content")
                    .foregroundColor(.black)
                    .bold()
                Text("Decreased 5% over the past 3 days. To prevent further decline, a common recommendation for this plant is to mix in eggshells or coffee grounds into the soil.").multilineTextAlignment(.leading)
            }
        }.padding(.top, 20)
    }
    
    private var uploadPhotoButton: some View {
        Button(action: {
            isPresentingPhotoPicker.toggle()
        }) {
            Text("Upload Photo")
                .padding()
                .frame(height: 40)
                .foregroundColor(.white)
                .font(.system(size: 15).bold())
                .background(
                    RadialGradient(gradient: Gradient(colors: [.gray.opacity(0.4), .gray.opacity(0.6)]), center: .center, startRadius: 1, endRadius: 150)
                )
                .cornerRadius(10.0)
        }
    }
}

