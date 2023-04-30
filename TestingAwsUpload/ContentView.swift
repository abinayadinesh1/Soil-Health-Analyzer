//
//  ContentView.swift
//  TestingAwsUpload
//
//  Created by Abinaya on 4/22/23.
//
import SwiftUI
import Combine
import Amplify
import AWSCognitoAuthPlugin
import AWSAPIPlugin
import AWSDataStorePlugin
import AWSS3StoragePlugin
import AWSPluginsCore

struct ContentView: View {
    let imageKey: String = "test-image"
    @State var inputImage: UIImage
    @State var showingImagePicker = false
    
    var body: some View {
        VStack(spacing: 40){
            Text("Welcome to Munsell Ag!").font(.largeTitle).foregroundColor(.red).multilineTextAlignment(.center).font(
                .custom(
                "SourceSansPro-Regular",
                size: 34)
            )
            Text("Please upload an image of your soil below to get a color analysis").font(.subheadline).multilineTextAlignment(.center)

            Image(uiImage: self.inputImage)
                    .resizable()
                    .cornerRadius(10)
                    .padding(.all, 4)
                    .frame(width: 200, height: 200)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Rectangle())
                    .padding(.top, 10)
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$inputImage)
        }

            
            Text("Click to select an image of your soils.")
                .font(.headline)
                .frame(height: 50)
                .foregroundColor(.black)
                .padding(.horizontal, 20)
                .onTapGesture {
                    showingImagePicker = true
                }
            Button("Upload", action: uploadImageButton)
            Button("Download", action: downloadImageButton)
        }
    
    }
    
    func uploadImage() async{
        print("hellp")
        let inputImageData = inputImage.jpegData(compressionQuality: 0.7)! //this converts the image to data with no compression
        
        //format from documentation https://docs.amplify.aws/lib/storage/upload/q/platform/ios/#upload-data
        let uploadTask = Amplify.Storage.uploadData(
            key: imageKey,
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

    func downloadImageButton() {
        Task {
            do {
                try await downloadImage()
            }
            catch {
                print(error)
            }
        }
    }
    func downloadImage() async{
        let downloadTask = Amplify.Storage.downloadData(key: imageKey)
        Task {
            for await progress in await downloadTask.progress {
                print("Progress: \(progress)")
            }
        }
        
        do {
            let data = try await downloadTask.value
            print("Completed: \(data)")
        } catch {
            //handle error
            print(error)
        }    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(inputImage: UIImage(systemName: "photo")!)
    }
}
