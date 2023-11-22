//
//  CustomGradientLayer.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 22.11.2023.
//

import UIKit

final class CustomGradientLayerSpot: CAGradientLayer {
    init(loacations: [NSNumber]) {
        super.init()
        
        self.type = .axial
        self.cornerRadius = 10
        
        self.colors = [
            UIColor.warmPink.cgColor,
            UIColor.softOrange.cgColor,
            UIColor.lightYellow.cgColor
        ]
        self.locations = loacations
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
