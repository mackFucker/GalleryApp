//
//  UIlogoLabel.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 25.11.2023.
//

import UIKit

final class UILogoLabel: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let gradient = setupGradient()
        self.frame = frame
        gradient.frame = frame
        logoLabelMask.frame = frame

        self.layer.addSublayer(gradient)
        self.mask = logoLabelMask
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGradient() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.warmPink.cgColor, UIColor.softOrange.cgColor]
        gradient.startPoint = CGPoint(x: 0.3, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.6, y: 0.5)
        return gradient
    }
    
    private lazy var logoLabelMask: UILabel = {
        let logoLabel = UILabel()
        logoLabel.font = UIFont(name: "Token", size: 60)
        logoLabel.text = "GuardDisk"
        logoLabel.textAlignment = .center
        return logoLabel
    }()
}
