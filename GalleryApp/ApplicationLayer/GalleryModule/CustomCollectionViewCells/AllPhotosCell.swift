//
//  AllphotosCell.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 17.11.2023.
//

import UIKit

final class AllPhotosCell: UICollectionViewCell {
    
    static let identifier = "AllPhotosCellIdentifier"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: contentView.frame)
        imageView.backgroundColor = .blue
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupPhoto(_ photo: UIImage) {
        imageView.image = photo
    }
}
