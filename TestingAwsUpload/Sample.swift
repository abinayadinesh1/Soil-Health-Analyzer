//
//  Sample.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 6/18/23.
//

import Foundation
import SwiftUI
import Combine
import Amplify
import AWSCognitoAuthPlugin
import AWSDataStorePlugin
import AWSS3StoragePlugin
import AWSPluginsCore

struct Sample: View, Identifiable {
    @State var presentAlert = false
    @State var navigate = false
    @State var dateSampled: String = "MM-DD-YYYY"
    @State var notes: String = "Found some spider mites on the plants, cleaned with diluted dish soap and praying they wont come back "
    @State var image: UIImage = UIImage(imageLiteralResourceName: "green")
//    @Binding var individualPlotsValueFromParent: [Sample] //DO I NEED TO RESTATE AS BINDING? DEFINED IN PARENT CLASS ALREADY!
    @Binding var valFromParent : Int
    @State var showingImagePicker = false
    var id: UUID = UUID()
    var imageKey: String = "test-image"
    var body: some View {
        VStack {
            HStack {
                Text("Date Sampled: ")
                TextField("\(dateSampled)", text: $dateSampled, prompt: Text("Date Image Taken")).font(.title2).onAppear(perform: getDate).foregroundColor(.red)
            }
            HStack {
                Text("Additional Notes: ")
                TextField(" ", text: $notes, prompt: Text("Additional Notes")).font(.title2).multilineTextAlignment(.center)
            }
            
            Image(uiImage: image)
                .resizable()
                .cornerRadius(10)
                .padding(.all, 4)
                .frame(width: 200, height: 200)
                .aspectRatio(contentMode: .fill)
                .clipShape(Rectangle())
                .padding(.top, 10)
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
                }
            
            Text("Click to select an image of your plot.")
                .background(Color.blue)
                .cornerRadius(8)
                .font(.headline)
                .foregroundColor(.black)
                .padding(30)
                .onTapGesture {
                    showingImagePicker = true
                }
//            Button("Upload", action: uploadImageButton)
//            Button("List All", action: listAllButton) //user doesnt need this
            Button("Save Sample", action: createIndividualPlot).alert(isPresented: $presentAlert) {
                Alert(title: Text("Saved"), message: Text("Click 'Back' to return to the main screen."))
            }
        }.padding()
    }
    func createIndividualPlot() {
//        uploadImageButton()
        self.valFromParent += 1
        presentAlert = true
//        let newPlot = Sample(dateSampled: dateSampled, notes: notes, image: image, individualPlots: $individualPlots) //saves the old state of the plots
//        self.individualPlots.append(newPlot) //updates the state to accept the newly made plot
//        presentAlert = true
//        print("full list of individualPlots", self.individualPlots)
            }
        func getDate() {
            let currDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            dateSampled = dateFormatter.string(from: currDate)
        }
        func uploadImage() async{
            let randomInt = Int.random(in: 1..<900000)
            let date = Date()
            let dateFormatter = DateFormatter()
             
            dateFormatter.dateFormat = "MM-dd-yyyy"
             
            let formattedDate = dateFormatter.string(from: date)
            
            let inputImageData = image.jpegData(compressionQuality: 0.7)! //this converts the image to data with no compression
            
            //format from documentation https://docs.amplify.aws/lib/storage/upload/q/platform/ios/#upload-data
            
            let uploadTask = Amplify.Storage.uploadData(
                key: "\(formattedDate)userUpload\(randomInt)",
                data: inputImageData
            )
            Task {
                for await progress in await uploadTask.progress {
                    print("Progress: \(progress)")
                }
            }
            do {
                let value = try? await uploadTask.value
                print("Completed: \(value ?? "nil")")
            } catch {
                //handle error
                print(error)
            }
        }
        func uploadImageButton() {
            Task {
                do {
                    try await uploadImage()
                }
                catch {
                    print(error)
                }
            }
        }
        func listAllButton(){
            Task {
                do {
                    try await listAll()
                }
                catch {
                    print(error)
                }
            }
        }
        func listAll() async{
            print("list everything in my bucket please")
            do {
                let listResult = try await Amplify.Storage.list()
                listResult.items.forEach { item in
                    print("Key: \(item.key)")
                }
            } catch {
                //handle error
                print(error)
            }
        }
    }
//dateSampled: String, notes: String, image: UIImage, updatedIndividualPlots: [Sample]



//    .alert(isPresented: $presentAlert) {
//        VStack {
//            Text("Saved")
//            NavigationLink {
//                GridView(updatedIndividualPlots: updatedIndividualPlots)
//            } label: {
//                Text("Back to Your Plots")
//            }
//        } do {}
//    }



//used for getting images back from aws; if we wanted to render a grid, we could list all and for every image get it (from the image key) and the associated info from the persisted state.
//    func downloadImageButton() {
//        Task {
//            do {
//                try await downloadImage()
//            }
//            catch {
//                print(error)
//            }
//        }
//    }
//    func downloadImage() async{
//        let downloadTask = Amplify.Storage.downloadData(key: imageKey)
//        Task {
//            for await progress in await downloadTask.progress {
//                print("Progress: \(progress)")
//            }
//        }
//
//        do {
//            let data = try await downloadTask.value
//            print("Completed: \(data)")
//        } catch {
//            //handle error
//            print(error)
//        }
//
//    }
