//
//  ViewController.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 9.09.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func signInButtonAct(_ sender: Any) {
        performSegue(withIdentifier:"signIn", sender: nil)
    }
    
    
    
    @IBAction func signUpButtonAct(_ sender: Any) {
        performSegue(withIdentifier:"signUp", sender: nil)
    }
    
}

