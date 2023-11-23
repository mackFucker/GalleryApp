//
//  CustomGradientLayerBackground.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 22.11.2023.
//

import UIKit

protocol CustomGradientLayerBackground: CALayer {
    var itemSize: CGFloat! { get }
    var view: UIView { get }
    
    init(view: UIView)
    
    func setupLayerBackground(view: UIView)
    func animate()
}
