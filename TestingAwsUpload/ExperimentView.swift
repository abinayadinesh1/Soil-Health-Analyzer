//
//  ExperimentDetailView.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 5/22/23.
//

import Foundation
import SwiftUI

struct ExperimentView: View {
    @State var experiment: Experiment
    @State private var isEditing = false
    @State private var isSamplesSectionExpanded: Bool = false
    @State private var isPresentingCreateSampleModal = false
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                headerImageView
                    .padding()
            
                DisclosureGroup(content: {
                    Group {
                        descriptionView
                        wateringScheduleView
                        irrigationTypeView
                        updateCadenceView
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.green.opacity(0.1))
                    .cornerRadius(10)
                    .padding()
                }) {
                    HStack {
                        Image(systemName: "info.circle")
                        Text("Information")
                    }
                    .font(.system(size: 20).bold())
                    .foregroundColor(.green)
                }
                .padding()
    
                DisclosureGroup(isExpanded: $isSamplesSectionExpanded, content: {
                    if experiment.samples.isEmpty {
                        VStack {
                            Text("No Samples")
                                .emptyTextStyle()
                                .frame(maxWidth: 400)
                        }
                        .frame(width: geo.size.width)
                        .frame(minHeight: geo.size.height)
                    } else {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(experiment.samples) { sample in
                                NavigationLink(destination: SampleDetailView(sample: sample)) {
                                    ExperimentSampleView(isEditing: $isEditing, sample: sample)
                                }
                            }
                        }
                    }
                }) {
                    HStack {
                        Image(systemName: "leaf")
                        Text("Samples")
                        Spacer()
                        Circle()
                            .fill(.green.opacity(0.3))
                            .overlay(
                                Text("\(experiment.samples.count)")
                            )
                            .frame(width: 25, height: 25)
                    }
                    .font(.system(size: 20).bold())
                    .foregroundColor(.green)
                }
                .padding()
            }
            .navigationBarTitle(experiment.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if !experiment.samples.isEmpty {
                        Button(action: {
                            withAnimation {
                                isEditing.toggle()
                                if !isSamplesSectionExpanded {
                                    isSamplesSectionExpanded = true
                                }
                            }
                        }) {
                            Text(isEditing ? "Done" : "Edit")
                                .foregroundColor(.green)
                        }
                    }
                    
                    Button(action: {
                        isPresentingCreateSampleModal.toggle()
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.green)
                    }
                }
            }
            .sheet(isPresented: $isPresentingCreateSampleModal) {
                CreateSampleView()
            }
        }
    }
    
    private var headerImageView: some View {
        HStack {
            Spacer()
            Image(experiment.previewImage)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150, alignment: .center)
                .clipped()
            Spacer()
        }
    }
    
    private var descriptionView: some View {
        VStack {
            if !experiment.description.isEmpty {
                HStack {
                    Text("Description:")
                        .bold()
                        .font(.system(size: 17))
                        .foregroundColor(Color(uiColor: .black))
                    Spacer()
                }
                Text("\(experiment.description)")
                        .foregroundColor(.black)
            } else {
                Text("No Description")
                    .emptyTextStyle()
            }
        }
    }
    
    private var wateringScheduleView: some View {
        VStack {
            if !experiment.selectedWateringSchedule.isEmpty {
                HStack {
                    Text("Watering Schedule:")
                        .bold()
                        .font(.system(size: 17))
                        .foregroundColor(Color(uiColor: .black))
                    Spacer()
                }
                Text("\(experiment.selectedWateringSchedule)")
                        .foregroundColor(.black)
            } else {
                Text("No Watering Schedule")
                    .emptyTextStyle()
            }
        }
    }
    
    private var irrigationTypeView: some View {
        VStack {
            if !experiment.selectedIrrigationType.isEmpty {
                HStack {
                    Text("Irrigation Type:")
                        .bold()
                        .font(.system(size: 17))
                        .foregroundColor(Color(uiColor: .black))
                    Spacer()
                }
                Text("\(experiment.selectedIrrigationType)")
                        .foregroundColor(.black)
            } else {
                Text("No Irrigation Type")
                    .emptyTextStyle()
            }
        }
    }
    
    private var updateCadenceView: some View {
        VStack {
            if !experiment.selectedUpdateCadence.isEmpty {
                HStack {
                    Text("Update Cadence:")
                        .bold()
                        .font(.system(size: 17))
                        .foregroundColor(Color(uiColor: .black))
                    Spacer()
                }
                Text("\(experiment.selectedUpdateCadence)")
                        .foregroundColor(.black)
            } else {
                Text("No Update Cadence")
                    .emptyTextStyle()
            }
        }
    }
}
