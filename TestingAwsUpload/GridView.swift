////
////  GridView.swift
////  TestingAwsUpload
////
////  Created by Abinaya on 4/30/23.
////
//
//import Foundation
//import Amplify
//import SwiftUI
//import AmplifyImage
//
//struct GridView: View {
//    @State var imageKeys: [String] = []
//
//    let columns = Array(repeating: GridItem(.flexible()), count: 1)
//    
//    var body: some View{
//        ScrollView{
//            LazyVGrid(columns: columns) {
//                ForEach(imageKeys, id: \.self) {key in
////                    Text(key[0..<9])
//                    AmplifyImage(key:key).scaleToFillWidth().padding(15)
//                }
//            }
//        }.onAppear(perform: getImageKeys)
//    }
//    
//    func getImageKeys() {
//        Amplify.Storage.list { result in
//            if case .success(let storageResult) = result {
//                self.imageKeys = storageResult.items.map(\.key).filter{ $0.isEmpty == false}
//            }
//            
//        }
//    }
//}
