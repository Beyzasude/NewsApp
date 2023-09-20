//
//  LoginViewModel.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 9.09.2023.
//

import Foundation
import FirebaseAuth
import UIKit

class LoginViewModel {
    weak var viewController: UIViewController?
    
    func signIn(withEmail email: String?, password: String?, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let email = email, !email.isEmpty, let password = password, !password.isEmpty else {
            let errorMessage = "Email and password are required"
            Utilities.showAlert(from: viewController! ,withMessage: errorMessage)
            return
        }
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password){ (authResult, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}

