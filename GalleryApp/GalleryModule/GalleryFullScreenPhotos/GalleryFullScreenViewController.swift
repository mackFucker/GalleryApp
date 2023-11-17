//
//  GalleryFullScreenViewController.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 17.11.2023.
//

import UIKit

final class GalleryFullScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false,
                                                     animated: animated)
    }
}
