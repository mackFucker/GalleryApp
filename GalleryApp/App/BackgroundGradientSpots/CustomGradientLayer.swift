//
//  CustomGradientLayer.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 22.11.2023.
//

import UIKit

final class CustomGradientLayer: CALayer {
    init(view: UIView) {
        super.init()
        let itemSize = view.frame.width / 1.1
        let transform = CATransform3DMakeRotation(.pi / 4, 0, 0, 1)
        
        let firstGradient = CustomGradientLayerSpot(loacations: [0, 0.25, 1])
        firstGradient.frame = CGRect(x: itemSize / -2.5,
                                     y: view.frame.height * -0.15,
                                     width: itemSize,
                                     height: itemSize)
        firstGradient.transform = transform

        let secondGradient = CustomGradientLayerSpot(loacations: [0, 0.25, 1])
        secondGradient.frame = CGRect(x: view.frame.width - (itemSize / 1.5),
                                      y: view.frame.height / 2 - itemSize / 2 ,
                                      width: itemSize,
                                      height: itemSize)
        secondGradient.transform = transform
        
        let thirdGradient = CustomGradientLayerSpot(loacations: [0, 0.25, 1])
        thirdGradient.frame = CGRect(x: itemSize / -2.5,
                                     y: view.frame.height * 0.75,
                                     width: itemSize,
                                     height: itemSize)
        thirdGradient.transform = transform
    
        self.addSublayer(firstGradient)
        self.addSublayer(secondGradient)
        self.addSublayer(thirdGradient)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
