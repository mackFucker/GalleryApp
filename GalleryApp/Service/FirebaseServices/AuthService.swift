//
//  AuthService.swift
//  GalleryApp
//
//  Created by дэвид Кихтенко on 30.11.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthService {
    
    static let shared = AuthService()
    init() {}
    
    func signup(_ data: RegistrationField,
                complition: @escaping (AuthResponce) -> ()) {
        
        Auth.auth().createUser(withEmail: data.email,
                               password: data.password){ result, error in
            if let error = error as? NSError {
                complition(.error(AuthErrorCode.Code(rawValue: error.code)!))
            }
            else {
                if result != nil {
                    let userId = result?.user.uid
                    let email = data.email
                    let data: [String: Any] = ["email": email]
                    Firestore.firestore().collection("users").document(userId!).setData(data)
                    
                    complition(.success)
                }
            }
        }
    }
    
//    func signIn(_ data: RegistrationField, complition: @escaping (AuthResponce) -> ()) {
//        Auth.auth().signIn(withEmail: data.email , password: data.password) {
//            result, error in
//            if error != nil {
//                complition(.error)
//                print(error!.localizedDescription)
//            }
//            if let result = result {
//                if result.user.isEmailVerified {
//                    complition(.success)
//                } else {
//                    self.confimEmail()
//                    complition(.noVerify)
//                }
//            }
//        }
//    }
    
//    func signOut(complition: @escaping (AuthResponce) -> ()) {
//        do {
//            try Auth.auth().signOut()
//            complition(.success)
//        } catch {
//            print("Sign out error")
//            complition(.error)
//        }
//    }
    
    private func confimEmail() {
        Auth.auth().currentUser?.sendEmailVerification(){ error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}

enum AuthResponce {
    case success
    case error(AuthErrorCode.Code)}
//
//enum Error {
//    case AuthErrorCode
//    case emailAlreadyInUse
//    case invalidEmail
//    case weakPassword
//    case other
//}

struct RegistrationField {
    var email: String
    var password: String
}

struct ResponceCode {
    var code: Int
}
