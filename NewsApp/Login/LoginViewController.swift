//
//  LoginViewController.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 9.09.2023.
//

import UIKit
import FirebaseAuth
import JGProgressHUD

class LoginViewController: UIViewController {
    private let spinner = JGProgressHUD(style: .dark)
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    private var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewController = self
        
    }
    
    @IBAction func signInButtonAct(_ sender: Any) {
        spinner.show(in: view)
        validationLogin()
        DispatchQueue.main.async {
            self.spinner.dismiss()
        }
    }
    
    @IBAction func signUpButtonAct(_ sender: Any) {
        performSegue(withIdentifier:"register", sender: nil)
    }
    
    func validationLogin() {
        let email = emailTextField.text
        let password = passwordTextField.text
        
        viewModel.signIn(withEmail: email, password: password) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    let vc = self?.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController")
                    vc?.modalPresentationStyle = .fullScreen
                    self?.present(vc!, animated: true)
                }
            case .failure(let error):
                Utilities.showCustomAlert(from: self!, title: "Error", message: error.localizedDescription)
            }
        }
    }
}
