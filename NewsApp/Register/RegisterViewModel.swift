//
//  RegisterViewModel.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 9.09.2023.
//

import Foundation
import Firebase
import FirebaseFirestore

protocol RegisterViewModelProtocol {
    func registerUser(user: UserModel, completion: @escaping (Result<Void, Error>) -> Void)
}

class RegisterViewModel: RegisterViewModelProtocol {
    func registerUser(user: UserModel, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] (authResult, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                self?.saveUserToFirestore(user: user, completion: completion)
            }
        }
    }
    
    private func saveUserToFirestore(user: UserModel, completion: @escaping (Result<Void, Error>) -> Void) {
        let db = Firestore.firestore()
        let currentUserId = Auth.auth().currentUser?.uid
        let userDocument = db.collection("users").document(currentUserId!)
        
        let userData: [String: Any] = [
            "username": user.username,
            "email": user.email,
            "password": user.password,
            "phoneNumber": user.phoneNumber,
            "country": user.country,
            "userId": currentUserId!
        ]
        
        userDocument.setData(userData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}

