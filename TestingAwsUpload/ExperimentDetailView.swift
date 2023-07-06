//
//  ExperimentDetailView.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 5/22/23.
//

import Foundation
import SwiftUI

struct ExperimentDetailView: View {
    @State var experiment: Experiment
    @State private var showAddPlotSheet = false
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        Group {
            if experiment.plots.isEmpty {
                Text("No Plots")
                    .emptyTextStyle()
                    .verticallyCentered()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(experiment.plots, id: \.self) { plot in
                            VStack {
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .font(.system(size: 30))
                                    .foregroundColor(.red.opacity(0.35))
                                Text(plot.plotTitle)
                                    .bold()
                            }
                            .padding()
                            .background(.red.opacity(0.1))
                            .cornerRadius(10)
                        }
                    }
                }
            }
        }
        .padding()
        .navigationBarTitle(experiment.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {}) {
                    Text("Edit")
                        .foregroundColor(.green)
                }
                Button(action: {
                    showAddPlotSheet.toggle()
                }) {
                    Text("Add Plot")
                        .foregroundColor(.green)
                }
            }
        }
        .sheet(isPresented: $showAddPlotSheet) {
            AddPlotView(experiment: $experiment)
        }
    }
}

//MARK: - AddPlotView
struct AddPlotView: View {
    @Binding var experiment: Experiment
    @Environment(\.dismiss) private var dismiss
    @State private var newPlotTitle: String = ""
    @State private var newPlotDescription: String = ""
    @State private var newSelectedWateringSchedule: String = "Weekly"
    @State private var newSelectedIrrigationType: String = "Drip"
    @State private var newSelectedUpdateCadence: String = "Daily"
    @State private var showAlert: Bool = false
    @State private var samples: [Sample] = []
    
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
                    
                    addButton
                }
                .padding()
            }
            .navigationBarTitle("New Plot")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(Color(uiColor: .lightGray))
                    }
                }
            }
        }
    }
    
    func convertPlotToData() -> IndividualPlotData {
        return IndividualPlotData(plotTitle: newPlotTitle, plotDescription: newPlotDescription, selectedWateringSchedule: newSelectedWateringSchedule, selectedIrrigationType: newSelectedIrrigationType, selectedUpdateCadence: newSelectedUpdateCadence, id: UUID(), previewImage: previewImage)
    }
    
    private var addButton: some View {
       Button(action: {
           experiment.plots.append(convertPlotToData())
           dismiss()
       }) {
           Text("Confirm")
               .centered()
               .padding()
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

//MARK: - TextFieldHeaderView 
struct TextFieldHeaderView: View {
    var header: String
    @Binding var text: String
    
    var body: some View {
        VStack {
            Text(header)
                .bold()
                .leftAligned()
            TextField(" ", text: $text)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(uiColor: .lightGray), lineWidth: 2)
                )
        }
    }
}

