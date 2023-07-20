//
//  CreateSampleView.swift
//  TestingAwsUpload
//
//  Created by Justin Wong on 7/12/23.
//

import SwiftUI

struct CreateSampleView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isPresentingPhotoPicker = false
    @State private var selectedDate = Date()
    @State private var notesText: String = ""
    @State private var selectedImage: UIImage? = nil

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Date Sampled:")
                                    .foregroundColor(.gray)
                                    .bold()
                                DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                            }

                            Text("Notes:")
                                .foregroundColor(.gray)
                                .bold()
                                TextEditor(text: $notesText)
                                .frame(height: 200)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(uiColor: .lightGray), lineWidth: 2)
                                )
                        }
                        .padding()
                        
                        sampleImage
                        uploadPhotoButton
                    }
                }
                Spacer()
                Button(action: {
                    //TODO: Add TO AWS Database
                    dismiss()
                }) {
                    Text("Add")
                        .padding()
                        .frame(width: 300)
                        .foregroundColor(.white)
                        .font(.system(size: 20).bold())
                        .background(
                            RadialGradient(gradient: Gradient(colors: [.blue.opacity(0.4), .purple.opacity(0.5)]), center: .center, startRadius: 1, endRadius: 150)
                        )
                        .cornerRadius(10.0)
                        .shadow(color: .purple.opacity(0.8), radius: 20, x: 0, y: 0)
                }
            }
            .navigationTitle("Add Sample")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 25))
                            .foregroundColor(Color(uiColor: .lightGray))
                    }
                }
            }
            .sheet(isPresented: $isPresentingPhotoPicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
    }

    private var sampleImage: some View {
        Group {
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(6)
                    .frame(width: 200, height: 200)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(6)
                    .frame(width: 200, height: 200)
                    .foregroundColor(.gray.opacity(0.6))
            }
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

struct CreateSampleView_Previews: PreviewProvider {
    static var previews: some View {
        CreateSampleView()
    }
}
