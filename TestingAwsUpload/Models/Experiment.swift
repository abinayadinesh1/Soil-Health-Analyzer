//
//  Experiment.swift
//  TestingAwsUpload
//
//  Created by Justin Wong on 7/1/23.
//

import SwiftUI

struct Experiment: Identifiable {
    var id: UUID
    var name: String
    var date: String
    var plots: [IndividualPlotData]
}
