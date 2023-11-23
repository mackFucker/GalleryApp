//
//  CustomGradientLayer.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 22.11.2023.
//

import UIKit

final class CustomGradientLayerSpot: CAGradientLayer {
    init(locations: [NSNumber]) {
        super.init()
        
        self.type = .axial
        self.cornerRadius = 10
        
        self.colors = [
            UIColor.warmPink.cgColor,
            UIColor.warmPink.cgColor,
            UIColor.white.cgColor
        ]
        self.locations = locations
        self.startPoint = CGPoint(x: 0.5, y: 0.5)
        self.endPoint = CGPoint(x: 1, y: 1)
        
        self.type = .radial
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
