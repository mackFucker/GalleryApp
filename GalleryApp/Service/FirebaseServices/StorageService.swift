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

typealias User = FirebaseAuth.User

final class StorageService {
    
    private let db = Firestore.firestore()
    private init () { }
    
    //после реги выделяем папку под пользователя вызывается единожды при регистрации
    
    //при запуcке приложения достаем все из этой папки
    
    //должны быть какая-то функция для выгрузки фото в хранилище
    func uploadImages(user: User) -> Photo {
        return Photo(id: "uploadImages")
    }
    
    func saveImage(user: User,
                   photo: Photo,
                   image: UIImage) async -> Bool {
        
        let userID = user.uid
        let photoName = UUID().uuidString
        
        let storage = Storage.storage()
        let storageRef = storage.reference().child("\(userID)/\(photoName).jpeg")
        
        guard let resizedImage = image.jpegData(compressionQuality: 0.2) else {
            print("cloud not resize image")
            return false
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
            catch
            {
                print("ERROR: Could not get imageURL after saving image")
                return false
            }
        }
        catch {
            print("ERROR: uploading image to")
            return false
        }
        
        let collectionString = "spots/\(userID)/photos"
        
        do {
            var newPhoto = photo
            newPhoto.imageURlSTring = imageURlSTring
            try await db.collection(collectionString).document(photoName).setData(newPhoto.dictionary)
            print("data update succesfully")
            return true
        }
        catch {
            print("ERROR: Could not update data in 'reviews' for spotID \(userID)" )
            return false
        }
    }
    
//    func removePhotos() {
//        
//    }
//    
//    func downloadPhotos() {
//        
//    }
}
