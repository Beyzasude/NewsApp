//
//  LoginViewController.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 9.09.2023.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private var viewModel = LoginViewModel()
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func signInButtonAct(_ sender: Any) {
        validationLogin()
    }
    
    @IBAction func signUpButtonAct(_ sender: Any) {
        performSegue(withIdentifier:"register", sender: nil)
    }
    
    func validationLogin(){
         if let email = emailTextField.text {
             if email.isEmpty {
                 Utilities.showAlert(from: self,withMessage: "Please enter your email")
             }
         }
         if let password = passwordTextField.text {
             if password.isEmpty {
                 Utilities.showAlert(from: self,withMessage: "Please enter password")
             }
         }
        // showActivityIndicator()
        FirebaseAuth.Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult, error) in
             if error != nil {
                 //self.hideActivityIndicator()
                 Utilities.showCustomAlert(from: self, title:"Error", message: error?.localizedDescription ?? "Error")
             } else{
                // self.hideActivityIndicator()
                 print("kullanıcı oluşturulduuu")
                 //self.performSegue(withIdentifier:"home", sender: nil)
                 let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController")
                 vc!.modalPresentationStyle = .fullScreen
                 self.present(vc!, animated: true)
             }
             
         }
     
     }
    
}
