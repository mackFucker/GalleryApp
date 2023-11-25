//
//  UIButtonAuth.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 25.11.2023.
//

import UIKit

final class UIButtonAuth: UIButton {
    init(title: String, action: Selector, target: Any) {
        super.init(frame: .zero)
        
        self.layer.cornerRadius = 10
        self.setTitleColor(.warmPink, for: .normal)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        self.addTarget(target, action: action, for: .touchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
