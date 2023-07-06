//
//  IndividualPlotData.swift
//  TestingAwsUpload
//
//  Created by Justin Wong on 7/1/23.
//

import SwiftUI

struct IndividualPlotData: Identifiable, Hashable, Decodable {
    var plotTitle: String
    var plotDescription: String
    var selectedWateringSchedule: String
    var selectedIrrigationType: String
    var selectedUpdateCadence: String
    var id: UUID
    var previewImage: String
}
