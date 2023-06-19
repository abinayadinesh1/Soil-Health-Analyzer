
//
//GridView.swift
//TestingAwsUpload
//
//Created by Abinaya on 4/30/23.

import SwiftUI
//import AWSSageMaker
//import AWSFis
//import AWSEvidently

struct GridView: View {
    @State private var experiments: [Experiment] = []
    @State private var individualPlots: [Sample] = []
    @State private var showAll = false
    let items = Array(1...20) // Replace this with your array of items

    var body: some View {
        VStack {
            if individualPlots.isEmpty {
                Text("No individual plots created")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
                        ForEach(individualPlots) { plot in
                            Image(uiImage: plot.image)
                        }
                    }
                }
            }
            NavigationView {
                NavigationLink(destination: Sample()) {
                    Text("Create a new plot!")
                        .navigationTitle("Create a new plot")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
//            Button(action: createIndividualPlot) {
//                Image("addNew.png")
//                 Text("Create new plot")
//                     .padding()
//                     .background(Color.blue)
//                     .foregroundColor(.white)
//                     .cornerRadius(10)
//             }
        }

    }
    
//    func createIndividualPlot() {
//        let newPlot = Sample(dateSampled: "06/18/2023", notes: "", image: UIImage(imageLiteralResourceName: "green"))
//        individualPlots.append(newPlot)
//    }
    
//        VStack {
//            if showAll {
//                // Display the entire grid
//                grid(Array(items))
//            } else {
//                // Display only three columns with one row
//                grid(Array(items.prefix(3)))
//            }
//
//            Button(action: {
//                showAll.toggle()
//            }) {
//                Text(showAll ? "Show Fewer" : "Show All")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            Text("Analytics").font(.title).foregroundColor(.green)
//            HStack {
//                Rectangle()
//                    .fill(.green)
//                    .frame(width: 200, height: 200)
//                Rectangle()
//                    .fill(.green)
//                    .frame(width: 200, height: 200)
//            }.foregroundColor(.mint)
//        }
//        .padding()
    
    func grid(_ items: [Int]) -> some View {
        let rows = (items.count + 2) / 3
        
        return LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), spacing: 10) {
            ForEach(items, id: \.self) { item in
            }
            
            // Add empty cells to fill up the last row if necessary
            ForEach(0..<(rows * 3 - items.count), id: \.self) { _ in
                Color.clear
            }
        }
    }
}

struct TestPlot: View {
    let item: Int
    
    var body: some View {
        // Replace this with your custom view implementation for each item
        Text("Item \(item)")
            .frame(maxWidth: .infinity, maxHeight: 100)
            .background(Color.gray)
            .cornerRadius(10)
            .padding()
    }
}





//import Foundation
//import Amplify
//import SwiftUI
//import AmplifyImage
//
//struct GridView: View {
//
//    let columns : [GridItem]
//    let showAll : Bool
//    let plots : [IndividualPlot] = Array(IndividualPlot(plotTitle: " ", previewImage: "pos_logo_2"), IndividualPlot(plotTitle: " ", previewImage: "pos_logo_2"))
//    var counter : Int = 0
//
//    var body: some View{
//        LazyVGrid(columns: columns) {
//            plots.forEach{ plot in
//
//            }
////            ForEach(0...2, id: \.self) { value in
////                counter += 1
////                if(counter > 2 && showAll == false) {
////                    break
////                }
////            }
//        }
////        ScrollView{
////            LazyVGrid(columns: columns) {
////                ForEach(imageKeys, id: \.self) {key in
//////                    Text(key[0..<9])
////                    AmplifyImage(key:key).scaleToFillWidth().padding(15)
////                }
////            }
////        }.onAppear(perform: getImageKeys)
//    }
//
////    func getImageKeys() {
////        Amplify.Storage.list { result in
////            if case .success(let storageResult) = result {
////                self.imageKeys = storageResult.items.map(\.key).filter{ $0.isEmpty == false}
////            }
////
////        }
////    }
//}
//
//
