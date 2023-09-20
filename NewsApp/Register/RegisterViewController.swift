//
//  RegisterViewController.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 9.09.2023.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController{
    
    var viewModel = RegisterViewModel()
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInButtonAct(_ sender: Any) {
        performSegue(withIdentifier:"login", sender: nil)
    }
    
    
    @IBAction func signUpButtonAct(_ sender: Any) {
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let fullName = fullNameTextField.text,
              let phone = phoneTextField.text,
              let country = countryTextField.text
        else {
            Utilities.showAlert(from: self, withMessage: "Please fill in all fields.")
            return
        }
        
        let newUser = UserModel(username: fullName, email: email, password: password, phoneNumber: phone, country: country)
        
        viewModel.registerUser(user: newUser) { [weak self] result in
            switch result {
            case .success:
                self?.showRegistrationSuccessAlert()
            case .failure(let error):
                Utilities.showCustomAlert(from: self!, title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    
    private func showRegistrationSuccessAlert() {
        let alert = UIAlertController(title: "Successful", message: "User information has been saved, you can log in.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { [weak self] (_) in
            let loginViewController = self?.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController
            self?.view.window?.rootViewController = loginViewController
            self?.view.window?.makeKeyAndVisible()
        }
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}
