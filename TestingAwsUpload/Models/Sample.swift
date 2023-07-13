//
//  Sample.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 6/18/23.
//

import Foundation
import SwiftUI


struct Sample: Hashable, Identifiable {
    var dateSampled: Date
    var notes: String
    var image: UIImage
    var id = UUID()
}
