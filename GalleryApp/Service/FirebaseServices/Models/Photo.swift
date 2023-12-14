//
//  Photo.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 14.12.2023.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Photo: Identifiable, Codable {
    @DocumentID var id: String?
    var imageURlSTring = ""
    var description = ""
    var reviewer = Auth.auth().currentUser?.email ?? ""
    var postrdOn = Date()
    
    var dictionary: [String: Any] {
        return ["imageURlSTring": imageURlSTring,
                "description": description,
                "reviewer": reviewer,
                "postrdOn": Timestamp(date: Date())]
    }
}
