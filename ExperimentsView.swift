import SwiftUI
import Amplify

struct ExperimentsView: View {
    private var experiments: [Experiment] = [
        Experiment(id: UUID(), plotTitle: "Tomato Plot", date: Date(timeIntervalSinceReferenceDate: -3), samples: [
            Sample(dateSampled: Date(timeIntervalSinceNow: -1), notes: "Day 3", image: UIImage(imageLiteralResourceName: "day3_t"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
            Sample(dateSampled: Date(timeIntervalSinceNow: -2), notes: "Day 2", image: UIImage(imageLiteralResourceName: "day2_t"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
            Sample(dateSampled: Date(timeIntervalSinceNow: -3), notes: "Day 1", image: UIImage(imageLiteralResourceName: "day1_t"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time")
        ], plotDescription: "cherry tomato seeds bought from grocery store, planting in pot and using clove oil to avoid pests", selectedWateringSchedule: "Weekly", selectedIrrigationType: "Sprinkler", selectedUpdateCadence: "Daily", previewImage: "cherry_tomato"),
        Experiment(id: UUID(), plotTitle: "Squash Plant", date: Date(timeIntervalSinceNow: -2), samples: [
            Sample(dateSampled: Date(timeIntervalSinceNow: -1), notes: "Day 2", image: UIImage(imageLiteralResourceName: "day2_s"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
            Sample(dateSampled: Date(timeIntervalSinceNow: -2), notes: "Day 1", image: UIImage(imageLiteralResourceName: "day1_s"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
        ], plotDescription: "I hope my squash grow!", selectedWateringSchedule: "Weekly", selectedIrrigationType: "Sprinkler", selectedUpdateCadence: "Daily", previewImage: "squash"),
        Experiment(id: UUID(), plotTitle: "Zucchini Plant", date: Date(timeIntervalSinceNow: -4), samples: [
            Sample(dateSampled: Date(timeIntervalSinceNow: -1), notes: "Day 5", image: UIImage(imageLiteralResourceName: "day4_z"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
            Sample(dateSampled: Date(timeIntervalSinceNow: -2), notes: "Day 4", image: UIImage(imageLiteralResourceName: "day3_z"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
            Sample(dateSampled: Date(timeIntervalSinceNow: -3), notes: "Day 3", image: UIImage(imageLiteralResourceName: "day2_z"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
            Sample(dateSampled: Date(timeIntervalSinceNow: -4), notes: "Day 2", image: UIImage(imageLiteralResourceName: "day1_z"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
        ], plotDescription: "I love zuchinni and I wonder if I can get this to grow after trying for 2 seasons.", selectedWateringSchedule: "Weekly", selectedIrrigationType: "Sprinkler", selectedUpdateCadence: "Daily", previewImage: "zuchini_plant"),
        Experiment(id: UUID(), plotTitle: "Mint Circle Pot", date: Date(timeIntervalSinceNow: -6), samples: [
            Sample(dateSampled: Date(timeIntervalSinceNow: -1), notes: "Day 6", image: UIImage(imageLiteralResourceName: "green"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
            Sample(dateSampled: Date(timeIntervalSinceNow: -1), notes: "Day 5", image: UIImage(imageLiteralResourceName: "green"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
            Sample(dateSampled: Date(timeIntervalSinceNow: -2), notes: "Day 4", image: UIImage(imageLiteralResourceName: "green"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
            Sample(dateSampled: Date(timeIntervalSinceNow: -3), notes: "Day 3", image: UIImage(imageLiteralResourceName: "green"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
            Sample(dateSampled: Date(timeIntervalSinceNow: -4), notes: "Day 2", image: UIImage(imageLiteralResourceName: "green"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
            Sample(dateSampled: Date(timeIntervalSinceNow: -5), notes: "Day 1", image: UIImage(imageLiteralResourceName: "green"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time")
        ], plotDescription: "Had to transfer to pot because roots were crowding other plants", selectedWateringSchedule: "Custom", selectedIrrigationType: "None", selectedUpdateCadence: "Daily", previewImage: "mint"),
        Experiment(id: UUID(), plotTitle: "Indoor Succulent", date: Date(timeIntervalSinceReferenceDate: -2), samples: [
            Sample(dateSampled: Date(timeIntervalSinceReferenceDate: -1), notes: "Week 2", image: UIImage(imageLiteralResourceName: "day2_suc"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
            Sample(dateSampled: Date(timeIntervalSinceReferenceDate: -2), notes: "Week 1", image: UIImage(imageLiteralResourceName: "day1_suc"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
        ], plotDescription: "MY NEW BABY FROM THE FARMER'S MARKET", selectedWateringSchedule: "Monthly", selectedIrrigationType: "Custom", selectedUpdateCadence: "Weekly", previewImage: "succulent")
    ]
    @State private var showAddExperimentSheet = false
    @State private var isPresentingAddExperimentAlert = false
    @State private var newExperimentName: String = ""
    @State private var newExperimentDate: String = ""
    
    var body: some View {
        NavigationView {
            ZStack{
                Image("background").resizable()
                VStack {
                    if experiments.isEmpty {
                        Text("No Experiments Available")
                            .emptyTextStyle()
                    } else {
                        List {
                            ForEach(experiments) { experiment in
                                NavigationLink(destination: ExperimentView(experiment: experiment)) {
                                    HStack {
                                        Image(experiment.previewImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 60, alignment: .center)
                                            .clipped()
                                        VStack (alignment: .leading) {
                                            Text(experiment.plotTitle)
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
            }   .navigationBarTitle("My Experiments")
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
        }.task {
            await retrieveExperiments()
        }
    }
    
    
    func retrieveExperiments() async {
        
        //query for the experiments
        do {
            let experiments = try await Amplify.DataStore.query(ExperimentGraphQL.self)
            for experiment in experiments {
                print(experiment.title)
            }
        } catch {
            print("Could not query DataStore: \(error)")
        }
    }
    func updateExperiment() async {
        do {
            let experiments = try await Amplify.DataStore.query(ExperimentGraphQL.self,
                                                          where: ExperimentGraphQL.keys.title.eq("new title for experiment"))
            guard experiments.count == 1, var updatedExperiments = experiments.first else {
                print("Did not find exactly one todo, bailing")
                return
            }
            updatedExperiments.title = "new title for experiment"
            let savedExperiment = try await Amplify.DataStore.save(updatedExperiments)
            print("Updated item: \(savedExperiment.title)")
        } catch {
            print("Unable to perform operation: \(error)")
        }
    }
    func deleteExperiment() async {
        do {
            let experiments = try await Amplify.DataStore.query(ExperimentGraphQL.self,
                                                                where: ExperimentGraphQL.keys.title.eq("new title for experiment"))
            guard experiments.count == 1, let toDeleteExperiment = experiments.first else {
                print("Did not find exactly one todo, bailing")
                return
            }
            try await Amplify.DataStore.delete(toDeleteExperiment)
            print("Deleted item: \(toDeleteExperiment.title)")
        } catch {
            print("Unable to perform operation: \(error)")
        }
    }
    func addExperiment() async {
        do {
            let item = ExperimentGraphQL(id: "id1",
                            title: "Build an iOS application using Amplify")
            let savedItem = try await Amplify.DataStore.save(item)
            print("Saved item: \(savedItem.id)")
        } catch {
            print("Could not save item to DataStore: \(error)")
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
