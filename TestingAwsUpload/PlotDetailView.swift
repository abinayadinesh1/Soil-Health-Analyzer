//
//  PlotDetailView.swift
//  TestingAwsUpload
//
//  Created by Justin Wong on 7/8/23.
//

import SwiftUI

struct PlotDetailView: View {
    var plot: IndividualPlotData
    
    @State private var presentAddSampleModal = false
    @State private var isPresentingEditPlotModal = false
    
    var body: some View {
        VStack {
            plotHeaderView
            descriptionView
            
            VStack {
                HStack {
                    Text("Samples:")
                        .bold()
                        .font(.system(size: 20))
                        .foregroundColor(Color(uiColor: .gray))
                    Spacer()
                }
                
                if plot.samples.isEmpty {
                    Text("No Samples")
                        .emptyTextStyle()
                        .verticallyCentered()
                } else {
                    //TODO: Sort Plot Samples by date in the future
                    List {
                        ForEach(plot.samples, id: \.self) { sample in
                            ZStack {
                                HStack {
                                    Image(uiImage: sample.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(5)
                                    VStack(alignment: .leading) {
                                        Text(sample.dateSampled)
                                            .bold()
                                        Text(sample.notes)
                                            .font(.caption)
                                            .lineLimit(2)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }
                addSampleButton
            }
            Spacer()
        }
        .padding()
        .navigationTitle(plot.plotTitle)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isPresentingEditPlotModal.toggle()
                }) {
                    Text("Edit")
                        .foregroundColor(.green)
                }
            }
        }
        .sheet(isPresented: $presentAddSampleModal) {
            AddSampleView()
        }
        .sheet(isPresented: $isPresentingEditPlotModal) {
            EditPlotView(plot: plot)
        }
    }
    
    var plotHeaderView: some View {
        HStack {
            Image(systemName: "photo")
                .font(.system(size: 80))
            VStack(alignment: .leading) {
                Text("\(plot.plotTitle)")
                    .font(.title.bold())
                Group {
                    Text("Watering \(plot.selectedWateringSchedule)")
                    Text("\(plot.selectedIrrigationType) Irrigation")
                    Text("Pictures Updated \(plot.selectedUpdateCadence)")
                }
                .foregroundColor(.secondary)
            }
            .font(.caption)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.red.opacity(0.1))
        .cornerRadius(10)
    }
    
    var descriptionView: some View {
        VStack {
            HStack {
                Text("Description:")
                    .bold()
                    .font(.system(size: 20))
                    .foregroundColor(Color(uiColor: .gray))
                Spacer()
            }
            if !plot.plotDescription.isEmpty {
                Text("\(plot.plotDescription)")
                        .foregroundColor(.gray)
            } else {
                Text("No Description")
                    .emptyTextStyle()
            }
        }
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
    }
    
    var addSampleButton: some View {
        Button(action: {
            presentAddSampleModal.toggle()
        }) {
            Text("Add Sample")
                .padding()
                .frame(width: 300)
                .foregroundColor(.white)
                .font(.system(size: 20).bold())
                .background(
                    RadialGradient(gradient: Gradient(colors: [.blue.opacity(0.4), .green.opacity(0.5)]), center: .center, startRadius: 1, endRadius: 150)
                )
                .cornerRadius(10.0)
                .shadow(color: .green.opacity(0.8), radius: 20, x: 0, y: 0)
        }
    }
}
//MARK: - EditPlotView
struct EditPlotView: View {
    var plot: IndividualPlotData
    
    @Environment(\.dismiss) private var dismiss
    @State private var newPlotTitle: String = ""
    @State private var newPlotDescription: String = ""
    @State private var newSelectedWateringSchedule: String = "Weekly"
    @State private var newSelectedIrrigationType: String = "Drip"
    @State private var newSelectedUpdateCadence: String = "Daily"
    @State private var showAlert: Bool = false

    var previewImage: String = ""
    let wateringOptions = ["Daily", "Weekly", "Monthly", "Custom"]
    let irrigationOptions = ["Drip", "Furrow", "Flood", "Sprinkler", "Custom"]
    let updateCadenceOptions = ["Daily","Every 3 Hours", "Every 6 Hours", "Every 2 Days", "Every 3 Days"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    TextFieldHeaderView(header: "Title:", text: $newPlotTitle)
                    TextFieldHeaderView(header: "Description:", text: $newPlotDescription)

                    Text("⚠️ Reminder: Pictures must be uploaded 3-4 times between watering for accurate results").font(.subheadline)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)

                    HStack {
                        Text("Watering Schedule: ")
                            .bold()
                        Spacer()
                        Picker("Watering Schedule: ", selection: $newSelectedWateringSchedule) {
                            ForEach(wateringOptions, id: \.self) {
                                Text($0)
                            }
                        }
                        .tint(.green)
                        .pickerStyle(.menu)
                    }

                    HStack {
                        Text("Irrigation Type: ")
                            .bold()
                        Spacer()
                        Picker("Irrigation Type: ", selection: $newSelectedIrrigationType) {
                            ForEach(irrigationOptions, id: \.self) {
                                Text($0)
                            }
                        }
                        .tint(.green)
                        .pickerStyle(.menu)
                    }

                    HStack {
                        Text("Pictures Updated: ")
                            .bold()
                        Spacer()
                        Picker("Pictures Updated: ", selection: $newSelectedUpdateCadence) {
                            ForEach(updateCadenceOptions, id: \.self) {
                                Text($0)
                            }
                        }
                        .tint(.green)
                        .pickerStyle(.menu)
                    }

                    Image(previewImage).resizable().scaledToFill()
                        .frame(width: 150, height: 150)

                    confirmButton
                }
                .padding()
            }
            .navigationBarTitle("Edit Plot")
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
            .onAppear {
                newPlotTitle = plot.plotTitle
                newPlotDescription = plot.plotDescription
                newSelectedWateringSchedule = plot.selectedWateringSchedule
                newSelectedIrrigationType = plot.selectedIrrigationType
                newSelectedUpdateCadence = plot.selectedUpdateCadence
            }
        }
    }

    private var confirmButton: some View {
       Button(action: {
           //TODO: Update Plot via AWS
           dismiss()
       }) {
           Text("Confirm")
               .centered()
               .padding()
               .frame(width: 300)
               .foregroundColor(.white)
               .font(.system(size: 20).bold())
               .background(
                   RadialGradient(gradient: Gradient(colors: [.green.opacity(0.4), .blue.opacity(0.5)]), center: .center, startRadius: 1, endRadius: 150)
               )
               .cornerRadius(10.0)
               .shadow(color: .blue.opacity(0.8), radius: 20, x: 0, y: 0)
       }
   }
}

//MARK: - AddSampleView
struct AddSampleView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isPresentingPhotoPicker = false
    @State private var notesText: String = ""
    @State private var selectedImage: UIImage? = nil
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    sampleImage
                    uploadPhotoButton
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Date Sampled:")
                                .foregroundColor(.gray)
                                .bold()
                            Text(Date().formatted(.dateTime))
                        }
                        
                        Text("Notes:")
                            .foregroundColor(.gray)
                            .bold()
                            TextEditor(text: $notesText)
                            .frame(height: 400)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(uiColor: .lightGray), lineWidth: 2)
                            )
                    }
                    .padding()
                    
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
                    .frame(width: 150, height: 150)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(6)
                    .frame(width: 150, height: 150)
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
                .shadow(color: .purple.opacity(0.8), radius: 5, x: 0, y: 0)
        }
    }
}

struct PlotDetailView_Previews: PreviewProvider {
    static private var plot = IndividualPlotData(plotTitle: "Plot 1", plotDescription: "This is a Plot kdfjldkfjdlkfjdlkfjdklfjdklfjdkfjdkfljdlkfdjflkdjflkdjfldkfjdlkfjdlk dlkfjldfjdlkfjdklfjdklfjdklfjdlkfjdlkfjdlkfjdlkfjdlkfjdklfjdfkljkl", selectedWateringSchedule: "", selectedIrrigationType: "", selectedUpdateCadence: "", samples: [Sample(dateSampled: "1/2/23"), Sample(dateSampled: "1/3/23")], id: UUID(), previewImage: "")
    static var previews: some View {
        PlotDetailView(plot: plot)
    }
}
