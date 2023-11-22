//
//  CustomGradientLayer.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 22.11.2023.
//

import UIKit
import CoreImage

final class CustomGradientLayerBackground: CALayer {
    init(view: UIView) {
        super.init()
        let itemSize = view.frame.width
        let transform = CATransform3DMakeRotation(.pi / 4, 0, 0, 1)
        
        let firstGradient = CustomGradientLayerSpot(locations: [0.1, 0.5, 1])
        firstGradient.frame = CGRect(x: itemSize / -2.5,
                                     y: view.frame.height * -0.15,
                                     width: itemSize,
                                     height: itemSize)
        firstGradient.transform = transform

        let secondGradient = CustomGradientLayerSpot(locations: [0.1, 0.5, 1])
        secondGradient.frame = CGRect(x: view.frame.width - (itemSize / 1.5),
                                      y: view.frame.height / 2 - itemSize / 2 ,
                                      width: itemSize,
                                      height: itemSize)
        secondGradient.transform = transform
        
        let thirdGradient = CustomGradientLayerSpot(locations: [0.1, 0.5, 1])
        thirdGradient.frame = CGRect(x: itemSize / -2.5,
                                     y: view.frame.height * 0.75,
                                     width: itemSize,
                                     height: itemSize)
        thirdGradient.transform = transform
        
        setupBlurredLayer(layer: firstGradient)
        setupBlurredLayer(layer: secondGradient)
        setupBlurredLayer(layer: thirdGradient)

        self.addSublayer(firstGradient)
        self.addSublayer(secondGradient)
        self.addSublayer(thirdGradient)

    }
    
    private func setupBlurredLayer(layer: CAGradientLayer) {
        layer.shadowColor = UIColor.lightYellow.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 150
    }
    
//    private func setupBlurredLayer(layer: CALayer) {
//        let blurLayer = CALayer()
//        blurLayer.cornerRadius = 10
//        blurLayer.frame = CGRect(x: layer.bounds.width / 4,
//                                 y: layer.bounds.height / 4,
//                                 width: layer.bounds.width / 2,
//                                 height: layer.bounds.height / 2)
//        
////        blurLayer.backgroundColor = UIColor.systemBackground.cgColor
//        blurLayer.shadowColor = UIColor.red.cgColor
//
//        blurLayer.shadowOpacity = 1
//        blurLayer.shadowOffset = CGSize(width: 0, height: 0)
//        blurLayer.shadowRadius = 200
//        
//        layer.addSublayer(blurLayer)
//        
//        print(layer.frame)
//        print(blurLayer.frame)
        
        
//        if let filter = CIFilter(name:"CIGaussianBlur") {
//            filter.name = "myFilter"
//            layer.backgroundFilters = [filter]
//            layer.masksToBounds = true
//            layer.setValue(1,
//                           forKeyPath: "backgroundFilters.myFilter.inputRadius")
//        }
        
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
