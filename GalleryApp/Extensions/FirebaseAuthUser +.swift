//
//  FirebaseAuthUser +.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 14.01.2024.
//

import Foundation
import FirebaseAuth

typealias User = FirebaseAuth.User

extension User {
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.uid
        repres["email"] = self.email
        
        return repres
    }
}
