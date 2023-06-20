//
//  ContentView.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 4/22/23.
//
import SwiftUI
import Amplify

struct ContentView: View {
    var inputImage : UIImage = UIImage(named: "garden")!
    var body: some View {
        GridView(updatedIndividualPlots: [])
        //        Image("pos_logo_2")
        //            .resizable()
        //            .scaledToFit()
        //            .frame(width: 200, height: 200)
        //        if #available(iOS 16.0, *) {
        //            NavigationStack {
        //                SymbolGrid(inputImage: UIImage(named: "hb1")!)
        //            }
        //        } else {
        //            SymbolGrid(inputImage: UIImage(named: "hb1")!)
        //        }
        
//        TabView(){
//            GridView().tabItem{
//                Image(systemName: "camera.viewfinder")
//                Text("gridview")
//            }
//            Sample().tabItem{
//                Image(systemName: "house")
//                Text("sample")
//            }
//        }
            ////                IndividualPlot(previewImage: "green").tabItem{
            ////                    Image(systemName: "house")
            ////                    Text("IndividualPlot")
            ////                }
            //
            //            }
    }
    
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
