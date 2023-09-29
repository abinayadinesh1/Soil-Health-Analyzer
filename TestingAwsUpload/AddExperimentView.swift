//
//  AddExperimentView.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 7/24/23.
//

import Foundation
import SwiftUI
struct AddExperimentView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var experiments:[Experiment]
    @State var newDate : Date
    @State var newPlotTitle: String = ""
    @State var newPlotDescription: String = ""
    @State var newSelectedWateringSchedule: String = "Weekly"
    @State var newSelectedIrrigationType: String = "Drip"
    @State var newSelectedUpdateCadence: String = "Daily"
    @State var showAlert: Bool = false
    @State var samples: [Sample] = []

    var previewImage: String = ""
    let wateringOptions = ["Daily", "Every 2 Days", "Every 3 Days", "Weekly", "Monthly", "Custom"]
    let irrigationOptions = ["Drip", "Furrow", "Flood", "Sprinkler", "Hand Watered", "Custom"]
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
            .navigationBarTitle("New Experiment")
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
        }
    }

    private var addButton: some View {
       Button(action: {
           let newExp = Experiment(plotTitle: newPlotTitle, date: newDate, samples: [], plotDescription: newPlotDescription, selectedWateringSchedule: newSelectedWateringSchedule, selectedIrrigationType: newSelectedIrrigationType, selectedUpdateCadence: newSelectedUpdateCadence,   previewImage: "sprout" )
           experiments.append(newExp)
           //TODO: Upload to AWS
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
