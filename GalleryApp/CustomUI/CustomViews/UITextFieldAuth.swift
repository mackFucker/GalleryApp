//
//  UITextFieldAuth.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 25.11.2023.
//

import UIKit

final class UITextFieldAuth: UITextField {
    
    init(placeholder: String,
         returnKeyType: UIReturnKeyType,
         delegate: UITextFieldDelegate,
         keyboardType: UIKeyboardType ) {
        super.init(frame: .zero)
        
        self.placeholder = placeholder
        self.returnKeyType = returnKeyType
        self.delegate = delegate
        self.keyboardType = keyboardType
        
        self.textAlignment = .center
        self.layer.cornerRadius = 12
        self.tintColor = .warmPink
        self.textColor = .gray
        self.backgroundColor = .lightYellow
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

