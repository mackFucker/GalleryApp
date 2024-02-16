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
    
    func signUp(_ data: RegistrationField) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: data.email,
                                                          password: data.password)
            let user = result.user
            dbService.setupUser(user) { resultDB in
                switch resultDB {
                case .success(let user):
                    print(user)
                case .failure(_):
                    print("failture create user in DB")
                }
            }
        } catch {
            throw error
        }
    }
    
    func signIn(_ data: RegistrationField) async throws -> User {
        do {
            let result = try await Auth.auth().signIn(withEmail: data.email,
                                                      password: data.password)
            if result.user.isEmailVerified {
                return result.user
            } else {
                self.confirmEmail()
                throw AuthErrorCode(.unverifiedEmail)
            }
        } catch {
            throw error
        }
    }
    
    func signOut(complition: @escaping (AuthResponce) -> ()) {
        do {
            try Auth.auth().signOut()
            //            complition(.success)
        } catch {
            print("Sign out error")
            //            complition(.error(AuthErrorCode.Code(rawValue: 17094)!))
        }
    }
    
    private func confirmEmail() {
        Auth.auth().currentUser?.sendEmailVerification() { error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}
