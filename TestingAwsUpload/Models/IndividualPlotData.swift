//
//  IndividualPlotData.swift
//  TestingAwsUpload
//
//  Created by Justin Wong on 7/1/23.
//

import SwiftUI

struct IndividualPlotData: Identifiable {
    var plotTitle: String
    var plotDescription: String
    var selectedWateringSchedule: String
    var selectedIrrigationType: String
    var selectedUpdateCadence: String
    var samples: [Sample]
    var id: UUID
    var previewImage: String
}
