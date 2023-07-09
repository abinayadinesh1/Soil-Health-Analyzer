//
//  Sample.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 6/18/23.
//

import Foundation
import SwiftUI


struct Sample: Hashable, Identifiable {
    var dateSampled: String = "MM-DD-YYYY"
    var notes: String = "Found some spider mites on the plants, cleaned with diluted dish soap and praying they wont come back "
    var image: UIImage = UIImage(imageLiteralResourceName: "green")
    var id = UUID()
}
