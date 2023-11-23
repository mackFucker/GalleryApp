//
//  CustomGradientLayer.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 22.11.2023.
//

import UIKit

final class CustomGradientLayerBackgroundAllPhotos: CALayer, CustomGradientLayerBackground {
    var itemSize: CGFloat!
    var view: UIView
    
    var firstGradient: CustomGradientLayerSpot!
    var secondGradient: CustomGradientLayerSpot!
    var thirdGradient: CustomGradientLayerSpot!
    
    init(view: UIView) {
        self.itemSize = view.frame.width
        self.view = view
        
        super.init()

        firstGradient = CustomGradientLayerSpot(locations: [0.1, 0.5, 1])
        secondGradient = CustomGradientLayerSpot(locations: [0.1, 0.5, 1])
        thirdGradient = CustomGradientLayerSpot(locations: [0.1, 0.5, 1])
        
        self.setupLayerBackground(view: view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayerBackground(view: UIView) {
      
        firstGradient.frame = CGRect(x: itemSize / -2.5,
                                     y: -350,
                                     width: itemSize,
                                     height: itemSize)
        
        secondGradient.frame = CGRect(x: view.frame.width + 100,
                                      y: view.frame.height / 2 - itemSize / 2 ,
                                      width: itemSize,
                                      height: itemSize)
        
        thirdGradient.frame = CGRect(x: itemSize / -2.5,
                                     y: view.frame.height + 350,
                                     width: itemSize,
                                     height: itemSize)
        firstGradient.accessibilityTraits = .updatesFrequently
        self.addSublayer(firstGradient)
        self.addSublayer(secondGradient)
        self.addSublayer(thirdGradient)
        
        firstGradient.frame = CGRect(x: itemSize / -2.5,
                                     y: view.frame.height * -0.15,
                                     width: itemSize,
                                     height: itemSize)
        
        secondGradient.frame = CGRect(x: view.frame.width - (itemSize / 1.5),
                                      y: view.frame.height / 2 - itemSize / 2 ,
                                      width: itemSize,
                                      height: itemSize)
        
        thirdGradient.frame = CGRect(x: itemSize / -2.5,
                                     y: view.frame.height * 0.75,
                                     width: itemSize,
                                     height: itemSize)
    }
    
    func animate() {
//        let animation = UIViewPropertyAnimator(duration: 2, curve: .easeInOut) {
//            self.firstGradient.frame = CGRect(x: self.itemSize / -2.5,
//                                              y: self.view.frame.height * -0.15,
//                                              width: self.itemSize,
//                                              height: self.itemSize)
//            
//            self.secondGradient.frame = CGRect(x: self.view.frame.width - (self.itemSize / 1.5),
//                                               y: self.view.frame.height / 2 - self.itemSize / 2 ,
//                                               width: self.itemSize,
//                                               height: self.itemSize)
//            
//            self.thirdGradient.frame = CGRect(x: self.itemSize / -2.5,
//                                              y: self.view.frame.height * 0.75,
//                                              width: self.itemSize,
//                                              height: self.itemSize)
//        }
//        
//        animation.startAnimation()
    }
}

