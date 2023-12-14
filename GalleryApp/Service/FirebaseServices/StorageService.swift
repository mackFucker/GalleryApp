//
//  StorageService.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 05.12.2023.
//

import Foundation
import FirebaseStorage

final class StorageService {
    
    let storage = Storage.storage(url: "gs://guarddisk-19f6a.appspot.com")
   

    private init () { }
    
    //после реги выделяем папку под пользователя вызывается единожды при регистрации
    
    
    //при запучке приложения достаем все из этой папки
    
    
    //должны быть какая-то функция для выгрузки фото в хранилище
    
    
    func addPhotos() {
        let storageRef = storage.reference()
    }
    
    func removePhotos() {
        
    }
    
    func downloadPhotos() {
        
    }
}
