// your experiments
// cover image for expiremtn, name of experiment/location ("Tomato Garden Bed")
// click on experiment, get name, details, date started experiment, water schedule, etc.
// see all the samples you've uploaded
// be able to click on an example and view data
// be able to make a new example

//sample: when upload a picture, needs to be sent to aws so we can do processing on that image
import SwiftUI


struct ExperimentsView: View {
    @State private var experiments: [Experiment] = [
        Experiment(id: UUID(), name: "Hello World", plots: [])
    ]
    @State private var individualPlots: [Sample] = [
//        Sample(dateSampled: "05/4/23", notes: "no notes", image: UIImage(imageLiteralResourceName: "green")),
//        Sample(dateSampled: "12/4/23", notes: "BIGN NOTES", image: UIImage(imageLiteralResourceName: "hb0")),
//        Sample(dateSampled: "09/4/29", notes: "TINY NOTES", image: UIImage(imageLiteralResourceName: "hb1"))
    ] //retrieved from some sort of persistent data
    let range: Range = 0..<10
    @State var currentValue: Int = 0
    @State private var showAll = false
    @State private var isPresentingAddExperimentAlert = false
    @State private var newExperimentName: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                if experiments.isEmpty {
                    Text("No Experiments Available")
                        .emptyTextStyle()
                } else {
                    List {
                        ForEach(experiments) { experiment in
                            NavigationLink(destination: ExperimentPlotsView(experiment: experiment)) {
                                VStack {
                                    Text(experiment.name)
                                        .font(.title2)
                                        .bold()
                                }
                                .frame(height: 50)
                            }
                        }
                    }
                }
            }
            
            .navigationBarTitle("My Experiments")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresentingAddExperimentAlert.toggle()
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.green)
                    }
                }
            }
            .alert("Add Experiment", isPresented: $isPresentingAddExperimentAlert) {
                TextField("New Experiment Name", text: $newExperimentName)
                Button("OK", action: {
                    //TODO: Add Experiment via AWS
                    experiments.append(Experiment(id: UUID(), name: newExperimentName, plots: []))
                })
                Button("Cancel", role: .cancel) {
                    isPresentingAddExperimentAlert.toggle()
                }
            }
        }
        .tint(Color.green)
    }
}


//struct TestPlot: View {
//    let item: Int
//
//    var body: some View {
//        // Replace this with your custom view implementation for each item
//        Text("Item \(item)")
//            .frame(maxWidth: .infinity, maxHeight: 100)
//            .background(Color.gray)
//            .cornerRadius(10)
//            .padding()
//    }
//}

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
