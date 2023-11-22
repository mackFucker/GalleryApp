//
//  CustomGradientLayer.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 22.11.2023.
//

import UIKit

enum TypeOfGradientLayerBackground {
    case GalleryAllPhotosViewControllerImplBackground
    case GalleryFullScreenViewControllerImplBackground
}

final class CustomGradientLayerBackground: CALayer {
    
    var firstGradient: CustomGradientLayerSpot!
    var secondGradient: CustomGradientLayerSpot!
    var thirdGradient:  CustomGradientLayerSpot!
   
    
    init(view: UIView,
         type: TypeOfGradientLayerBackground) {
        super.init()
        switch type {
        case .GalleryAllPhotosViewControllerImplBackground:
            self.setupLayerBackgroundAllPhotos(view: view)
        case .GalleryFullScreenViewControllerImplBackground:
            self.setupLayerBackgroundAllPhotos(view: view)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayerBackgroundAllPhotos(view: UIView) {
        let itemSize = view.frame.width
        firstGradient = CustomGradientLayerSpot(locations: [0.1, 0.5, 1])
        secondGradient = CustomGradientLayerSpot(locations: [0.1, 0.5, 1])
        thirdGradient = CustomGradientLayerSpot(locations: [0.1, 0.5, 1])
//
//        firstGradient.frame = CGRect(x: itemSize / -2.5,
//                                     y: -350,
//                                     width: itemSize,
//                                     height: itemSize)
//        
//        secondGradient.frame = CGRect(x: view.frame.width + 100,
//                                      y: view.frame.height / 2 - itemSize / 2 ,
//                                      width: itemSize,
//                                      height: itemSize)
//        
//        thirdGradient.frame = CGRect(x: itemSize / -2.5,
//                                     y: view.frame.height + 350,
//                                     width: itemSize,
//                                     height: itemSize)
        
        setupBlurredLayer(layer: firstGradient)
        setupBlurredLayer(layer: secondGradient)
        setupBlurredLayer(layer: thirdGradient)
        
        self.addSublayer(firstGradient)
        self.addSublayer(secondGradient)
        self.addSublayer(thirdGradient)
        
        self.firstGradient.frame = CGRect(x: itemSize / -2.5,
                                     y: view.frame.height * -0.15,
                                     width: itemSize,
                                     height: itemSize)
        
        self.secondGradient.frame = CGRect(x: view.frame.width - (itemSize / 1.5),
                                      y: view.frame.height / 2 - itemSize / 2 ,
                                      width: itemSize,
                                      height: itemSize)
        
        self.thirdGradient.frame = CGRect(x: itemSize / -2.5,
                                     y: view.frame.height * 0.75,
                                     width: itemSize,
                                     height: itemSize)
    }
    
    private func setupLayerBackgroundFullScreen(view: UIView) {
        
    }
    
    private func setupBlurredLayer(layer: CAGradientLayer) {
        layer.shadowColor = UIColor.lightYellow.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 150
    }
}

