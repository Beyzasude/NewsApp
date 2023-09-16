//
//  RegisterViewController.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 9.09.2023.
//

import UIKit
import Firebase
import FirebaseAuth

protocol RegisterControllerProtocol : AnyObject {
    func succesfulRegisterAlert()
}


class RegisterViewController: UIViewController, RegisterControllerProtocol{
    
    var viewModel = RegisterViewModel()

    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        viewModel.view = self

    }
    
    
    @IBAction func signUpButtonAct(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty,
                  let password = passwordTextField.text, !password.isEmpty,
                  let fullName = fullNameTextField.text, !fullName.isEmpty,
                  let phone = phoneTextField.text, !phone.isEmpty,
                  let country = countryTextField.text, !country.isEmpty
            else {
                Utilities.showAlert(from: self, withMessage: "Please fill in all fields.")
                return
            }

            // Email kontrolü
            if !Utilities.isValidEmail(email) {
                Utilities.showAlert(from: self, withMessage: "Enter a valid email address.")
                return
            }

            // Telefon kontrolü
            if phone.count < 10 {
                Utilities.showAlert(from: self, withMessage: "Phone field must be at least 10 characters.")
                return
            }

            // Şifre kontrolü
            if !Utilities.isPasswordValid(password) {
                Utilities.showAlert(from: self, withMessage: "Please make sure your password is at least 8 characters, contains a special character and a number.")
                return
            }

            // Tüm alanlar geçerli, kaydetme işlemi yapılabilir
            Auth.auth().createUser(withEmail: email, password: password) { [self] (authResult, error) in
                if let error = error {
                    Utilities.showCustomAlert(from: self, title: "Error", message: error.localizedDescription)
                } else {
                    viewModel.saveUserToFirestore(username: fullName, email: email, password: password, phoneNumber: phone, country: country)
                }
            }
        }
    
    func validateTextFields() {
        // Email control
        if let email = emailTextField.text {
            if email.count < 8 || !email.contains("@") || !email.contains(".com") {
                Utilities.showAlert(from: self, withMessage: "Enter a valid email address!")
                
            }
        } else {
            Utilities.showAlert(from: self, withMessage:"Email field cannot be empty!")
            return
        }
        
        // Name kontrolü
        if fullNameTextField.text?.isEmpty ?? true {
            Utilities.showAlert(from: self, withMessage:"Please enter name")
            return
        }
        
        // Telefon kontrolü
        if let phone = phoneTextField.text {
            if phone.count < 10 {
                Utilities.showAlert(from: self, withMessage:"Phone field must be at least 10 characters!")
                return
            }
        } else {
            Utilities.showAlert(from: self, withMessage:"Phone field cannot be empty!")
            return
        }
        
        // Şifre kontrolü
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            Utilities.showAlert(from: self, withMessage:"Please make sure your password is at least 8 characters, contains a special character and a number.")
            return
        }
    
    }
    
    func succesfulRegisterAlert(){
        let alert = UIAlertController(title: "Successful", message: "User information has been saved, you can log in.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { (_) in
            //self.performSegue(withIdentifier: "login", sender: nil)
            let homeViewController = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController
            
            self.view.window?.rootViewController = homeViewController
            self.view.window?.makeKeyAndVisible()
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}
