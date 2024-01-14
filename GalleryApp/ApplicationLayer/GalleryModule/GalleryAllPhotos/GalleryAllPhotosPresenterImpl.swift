//
//  GalleryPresenter.swift
//  ScrollViewTest
//
//  Created by дэвид Кихтенко on 15.11.2023.
//

import Foundation
import UIKit

protocol GalleryAllPhotosPresenter: AnyObject {
    init(view: GalleryAllPhotosViewController,
         user: User,
         service: StorageService)
    func uploadToTheStorage(_ image: UIImage) async
    func downloadFromTheStorage()
}

final class GalleryAllPhotosPresenterImpl: GalleryAllPhotosPresenter {
    weak var view: GalleryAllPhotosViewController?
    private let user: User
    private let service: StorageService

    init(view: GalleryAllPhotosViewController,
         user: User,
         service: StorageService) {
        
        self.view = view
        self.user = user
        self.service = service
    }
    
    func uploadToTheStorage(_ image: UIImage) async {
        await service.uploadToTheStorage(user: user,
                                   photo: Photo(),
                                   image: image)
    }
    
    func downloadFromTheStorage() {
        service.downloadFromTheStorage()
    }
}
