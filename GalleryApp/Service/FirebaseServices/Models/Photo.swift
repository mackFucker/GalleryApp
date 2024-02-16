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
    var imageURlString = ""
    var description = ""
    var reviewer: String
    var postedOn = Date()
    
    init(reviewer: String){
        self.reviewer = reviewer
    }
    
    init(id: String?,
         imageURlString: String,
         description: String,
         reviewer: String,
         postedOn: Date) {
        
        self.id = id
        self.imageURlString = imageURlString
        self.description = description
        self.reviewer = reviewer
        self.postedOn = postedOn
    }
    
    var dictionary: [String: Any] {
        return ["imageURlSTring": imageURlString,
                "description": description,
                "reviewer": reviewer,
                "postedOn": Timestamp(date: Date())]
    }
}
