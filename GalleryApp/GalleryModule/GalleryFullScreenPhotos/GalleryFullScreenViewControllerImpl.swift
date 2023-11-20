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
        collectionView.contentOffset.x = widht * index + ((index - 1) * 20) + 20
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
        layout.minimumLineSpacing = 20
        let collectionViewFrame = CGRect(origin: view.frame.origin,
                                         size: CGSize(width: view.frame.width + 20,
                                                      height: view.frame.height))
        
        let collectionView = UICollectionView(frame: collectionViewFrame,
                                              collectionViewLayout: layout)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        collectionView.contentInset =  UIEdgeInsets(top: 0, left: 0,
                                                    bottom: 0, right: 20)
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(FullScreenPhotoCell.self,
                                forCellWithReuseIdentifier: FullScreenPhotoCell.identifier)
        return collectionView
    }()
    
    private func setTransparentNavigationbar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = appearance
    }
}

extension GalleryFullScreenViewControllerImpl: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return mockDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FullScreenPhotoCell.identifier,
                                                      for: indexPath as IndexPath) as! FullScreenPhotoCell
        cell.setupPhoto(mockDataArray[indexPath.row])
        cell.frame.origin.y = collectionView.bounds.origin.y
        return cell
    }
}

extension GalleryFullScreenViewControllerImpl: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.bounds.width
        let height = view.bounds.height
        
        return CGSize(width: width,
                      height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        
        (collectionView.cellForItem(at: indexPath) as! FullScreenPhotoCell).diactivateZoom()
    }
}
