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
         service: StorageService,
         coordinator: MainModuleCoordinator)
    func uploadToTheStorage(_ image: UIImage) async
    func downloadFromTheStorage() async -> [UIImage]
    func openToFullScreen(data: [UIImage],
                          index: Int)
}

final class GalleryAllPhotosPresenterImpl: GalleryAllPhotosPresenter {
    
    weak var view: GalleryAllPhotosViewController?
    
    private let user: User
    private let service: StorageService
    private let coordinator: MainModuleCoordinator

    init(view: GalleryAllPhotosViewController,
         user: User,
         service: StorageService,
         coordinator: MainModuleCoordinator) {
        
        self.view = view
        self.user = user
        self.service = service
        self.coordinator = coordinator
    }
    
    func openToFullScreen(data: [UIImage],
                          index: Int) {
        coordinator.pushToFullScreen(data: data,
                                     index: index)
    }
    
    func uploadToTheStorage(_ image: UIImage) async {
        await service.uploadToTheStorage(user: user,
                                   photo: Photo(),
                                   image: image)
    }
    
    func downloadFromTheStorage() async -> [UIImage] {
        var data = [UIImage]()
        do {
            print("succeeded download")
            data = try await service.downloadFormDataBase(user: user)

            return data
        }
        catch {
            print("error download")
            return data
        }
    }
}
