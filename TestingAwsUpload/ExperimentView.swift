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
    @State private var isAnalysisSectionExpanded = false

    
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



                    DisclosureGroup(isExpanded: $isAnalysisSectionExpanded, content: {
                        VStack (alignment: .leading) {
                            Text("""
                                 Water Retention and Organic Matter Decomposition over Time
                                 """)
                                .font(.title3)
                                .foregroundColor(.black)
                                .bold()
                                .fixedSize(horizontal: false, vertical: true)
                            ScrollView (.horizontal){
                                Image("chart")
                            }
                            Spacer(minLength: 10)
                            Text("""
                                 Water is leaving the system at a rate of 8 percent per day. This is normal and will mean your plants are healthy. If the rate drastically increases (losing 15% of water per day), it would be beneficial to incorporate shade (by planting taller, leafy crops or trees nearby) or adding organic matter to the system (which improves soil aggregation and water retention).
                                 
                                 """)
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.body)
                                .foregroundColor(.gray)
                            Spacer(minLength: 10)
                            Text("""
                                Organic matter is leaving the system at a rate of .05% per day. The initial organic matter content at planting was 6.3 percent, which is fairly high. This is great! Feel free to add eggshells, coffee grounds, woodchips, or other organic matter sometime in the next month for nutrient rich plants.
                                """
                            )
                                .font(.body)
                                .foregroundColor(.gray)
                                .bold()
                        }

                    }) {
                        HStack {
                            Image(systemName: "leaf")
                            Text("Time Series Analysis")
                            Spacer()
                        }
                        .font(.system(size: 20).bold())
                        .foregroundColor(.green)
                    }
                    .padding()


                }
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
