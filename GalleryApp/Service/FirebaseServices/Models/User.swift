//
//  User.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 04.12.2023.
//

import Foundation
extension User {
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = self.uid
        repres["email"] = self.email
        
        return repres
    }
}
//FIXME: убрать

//struct User: Identifiable {
//    var id: String
//    var name: String
//    var email: String
//
//    var representation: [String: Any] {
//
//        var repres = [String: Any]()
//        repres["id"] = self.id
//        repres["name"] = self.name
//        repres["email"] = self.email
//
//        return repres
//    }
//}
