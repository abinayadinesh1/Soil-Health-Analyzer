//
//  DataStore.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 6/17/23.
//
//
//import Foundation
//import SwiftUI
//
//// this struct holds a single property that holds a 2d array of all the plots the user has made, then all the images within that plot
//@MainActor
//class DataStore: ObservableObject {
//    @Published var plots: [[IndividualPlot]] = [[], []]
//
//    private static func fileURL() throws -> URL {
//        try FileManager.default.url(for: .documentDirectory,
//                                    in: .userDomainMask,
//                                    appropriateFor: nil,
//                                    create: false)
//        .appendingPathComponent("plots.data")
//    }
//    func load() async throws {
//            let task = Task<[IndividualPlot], Error> {
//                let fileURL = try Self.fileURL()
//                guard let data = try? Data(contentsOf: fileURL) else {
//                    return []
//                }
//                let allPlots = try JSONDecoder().decode([IndividualPlot].self, from: data)
//                return allPlots
//            }
//        let plots = try await task.value
//        self.plots = plots
//        }
//    func save(plots: [IndividualPlot]) async throws {
//        let task = Task {
//            let data = try JSONEncoder().encode(scrums)
//            let outfile = try Self.fileURL()
//            try data.write(to: outfile)
//        }
//        _ = try await task.value
//    }
//
//}
