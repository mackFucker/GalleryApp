//
//  GalleryAllPhotosViewController.swift
//  ScrollViewTest
//
//  Created by дэвид Кихтенко on 15.11.2023.
//

import UIKit
import PhotosUI

protocol GalleryAllPhotosViewController: AnyObject {
    
}

final class GalleryAllPhotosViewControllerImpl: UIViewController {
    private var dataArr = [UIImage]()
    var presenter: GalleryAllPhotosPresenter!
    
    override func viewDidLoad() {
        
        Task {
            dataArr = await presenter.downloadFromTheStorage()
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
       
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
        let buttonProfile = UIButton(type: .system)
        buttonProfile.setImage(UIImage(systemName: "person.crop.circle"), for: .normal)
        buttonProfile.addTarget(self, action: #selector(openAccountInfo), for: .touchUpInside)
        
        let buttonAdd = UIButton(type: .system)
        buttonAdd.setImage(UIImage(systemName: "plus"), for: .normal)
        buttonAdd.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        
        let buttonProfileBar = UIBarButtonItem(customView: buttonProfile)
        let buttonAddBar = UIBarButtonItem(customView: buttonAdd)
        
        navigationController?.navigationBar.topItem?.rightBarButtonItems = [buttonProfileBar, buttonAddBar]
        self.navigationItem.hidesBackButton = true
    }
    
    @objc
    private func openAccountInfo() {
        print("openAccountInfo")
        print(self.dataArr)
    }
    
    @objc
    private func openImagePicker(_ sender: UIButton) {
        var config = PHPickerConfiguration()
        config.selectionLimit = 50
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        self.present(picker, animated: true)
    }
}

extension GalleryAllPhotosViewControllerImpl: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        navigationController?.pushViewController(GalleryFullScreenViewControllerImpl(mockDataArray: dataArr,
                                                                                     index: CGFloat(indexPath.row)),
                                                 animated: true)
    }
}

extension GalleryAllPhotosViewControllerImpl: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllPhotosCell.identifier,
                                                      for: indexPath as IndexPath) as! AllPhotosCell
        cell.setupPhoto(dataArr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return dataArr.count
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

extension GalleryAllPhotosViewControllerImpl: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController,
                didFinishPicking results: [PHPickerResult]) {

        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { object,
                error in
                if let image = object as? UIImage {
                    self.dataArr.append(image)
                    
                    Task {
                        await self.presenter.uploadToTheStorage(image)
                    }
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
       
        dismiss(animated: true)
    }
}

extension GalleryAllPhotosViewControllerImpl: GalleryAllPhotosViewController {
    
}
