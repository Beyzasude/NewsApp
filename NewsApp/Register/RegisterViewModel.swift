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
    
    var view : RegisterControllerProtocol? { get set }
    func saveUserToFirestore(username: String, email: String, password: String, phoneNumber: String, country: String)
    
}

class RegisterViewModel: RegisterViewModelProtocol {
    
    weak var view: RegisterControllerProtocol?
    
    func saveUserToFirestore(username: String, email: String, password: String, phoneNumber: String, country: String) {
        let db = Firestore.firestore()
        let userDocument = db.collection("users").document()
        let currentUsers = Auth.auth().currentUser?.uid
        let userData: [String: Any] = [
            "username": username,
            "email": email,
            "password": password,
            "phoneNumber" : phoneNumber,
            "country" : country,
            "userId" : currentUsers!
        ]
        
        userDocument.setData(userData) { error in
            if let error = error {
                print("Hata: \(error.localizedDescription)")
            } else {
                self.view?.succesfulRegisterAlert()
                print("Kullanıcı bilgileri Firestore veritabanına kaydedildi.")
            }
        }
    }
}
