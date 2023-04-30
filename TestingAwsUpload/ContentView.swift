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
    @State var image: UIImage
    
    var body: some View {
        VStack(spacing: 40){
            Text("Welcome to Munsell Ag!").font(.largeTitle).foregroundColor(.red).multilineTextAlignment(.center)
            Text("Please upload an image of your soil below to get a color analysis").font(.subheadline).multilineTextAlignment(.center)
            Image(uiImage: image).resizable().aspectRatio(1, contentMode: .fit).frame(width: 100, height: 100)
            

            Button("Upload", action: uploadImageButton)
            Button("Download", action: downloadImageButton)
        }
    
    }
    
    func uploadImage() async{
        print("hellp")
        let testImage = UIImage(systemName: "circle")!
        let testImageData = testImage.jpegData(compressionQuality: 1)! //this converts the image to data with no compression
        
        //format from documentation https://docs.amplify.aws/lib/storage/upload/q/platform/ios/#upload-data
        let uploadTask = Amplify.Storage.uploadData(
            key: imageKey,
            data: testImageData
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
        ContentView(image: UIImage(systemName: "house")!)
    }
}
