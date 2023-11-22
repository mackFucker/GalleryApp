//
//  CustomGradientLayerBackground.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 22.11.2023.
//

import UIKit

class CustomGradientLayerBackground: CALayer {
    
    var itemSize: CGFloat
    var view: UIView
    
    init(view: UIView) {
        
        self.view = view
        self.itemSize = view.frame.width
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBlurredLayer(layer: CAGradientLayer) {
        layer.shadowColor = UIColor.lightYellow.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 150
    }
}
