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
        Experiment(id: UUID(), name: "Tomato Plot", date: Date(), samples: [
            Sample(dateSampled: Date(), notes: "Hello World!", image: UIImage(imageLiteralResourceName: "green"), id: UUID())
        ], description: "", selectedWateringSchedule: "", selectedIrrigationType: "", selectedUpdateCadence: "", previewImage: "")
    ]
    @State private var showAddExperimentSheet = false
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
                            NavigationLink(destination: ExperimentView(experiment: experiment)) {
                                HStack {
                                    Image("sprout")
                                        .frame(width: 50.0, height: 50.0)
                                    VStack {
                                        Text(experiment.name)
                                            .font(.title2)
                                            .bold()
                                        Text("Started: \(experiment.date.formatted(date: .abbreviated, time: .omitted))")
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
                        showAddExperimentSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.green)
                    }
                }
            }
            .sheet(isPresented: $showAddExperimentSheet) {
                AddExperimentView()
            }
        }
        .tint(Color.green)
    }
}

//MARK: - AddExperimentView
struct AddExperimentView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var newPlotTitle: String = ""
    @State private var newPlotDescription: String = ""
    @State private var newSelectedWateringSchedule: String = "Weekly"
    @State private var newSelectedIrrigationType: String = "Drip"
    @State private var newSelectedUpdateCadence: String = "Daily"
    @State private var showAlert: Bool = false
    @State private var samples: [Sample] = []

    var previewImage: String = ""
    let wateringOptions = ["Daily", "Weekly", "Monthly", "Custom"]
    let irrigationOptions = ["Drip", "Furrow", "Flood", "Sprinkler", "Custom"]
    let updateCadenceOptions = ["Daily","Every 3 Hours", "Every 6 Hours", "Every 2 Days", "Every 3 Days"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    TextFieldHeaderView(header: "Title:", text: $newPlotTitle)
                    TextFieldHeaderView(header: "Description:", text: $newPlotDescription)

                    Text("⚠️ Reminder: Pictures must be uploaded 3-4 times between watering for accurate results").font(.subheadline)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)

                    HStack {
                        Text("Watering Schedule: ")
                            .bold()
                        Spacer()
                        Picker("Watering Schedule: ", selection: $newSelectedWateringSchedule) {
                            ForEach(wateringOptions, id: \.self) {
                                Text($0)
                            }
                        }
                        .tint(.green)
                        .pickerStyle(.menu)
                    }

                    HStack {
                        Text("Irrigation Type: ")
                            .bold()
                        Spacer()
                        Picker("Irrigation Type: ", selection: $newSelectedIrrigationType) {
                            ForEach(irrigationOptions, id: \.self) {
                                Text($0)
                            }
                        }
                        .tint(.green)
                        .pickerStyle(.menu)
                    }

                    HStack {
                        Text("Pictures Updated: ")
                            .bold()
                        Spacer()
                        Picker("Pictures Updated: ", selection: $newSelectedUpdateCadence) {
                            ForEach(updateCadenceOptions, id: \.self) {
                                Text($0)
                            }
                        }
                        .tint(.green)
                        .pickerStyle(.menu)
                    }

                    Image(previewImage).resizable().scaledToFill()
                        .frame(width: 150, height: 150)

                    addButton
                }
                .padding()
            }
            .navigationBarTitle("New Experiment")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 25))
                            .foregroundColor(Color(uiColor: .lightGray))
                    }
                }
            }
        }
    }

    private var addButton: some View {
       Button(action: {
           //TODO: Upload to AWS
           dismiss()
       }) {
           Text("Confirm")
               .centered()
               .padding()
               .foregroundColor(.white)
               .font(.system(size: 20).bold())
               .background(
                   RadialGradient(gradient: Gradient(colors: [.blue.opacity(0.4), .purple.opacity(0.5)]), center: .center, startRadius: 1, endRadius: 150)
               )
               .cornerRadius(10.0)
               .shadow(color: .purple.opacity(0.8), radius: 20, x: 0, y: 0)
       }
   }
}

//MARK: - TextFieldHeaderView
struct TextFieldHeaderView: View {
    var header: String
    @Binding var text: String

    var body: some View {
        VStack {
            Text(header)
                .bold()
                .leftAligned()
            TextField(" ", text: $text)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(uiColor: .lightGray), lineWidth: 2)
                )
        }
    }
}
