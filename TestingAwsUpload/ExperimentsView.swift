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
        Experiment(id: UUID(), name: "Tomato Plot", date: "06/10/23", plots: [])
    ]
    @State var currentValue: Int = 0
    @State private var showAll = false
    @State private var isPresentingAddExperimentAlert = false
    @State private var newExperimentName: String = ""
    @State private var newExperimentDate: String = ""
    
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
                                HStack {
                                    Image("sprout")
                                        .frame(width: 50.0, height: 50.0)
                                    VStack {
                                        Text(experiment.name)
                                            .font(.title2)
                                            .bold()
                                        Text(experiment.date)
                                            .font(.subheadline)
                                    }
                                    .frame(height: 50)
                                    
                                }
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
                TextField("Date Started", text: $newExperimentDate)
                Button("OK", action: {
                    //TODO: Add Experiment via AWS
                    experiments.append(Experiment(id: UUID(), name: newExperimentName, date: "06.10.22", plots: []))
                })
                Button("Cancel", role: .cancel) {
                    isPresentingAddExperimentAlert.toggle()
                }
            }
        }
        .tint(Color.green)
    }
}
