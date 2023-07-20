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
    var date: Date
    var samples: [Sample]
    var description: String
    var selectedWateringSchedule: String
    var selectedIrrigationType: String
    var selectedUpdateCadence: String
    var previewImage: String
}
