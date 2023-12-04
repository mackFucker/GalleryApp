//
//  DatabaseService.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 04.12.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class DatabaseService {
    static let shared = DatabaseService()
    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    private init() { }
    
    func setupUser(_ user: User,
                   complition: @escaping (Result<User, Error>) -> ()) {
        print(user)
        usersRef.document(user.id).setData(user.representation) { error in
            if let error = error {
                print(error)
                complition(.failure(error))
            }
            else {
                complition(.success(user))
            }
        }
    }
}
