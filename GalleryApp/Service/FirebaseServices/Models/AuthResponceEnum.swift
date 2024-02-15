//
//  AuthResponceEnum.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 04.12.2023.
//

import Foundation
import FirebaseAuth

enum AuthResponce {
    case success(FirebaseAuth.User)
    
    case error(AuthErrorCode.Code)
    case noVerify
    case suchAUserAlreadyExists
    case connectionError
}
