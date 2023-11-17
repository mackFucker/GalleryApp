//
//  GalleryFullScreenViewController.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 17.11.2023.
//

import UIKit

final class GalleryFullScreenViewControllerImpl: UIViewController {
    var mockDataArray: [String] = []
    
    init(mockDataArray: [String],
         index: CGFloat) {
        
        super.init(nibName: nil, bundle: nil)
        
        self.mockDataArray = mockDataArray
        let widht = view.frame.width
        collectionView.contentOffset.x = widht * index
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        setTransparentNavigationbar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false,
                                                     animated: animated)
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        let collectionView = UICollectionView(frame: view.bounds,
                                              collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(FullScreenPhotoCell.self,
                                forCellWithReuseIdentifier: FullScreenPhotoCell.identifier)
        return collectionView
    }()
    
    private func setTransparentNavigationbar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true

        navigationController?.navigationBar.barTintColor = .clear
    }
}

extension GalleryFullScreenViewControllerImpl: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        mockDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FullScreenPhotoCell.identifier,
                                                      for: indexPath as IndexPath) as! FullScreenPhotoCell
        cell.setupPhoto(mockDataArray[indexPath.row])
        return cell
    }
}

extension GalleryFullScreenViewControllerImpl: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        let height = view.frame.height
        return CGSize(width: width,
                      height: height)
    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        insetForSectionAt section: Int) -> UIEdgeInsets {
//        
//        return UIEdgeInsets(top: 1,
//                            left: 1,
//                            bottom: 1,
//                            right: 1)
//    }
}
