//
//  CoverImage.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 5/26/23.
//

import Foundation
import SwiftUI

struct CoverImage : Identifiable, Equatable {
    var id = UUID()
    var name : String
    var cover : Image
}
struct Photo: Codable, Identifiable, Equatable {
    var id = UUID()
    var name : String
    var imageData: Data

    func getImage(from data: Data) -> UIImage? {
        return UIImage(data: data)
    }
}
