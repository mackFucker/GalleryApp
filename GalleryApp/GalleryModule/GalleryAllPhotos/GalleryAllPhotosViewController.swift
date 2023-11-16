//
//  GalleryAllPhotosViewController.swift
//  ScrollViewTest
//
//  Created by дэвид Кихтенко on 15.11.2023.
//

import UIKit


protocol GalleryAllPhotosViewController: AnyObject {
    
}

final class GalleryAllPhotosViewControllerImpl: UIViewController {
    private var presenter: GalleryAllPhotosPresenter?
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = true
        presenter = GalleryAllPhotosPresenterImpl(view: self)
        view.addSubview(collectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    private lazy var collectionView: UICollectionView = {        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: view.bounds,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = .cyan
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "ffff")
        return collectionView
    }()
}

extension GalleryAllPhotosViewControllerImpl: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        navigationController?.pushViewController(ViewController(), animated: true)
    }
}

extension GalleryAllPhotosViewControllerImpl: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ffff",
                                                 for: indexPath as IndexPath)
        cell.contentView.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return 50
    }
}

extension GalleryAllPhotosViewControllerImpl: GalleryAllPhotosViewController {
    
}

extension GalleryAllPhotosViewControllerImpl: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 85,
                      height: 85)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 5,
                            left: 5,
                            bottom: 5,
                            right: 5)
    }
}
