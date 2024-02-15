//
//  StorageService.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 05.12.2023.
//

import UIKit
import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

final class StorageService {
    static let share = StorageService()
    
    private let storage = Storage.storage()
    private let db = Firestore.firestore()
    private init () { }
    
        func downloadFromTheStorage(user: User) async throws -> [UIImage] {
            let userID = user.uid
            let storageRef = storage.reference().child(userID)
            var outputImages = [UIImage]()
    
            let result = try await storageRef.listAll()
            let images = result.items
    
            for image in images {
                do {
                    let downloadURL = try await image.downloadURL()
                    print(downloadURL)
                    if let data = try? Data(contentsOf: URL(string: "https://firebasestorage.googleapis.com:443/v0/b/guarddisk-19f6a.appspot.com/o/ojB13C2S8Zf1l96WQsoJg70ys973%2FF2EE2ACA-4CDB-4E33-96FD-181DAB69CAA7.jpeg?alt=media&token=7fb19aab-3413-417a-9c73-caa855d82021")!),
                       let image = UIImage(data: data) {
                        outputImages.append(image)
                    }
                }
                catch {
                    print("ERROR: download error")
                }
            }
            return outputImages
        }
    
    func downloadFormDataBase(user: User) async throws -> [UIImage] {
        let userID = user.uid
        let collectionString = "spots/\(userID)/photos"
        let docRef = db.collection(collectionString)
        let documents = try await docRef.getDocuments().documents
        
        var outputImages = [UIImage]()
        var photoModels = [Photo]()
        
        for doc in documents {
            if doc.exists {
                let dataDictionary = doc.data()
                let photoData = Photo(imageURlString: dataDictionary["imageURlSTring"] as! String,
                                      description: dataDictionary["description"] as! String,
                                      reviewer: dataDictionary["reviewer"] as! String,
                                      postedOn: dataDictionary["postedOn"] as! Date)
                                
                photoModels.append(photoData)
//                if let data = try? Data(contentsOf: URL(string: photoData.imageURlString)!) {
//                    print(photoData.imageURlString)
//                }
                
                //            FIXME: remove date hardcode and async throws???
            }
            else {
                print("error")
            }
        }
        
        return outputImages
    }
    
    func uploadToTheStorage(user: User,
                            photo: Photo,
                            image: UIImage) async {
        
        let userID = user.uid
        let photoName = UUID().uuidString
        
        let storageRef = storage.reference().child("\(userID)/\(photoName).jpeg")
        
        guard let resizedImage = image.jpegData(compressionQuality: 0.2) else {
            print("cloud not resize image")
            return
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image.jpg"
        
        var imageURlSTring = ""
        
        do {
            let _ = try await storageRef.putDataAsync(resizedImage, metadata: metadata)
            print("saved image")
            do {
                let imageURl = try await storageRef.downloadURL()
                imageURlSTring = "\(imageURl)"
            }
            catch {
                print("ERROR: Could not get imageURL after saving image")
            }
        }
        catch {
            print("ERROR: uploading image to")
        }
        
        let collectionString = "spots/\(userID)/photos"
        
        do {
            var newPhoto = photo
            newPhoto.imageURlString = imageURlSTring
            try await db.collection(collectionString).document(photoName).setData(newPhoto.dictionary)
            print("data update succesfully")
        }
        catch {
            print("ERROR: Could not update data in 'reviews' for spotID \(userID)")
        }
    }
}

enum Error: Swift.Error {
    case cannotDownloadImage
}
