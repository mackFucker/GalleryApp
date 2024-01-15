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
                if let data = try? Data(contentsOf: downloadURL),
                   let image = UIImage(data: data) {
                    outputImages.append(image)
                }
            }
            catch {
                print("ERROR: download error")
            }
        }
        print(images)
        
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
            //            return false
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
                //                return false
            }
        }
        catch {
            print("ERROR: uploading image to")
            //            return false
        }
        
        let collectionString = "spots/\(userID)/photos"
        
        do {
            var newPhoto = photo
            newPhoto.imageURlSTring = imageURlSTring
            try await db.collection(collectionString).document(photoName).setData(newPhoto.dictionary)
            print("data update succesfully")
            //            return true
        }
        catch {
            print("ERROR: Could not update data in 'reviews' for spotID \(userID)")
            //            return false
        }
    }
}

enum Error: Swift.Error {
    case cannotDownloadImage
}
