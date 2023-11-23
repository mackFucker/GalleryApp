//
//  CustomGradientLayerBackgroundAuth.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 23.11.2023.
//

import UIKit

final class CustomGradientLayerBackgroundAuth: CALayer, CustomGradientLayerBackground {
    var itemSize: CGFloat!
    var view: UIView
    
    var firstGradient: CustomGradientLayerSpot!
    var secondGradient: CustomGradientLayerSpot!
    
    init(view: UIView) {
        self.view = view
        self.itemSize = view.frame.width
        super.init()
        
        firstGradient = CustomGradientLayerSpot(locations: [0.1, 0.5, 1])
        secondGradient = CustomGradientLayerSpot(locations: [0.1, 0.5, 1])
        
        self.setupLayerBackground(view: view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayerBackground(view: UIView) {
        firstGradient.frame = CGRect(x: view.frame.width / 2 - (itemSize / 2),
                                     y: -(itemSize / 2),
                                     width: itemSize,
                                     height: itemSize)
        
        secondGradient.frame = CGRect(x: view.frame.width / 2 - (itemSize / 2),
                                      y: view.frame.height - itemSize / 2 ,
                                      width: itemSize,
                                      height: itemSize)
        
        self.addSublayer(firstGradient)
        self.addSublayer(secondGradient)
    }
    
    func animate() {
        
    }
}
