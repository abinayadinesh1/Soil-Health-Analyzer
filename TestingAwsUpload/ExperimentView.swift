//
//  ExperimentDetailView.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 5/22/23.
//

import Foundation
import SwiftUI

struct ExperimentView: View {
    @Binding var experiments: [Experiment]
    @State var experiment: Experiment
    @State private var isEditing = false
    @State private var isSamplesSectionExpanded: Bool = true
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
                                    ExperimentSampleView(isEditing: $isEditing, experiment: $experiment, sample: sample)
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
        Button {
            for i in 0...experiments.count-2 {
                print(i)
                print("experiment.id")
                print(experiment.id)
                print("comparing to ")
                print(experiments[i].id)
                if experiment.id == experiments[i].id {
                    experiments.remove(at: i)
                }
            }
        } label: {
            Text("Delete")
                .foregroundColor(.black)
                .buttonStyle(.bordered)
                .tint(.red)
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
                VStack {
                    Text("Description:")
                        .padding(.bottom, 5)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color(uiColor: .black))
                    Text("\(experiment.plotDescription)")
                            .foregroundColor(.black)
                }
            } else {
                Text("No Description")
                    .emptyTextStyle()
                    .font(Font.headline.weight(.bold))
            }
        }
    }
    
    private var wateringScheduleView: some View {
        VStack (alignment: .leading){
            if !experiment.selectedWateringSchedule.isEmpty {
                VStack {
                    Text("Watering Schedule:")
                        .padding(.bottom, 5)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color(uiColor: .black))
                    Text("\(experiment.selectedWateringSchedule)")
                            .foregroundColor(.black)
                }
                
            } else {
                Text("No Watering Schedule")
                    .emptyTextStyle()
                    .font(Font.headline.weight(.bold))
            }
        }
    }
    
    private var irrigationTypeView: some View {
        VStack (alignment: .leading){
            if !experiment.selectedIrrigationType.isEmpty {
                VStack {
                    Text("Irrigation Type:")
                        .padding(.bottom, 5)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color(uiColor: .black))
                    Text("\(experiment.selectedIrrigationType)")
                            .foregroundColor(.black)
                }
                
            } else {
                Text("No Irrigation Type")
                    .emptyTextStyle()
                    .font(Font.headline.weight(.bold))
            }
        }
    }
    
    private var updateCadenceView: some View {
        VStack (alignment: .leading){
            if !experiment.selectedUpdateCadence.isEmpty {
                VStack {
                    Text("Update Cadence:")
                        .padding(.bottom, 5)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(Color(uiColor: .black))
                    Text("\(experiment.selectedUpdateCadence)")
                            .foregroundColor(.black)
                }
                
            } else {
                Text("No Update Cadence")
                    .emptyTextStyle()
                    .font(Font.headline.weight(.bold))
            }
        }
    }
}
