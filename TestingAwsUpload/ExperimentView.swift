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
                        Divider().foregroundColor(.systemBrown).frame(width: 40)
                        wateringScheduleView
                        Divider().foregroundColor(.systemBrown).frame(width: 40)
                        irrigationTypeView
                        Divider().foregroundColor(.systemBrown).frame(width: 40)
                        updateCadenceView
                        Divider().foregroundColor(.systemBrown).frame(width: 40)
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
            .navigationBarTitle(experiment.plotTitle)
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
        VStack (alignment: .leading){
            if !experiment.plotDescription.isEmpty {
                HStack {
                    Text("Description:")
                        .padding(.bottom, 5)
                        .font(.system(size: 17))
                        .foregroundColor(Color(uiColor: .black))
                    Spacer()
                }
                Text("\(experiment.plotDescription)")
                        .foregroundColor(.black)
            } else {
                Text("No Description")
                    .emptyTextStyle()
            }
        }
    }
    
    private var wateringScheduleView: some View {
        VStack (alignment: .leading){
            if !experiment.selectedWateringSchedule.isEmpty {
                HStack {
                    Text("Watering Schedule:")
                        .padding(.bottom, 5)
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
        VStack (alignment: .leading){
            if !experiment.selectedIrrigationType.isEmpty {
                HStack {
                    Text("Irrigation Type:")
                        .padding(.bottom, 5)
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
        VStack (alignment: .leading){
            if !experiment.selectedUpdateCadence.isEmpty {
                HStack {
                    Text("Update Cadence:")
                        .padding(.bottom, 5)
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
