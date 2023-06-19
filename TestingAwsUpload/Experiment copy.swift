//
//  Experiment.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 5/22/23.
//

import Foundation
import SwiftUI

struct Experiment: View, Identifiable {
    @State var plotTitle: String = "Edit Title Here"
    @State var plotDescription: String = "Edit Description Here"
    @State var selectedWateringSchedule: String = "Weekly"
    @State var selectedIrrigationType: String = "Drip"
    @State var selectedUpdateCadence: String = "Daily"
    @State var showAlert: Bool = false
    @State var samples: [Sample] = []
    var id: UUID = UUID()
    var previewImage: String
    let wateringOptions = ["Daily", "Weekly", "Monthly", "Custom"]
    let irrigationOptions = ["Drip", "Furrow", "Flood", "Sprinkler", "Custom"]
    let updateCadenceOptions = ["Daily","Every 3 Hours", "Every 6 Hours", "Every 2 Days", "Every 3 Days"]
    
    var body: some View {
        TextField(" ", text: $plotTitle, prompt: Text("My Plot")).font(.title2)
        TextField(" ", text: $plotDescription, prompt: Text("Flash collard greens planted for neighbors")).font(.title2)
        Text("Reminder: pictures must be uploaded 3-4 times between watering for accurate results").font(.subheadline)
        Text("Set your watering schedule, irrigation type, and update schedule below").font(.subheadline).foregroundColor(.red)
        HStack {
            Text("Watering Schedule: ")
            Picker("Watering Schedule: ", selection: $selectedWateringSchedule) {
                ForEach(wateringOptions, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.menu)
        }
        HStack {
            Text("Irrigation Type: ")
            Picker("Irrigation Type: ", selection: $selectedIrrigationType) {
                ForEach(irrigationOptions, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.menu)
        }
        HStack {
            Text("Pictures Updated: ")
            Picker("Pictures Updated: ", selection: $selectedUpdateCadence) {
                ForEach(updateCadenceOptions, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.menu)
        }
        
        Image(previewImage).resizable().scaledToFill()
            .frame(width: 150, height: 150)
    }
    
    func convertPlotToData(){
        var newPlotData = individualPlotData(plotTitle: plotTitle, plotDescription: plotDescription, selectedWateringSchedule: selectedWateringSchedule, selectedIrrigationType: selectedIrrigationType, selectedUpdateCadence: selectedUpdateCadence, id: id, previewImage: previewImage)
    }
    }

struct individualPlotData: Identifiable, Decodable {
    var plotTitle: String
    var plotDescription: String
    var selectedWateringSchedule: String
    var selectedIrrigationType: String
    var selectedUpdateCadence: String
    var id: UUID
    var previewImage: String
}
