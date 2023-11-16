//
//  GalleryPresenter.swift
//  ScrollViewTest
//
//  Created by дэвид Кихтенко on 15.11.2023.
//

import Foundation

protocol GalleryAllPhotosPresenter: AnyObject {
    init(view: GalleryAllPhotosViewController)
}

final class GalleryAllPhotosPresenterImpl: GalleryAllPhotosPresenter {
    unowned let view: GalleryAllPhotosViewController
//    private let photos: [Photo]
    
    init(view: GalleryAllPhotosViewController) {
        self.view = view
//        self.photos = photos
    }
}
