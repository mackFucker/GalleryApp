//
//  FullScreenPhotoCell.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 17.11.2023.
//

import UIKit

final class FullScreenPhotoCell: UICollectionViewCell {
    private var zoomIsActive = false
    static let identifier = "FullScreenPhotoCellIdentifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        settingZoom()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var zoomScroll: UIScrollView = {
        let zoomScroll = UIScrollView(frame: contentView.frame)
//        zoomScroll.contentInset = UIEdgeInsets(top: -60, left: 0, bottom: -60, right: 0)
        zoomScroll.showsVerticalScrollIndicator = false
        zoomScroll.showsHorizontalScrollIndicator = false
        zoomScroll.delegate = self
        return zoomScroll
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .infinite)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.sizeToFit()
        return imageView
    }()
    
    func setupPhoto(_ photo: String) {
        imageView.image = (UIImage(named: photo) ?? UIImage(systemName: "photo"))!
    }
    
    private func setup() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(zoomScroll)
        zoomScroll.addSubview(imageView)
        
        imageView.frame = zoomScroll.bounds
        zoomScroll.contentSize = zoomScroll.bounds.size        
    }
    
    private func centerScrollViewContents() {
        let boundsSize = zoomScroll.bounds.size
        var contentsFrame = imageView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        imageView.frame = contentsFrame
    }
}

extension FullScreenPhotoCell {
    @objc private func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        let pointInView = recognizer.location(in: imageView)
        let scrollViewSize = zoomScroll.bounds.size
        var newZoomScale = zoomScroll.zoomScale * 2.5
        
        if zoomIsActive {
            zoomScroll.setZoomScale(-1, animated: true)
            zoomIsActive = false
        }
        else {
            newZoomScale = min(newZoomScale, zoomScroll.maximumZoomScale)
            
            let w = scrollViewSize.width / newZoomScale
            let h = scrollViewSize.height / newZoomScale
            let x = pointInView.x - (w / 2.0)
            let y = pointInView.y - (h / 2.0)
            
            let rectToZoomTo = CGRect(x: x, y: y, width: w, height: h)
            
            zoomScroll.zoom(to: rectToZoomTo, animated: true)
            zoomIsActive = true
        }
    }
    
    private func settingZoom() {
        let doubleTapRecognizer = UITapGestureRecognizer(target: self,
                                                         action: #selector(scrollViewDoubleTapped))
        doubleTapRecognizer.numberOfTapsRequired = 2
        zoomScroll.addGestureRecognizer(doubleTapRecognizer)
        
        let scrollViewFrame = zoomScroll.frame
        let scaleWidth = scrollViewFrame.size.width / zoomScroll.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / zoomScroll.contentSize.height
        
        let minScale = min(scaleWidth, scaleHeight)
        
        zoomScroll.minimumZoomScale = minScale
        zoomScroll.maximumZoomScale = 5
        
        zoomScroll.zoomScale = minScale
        
        centerScrollViewContents()
    }
}

extension FullScreenPhotoCell: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if zoomScroll.zoomScale >= 4 {
            zoomIsActive = true
        }
        
        if scrollView.zoomScale > 1 {
            if let image = imageView.image {
                let ratioW = imageView.frame.width / image.size.width
                let ratioH = imageView.frame.height / image.size.height
                
                let ratio = ratioW < ratioH ? ratioW : ratioH
                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                let conditionLeft = newWidth*scrollView.zoomScale > imageView.frame.width
                let left = 0.5 * (conditionLeft ? newWidth - imageView.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                let conditioTop = newHeight*scrollView.zoomScale > imageView.frame.height
                
                let top = 0.5 * (conditioTop ? newHeight - imageView.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
                
            }
        } else {
            scrollView.contentInset = .zero
//            scrollView.contentInset = UIEdgeInsets(top: -88, left: 0, bottom: -44, right: 0)
        }
    }
}


