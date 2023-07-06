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
    var items = Array(1...20) // Replace this with your array of items
    
    var body: some View {
        NavigationView{
//            ScrollView{
//                VStack {
//                    Text("\(currentValue)")
//                    if individualPlots.isEmpty {
//                        Text("No individual plots created")
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
//                            .padding()
//                    } else { //this is the case where the user has added samples, so now updatedIndividualPlots is bigger
//                        ScrollView {
//                            LazyVGrid(columns: [GridItem(.flexible())], spacing: 10) {
//                                Text("Click on any sample to get the color analysis at that time of this plot.")
//                                ForEach(individualPlots) { plot in
//                                    VStack {
//                                        Text(plot.dateSampled)
//                                        NavigationLink(destination: ViewSample(sample: plot)){
//                                            Image(uiImage: plot.image)
//                                                .frame(width: 100, height: 100, alignment: .center) //needs to be a navigation link
//                                        }                    .navigationBarTitleDisplayMode(.inline)
//                                            .padding()
//                                            .foregroundColor(.white)
//                                            .cornerRadius(10)
//                                            .font(.system(size: 20, weight: .medium, design: .rounded)).navigationBarHidden(true)
//                                        Text(plot.notes.prefix(10))
//                                    }.frame(width: 100, height: 100, alignment: .center)
//                                }
//                            }
//                        }
//                    }
//                }
//                NavigationLink("Create a new plot", destination: SampleView(plotsToBeUpdated: $individualPlots, valFromParent: $currentValue, sample: Sample()))
//                    .navigationBarTitleDisplayMode(.inline)
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//                    .font(.system(size: 20, weight: .medium, design: .rounded)).navigationBarHidden(true)
//            }
            VStack {
                if experiments.isEmpty {
                    Text("No Experiments Available")
                        .emptyTextStyle()
                } else {
                    List {
                        ForEach(experiments) { experiment in
                            NavigationLink(destination: ExperimentDetailView(experiment: experiment)) {
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
                        
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.green)
                    }
                }
            }
        }
    }
    //        .onAppear(updateList(individualPlots: $individualPlots))
    
    //    func updateList(individualPlots: [Sample]) -> Void{
    //        let newPlot1 = Sample(dateSampled: "05/4/23", notes: "no notes", image: UIImage(imageLiteralResourceName: "green"))
    //        let newPlot2 = Sample(dateSampled: "12/4/23", notes: "BIGN NOTES", image: UIImage(imageLiteralResourceName: "hb0"))
    //        let newPlot3 = Sample(dateSampled: "09/4/29", notes: "TINY NOTES", image: UIImage(imageLiteralResourceName: "hb1"))
    //        individualPlots.append(newPlot1)
    //    //    ExperimentsView.individualPlots.append(newPlot2)
    //    //    ExperimentsView.individualPlots.append(newPlot3)
    //    }
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
}
