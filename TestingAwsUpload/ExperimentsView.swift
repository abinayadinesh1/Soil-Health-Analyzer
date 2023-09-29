import SwiftUI
import Amplify

struct ExperimentsView: View {
    @State var experiments: [Experiment] = [
        Experiment(id: UUID(), plotTitle: "Tomato Plot", date: Date(timeIntervalSinceNow: -20), samples: [
            Sample(dateSampled: Date(timeIntervalSinceNow: -1), notes: "Day 3", image: UIImage(imageLiteralResourceName: "day3_t"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
            Sample(dateSampled: Date(timeIntervalSinceNow: -2), notes: "Day 2", image: UIImage(imageLiteralResourceName: "day2_t"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
            Sample(dateSampled: Date(timeIntervalSinceNow: -3), notes: "Day 1", image: UIImage(imageLiteralResourceName: "day1_t"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time")
        ], plotDescription: "cherry tomato seeds bought from grocery store, planting in pot and using clove oil to avoid pests", selectedWateringSchedule: "Weekly", selectedIrrigationType: "Sprinkler", selectedUpdateCadence: "Daily", previewImage: "cherry_tomato"),
        Experiment(id: UUID(), plotTitle: "Squash Plant", date: Date(timeIntervalSinceNow: -18), samples: [
            Sample(dateSampled: Date(timeIntervalSinceNow: -1), notes: "Day 2", image: UIImage(imageLiteralResourceName: "day2_s"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
            Sample(dateSampled: Date(timeIntervalSinceNow: -2), notes: "Day 1", image: UIImage(imageLiteralResourceName: "day1_s"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
        ], plotDescription: "I hope my squash grow!", selectedWateringSchedule: "Weekly", selectedIrrigationType: "Sprinkler", selectedUpdateCadence: "Daily", previewImage: "squash"),
        Experiment(id: UUID(), plotTitle: "Zucchini Plant", date: Date(timeIntervalSinceNow: -16), samples: [
            Sample(dateSampled: Date(timeIntervalSinceNow: -1), notes: "Day 5", image: UIImage(imageLiteralResourceName: "day4_z"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
            Sample(dateSampled: Date(timeIntervalSinceNow: -2), notes: "Day 4", image: UIImage(imageLiteralResourceName: "day3_z"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
            Sample(dateSampled: Date(timeIntervalSinceNow: -3), notes: "Day 3", image: UIImage(imageLiteralResourceName: "day2_z"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
            Sample(dateSampled: Date(timeIntervalSinceNow: -4), notes: "Day 2", image: UIImage(imageLiteralResourceName: "day1_z"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
        ], plotDescription: "I love zuchinni and I wonder if I can get this to grow after trying for 2 seasons.", selectedWateringSchedule: "Weekly", selectedIrrigationType: "Sprinkler", selectedUpdateCadence: "Daily", previewImage: "zuchini_plant"),
        Experiment(id: UUID(), plotTitle: "Mint Circle Pot", date: Date(timeIntervalSinceNow: -12), samples: [
            Sample(dateSampled: Date(timeIntervalSinceNow: -1), notes: "Day 6", image: UIImage(imageLiteralResourceName: "green"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
            Sample(dateSampled: Date(timeIntervalSinceNow: -1), notes: "Day 5", image: UIImage(imageLiteralResourceName: "green"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
            Sample(dateSampled: Date(timeIntervalSinceNow: -2), notes: "Day 4", image: UIImage(imageLiteralResourceName: "green"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
            Sample(dateSampled: Date(timeIntervalSinceNow: -3), notes: "Day 3", image: UIImage(imageLiteralResourceName: "green"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
            Sample(dateSampled: Date(timeIntervalSinceNow: -4), notes: "Day 2", image: UIImage(imageLiteralResourceName: "green"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time"),
            Sample(dateSampled: Date(timeIntervalSinceNow: -5), notes: "Day 1", image: UIImage(imageLiteralResourceName: "green"), id: UUID(), waterAnalysis: "water_time", OMAnalysis: "OM_time")
        ], plotDescription: "Had to transfer to pot because roots were crowding other plants", selectedWateringSchedule: "Custom", selectedIrrigationType: "None", selectedUpdateCadence: "Daily", previewImage: "mint"),
        Experiment(id: UUID(), plotTitle: "Indoor Succulent", date: Date(timeIntervalSinceReferenceDate: -10), samples: [
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
                Image("green_bg_long").resizable()
                ScrollView{
                    VStack {
                        VStack {
                            Spacer(minLength: 85)
                        HStack {
                            Text("Plots 🌱")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding(.leading, 15)
                                .leftAligned()
                            Button(action: {
                                showAddExperimentSheet.toggle()
                            }) {
                                Image(systemName: "plus")
                                    .foregroundColor(.green)
                            }
                            .rightAligned()
                            .padding(.trailing, 15)
                            
                        }
                    }
                            VStack{
                                if experiments.isEmpty {
                                    Text("No Experiments Available")
                                        .emptyTextStyle()
                                }
                                else {
                                    ForEach(experiments) { experiment in
                                        NavigationLink(destination: ExperimentView(experiments: $experiments, experiment: experiment)) {
                                            HStack (alignment: .center) {
                                                Image(experiment.previewImage)
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 80, height: 80, alignment: .center)
                                                    .clipped()
                                                VStack (alignment: .leading) {
                                                    Text(experiment.plotTitle)
                                                        .font(.title2)
                                                        .foregroundColor(.black)
                                                        .bold()
                                                    Text("Started: \(experiment.date.formatted(date: .abbreviated, time: .omitted))")
                                                        .font(.subheadline)
                                                        .foregroundColor(.black)
                                                }
                                            }
                                            .frame(width: 350, height: 110)
                                            .background(Color(red: 240, green: 253, blue: 243))
                                            .cornerRadius(10)
                                        }
                                        .navigationBarHidden(true)
                                    }
                                }
                            }
                        }
                        .navigationBarHidden(true)
                }
            .ignoresSafeArea()
            .navigationBarHidden(true)
            .sheet(isPresented: $showAddExperimentSheet) {
                AddExperimentView(experiments: $experiments, newDate: Date(timeIntervalSinceNow: 0))
            }
            .task {
                await retrieveExperiments()
            }
        }
            .navigationBarHidden(true)
            .ignoresSafeArea()
            }
        .navigationBarHidden(true)
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
