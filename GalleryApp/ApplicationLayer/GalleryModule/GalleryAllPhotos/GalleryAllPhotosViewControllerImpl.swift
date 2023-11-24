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
    let mockDataArray = ["Wallpaper-New-York-Sky--T_bigapple2_0", "756038770746465",
                         "Wallpaper-New-York-Sky--T_bigapple2_0", "756038770746465", "Wallpaper-New-York-Sky--T_bigapple2_0",
                         "Wallpaper-New-York-Sky--T_bigapple2_0", "Wallpaper-New-York-Sky--T_bigapple2_0", "Wallpaper-New-York-Sky--T_bigapple2_0",
                         "466_634b8d691c6d3", "Wallpaper-New-York-Sky--T_bigapple2_0", "Wallpaper-New-York-Sky--T_bigapple2_0",
                         "images-4", "Wallpaper-New-York-Sky--T_bigapple2_0", "Wallpaper-New-York-Sky--T_bigapple2_0",
                         "Wallpaper-New-York-Sky--T_bigapple2_0", "maxresdefault", "Wallpaper-New-York-Sky--T_bigapple2_0", "756038770746465",
                         "Wallpaper-New-York-Sky--T_bigapple2_0", "756038770746465", "Wallpaper-New-York-Sky--T_bigapple2_0",
                         "Wallpaper-New-York-Sky--T_bigapple2_0", "Wallpaper-New-York-Sky--T_bigapple2_0", "Wallpaper-New-York-Sky--T_bigapple2_0",
                         "466_634b8d691c6d3", "Wallpaper-New-York-Sky--T_bigapple2_0", "Wallpaper-New-York-Sky--T_bigapple2_0",
                         "images-4", "Wallpaper-New-York-Sky--T_bigapple2_0", "Wallpaper-New-York-Sky--T_bigapple2_0",
                         "Wallpaper-New-York-Sky--T_bigapple2_0", "maxresdefault", "Wallpaper-New-York-Sky--T_bigapple2_0", "756038770746465",
                         "Wallpaper-New-York-Sky--T_bigapple2_0", "756038770746465", "Wallpaper-New-York-Sky--T_bigapple2_0",
                         "Wallpaper-New-York-Sky--T_bigapple2_0", "Wallpaper-New-York-Sky--T_bigapple2_0", "Wallpaper-New-York-Sky--T_bigapple2_0",
                         "466_634b8d691c6d3", "Wallpaper-New-York-Sky--T_bigapple2_0", "Wallpaper-New-York-Sky--T_bigapple2_0",
                         "images-4", "Wallpaper-New-York-Sky--T_bigapple2_0", "Wallpaper-New-York-Sky--T_bigapple2_0",
                         "Wallpaper-New-York-Sky--T_bigapple2_0", "maxresdefault" ]
    
    private var presenter: GalleryAllPhotosPresenter?
    
    
    override func viewDidLoad() {
        
        setupView()
        presenter = GalleryAllPhotosPresenterImpl(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        navigationController?.setNavigationBarHidden(false, animated: true)
        setupNavigationbar()
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        let collectionView = UICollectionView(frame: view.bounds,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AllPhotosCell.self,
                                forCellWithReuseIdentifier: AllPhotosCell.identifier)
        return collectionView
    }()
    
    private func setupView() {
        view.backgroundColor = .white
        let layer = CustomGradientLayerBackgroundAllPhotos(view: view)
        
        view.layer.addSublayer(layer)
        view.addSubview(collectionView)
    }
    
    private func setupNavigationbar() {
        let button = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(openAccountInfo))
        button.tintColor = .warmPink
        navigationController?.navigationBar.topItem?.rightBarButtonItem = button
        self.navigationItem.hidesBackButton = true
    }

    @objc
    private func openAccountInfo() {
        print("openAccountInfo")
    }
}

extension GalleryAllPhotosViewControllerImpl: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        navigationController?.pushViewController(GalleryFullScreenViewControllerImpl(mockDataArray: mockDataArray,
                                                                                     index: CGFloat(indexPath.row)),
                                                 animated: true)
    }
}

extension GalleryAllPhotosViewControllerImpl: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllPhotosCell.identifier,
                                                      for: indexPath as IndexPath) as! AllPhotosCell
        cell.setupPhoto(mockDataArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {

        return mockDataArray.count
    }
}

extension GalleryAllPhotosViewControllerImpl: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = view.frame.width / 4 - 2 
        return CGSize(width: size,
                      height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 1,
                            left: 1,
                            bottom: 1,
                            right: 1)
    }
}

extension GalleryAllPhotosViewControllerImpl: GalleryAllPhotosViewController {
    
}
