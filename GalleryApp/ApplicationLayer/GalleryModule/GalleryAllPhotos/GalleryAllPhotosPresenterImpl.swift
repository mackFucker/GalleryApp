//
//  GalleryPresenter.swift
//  ScrollViewTest
//
//  Created by дэвид Кихтенко on 15.11.2023.
//

import Foundation

protocol GalleryAllPhotosPresenter: AnyObject {
    init(view: GalleryAllPhotosViewController,
         user: User)
}

final class GalleryAllPhotosPresenterImpl: GalleryAllPhotosPresenter {
    weak var view: GalleryAllPhotosViewController?
    var user: User
//    private let photos: [Photo]
    init(view: GalleryAllPhotosViewController,
         user: User) {
        
        self.view = view
        self.user = user
    }
}
