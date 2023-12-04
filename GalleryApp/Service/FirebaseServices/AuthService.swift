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
    private let dbService = DatabaseService.shared
    
    private init() {}
    
    func signup(_ data: RegistrationField,
                complition: @escaping (AuthResponce) -> ()) {
        
        Auth.auth().createUser(withEmail: data.email,
                               password: data.password) { [self] result, error in
            if let error = error as? NSError {
                complition(.error(AuthErrorCode.Code(rawValue: error.code)!))
            }
            else {
                if result != nil {
                    let user = User(id: result!.user.uid,
                                    name: data.name!,
                                    email: data.email)
                    
                    dbService.setupUser(user) { resultDB in
                        switch resultDB {
                            case .success(let user):
                                complition(.success(result!.user))
                                print(user)
                            case .failure(_):
                                complition(.noVerify)
                            }
                    }
                }
            }
        }
    }
    
    func signin(_ data: RegistrationField,
                complition: @escaping (AuthResponce) -> ()) {
        
        Auth.auth().signIn(withEmail: data.email , password: data.password) {
            result, error in
            
            if let error = error as? NSError {
                complition(.error(AuthErrorCode.Code(rawValue: error.code)!))
            }
            else {
                if let result = result {
                    if result.user.isEmailVerified {
                        complition(.success(result.user))
                    } else {
                        self.confimEmail()
                        complition(.noVerify)
                    }
                }
            }
        }
    }
    
    func signOut(complition: @escaping (AuthResponce) -> ()) {
        do {
            try Auth.auth().signOut()
            //            complition(.success)
        } catch {
            print("Sign out error")
            complition(.error(AuthErrorCode.Code(rawValue: 17094)!))
        }
    }
    
    private func confimEmail() {
        Auth.auth().currentUser?.sendEmailVerification(){ error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}
