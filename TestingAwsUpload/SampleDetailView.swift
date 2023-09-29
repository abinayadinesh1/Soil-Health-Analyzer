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
            VStack(alignment: .center){
                Text("Notes")
                sampleNotesSection
            }
            colorTimeSeriesAnalaysisSection
            
            Spacer()
        }
        .padding()
        .navigationTitle(sampleDateAndTime)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
//                    sample.notes = textEditorText
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
            Spacer()
            Text("Time Series Analysis")
                .font(.title2.bold())
                .multilineTextAlignment(.center)
            
            Text("Water Content:")
                .foregroundColor(.gray)
                .bold()
            
            Text("Organic Matter Content")
                .foregroundColor(.gray)
                .bold()
        }
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
