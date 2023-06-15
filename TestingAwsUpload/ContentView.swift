//
//  ContentView.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 4/22/23.
//
import SwiftUI

struct ContentView: View {
    var inputImage : UIImage = UIImage(named: "garden")!
    var body: some View {
        Image("pos_logo_2")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
        SymbolGrid()
//        GridView()
//            TabView(){
//                NewImageView(inputImage: inputImage).tabItem{
//                    Image(systemName: "camera.viewfinder")
//                    Text("New Image")
//                }
//                PlotsView().tabItem{
//                    Image(systemName: "house")
//                    Text("Plots")
//                }
//
//            }
        }
    
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
