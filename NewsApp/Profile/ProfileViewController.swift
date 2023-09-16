//
//  ProfileViewController.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 11.09.2023.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var screenModeSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 65
        updateUIStyle()

    }
    
    func updateUIStyle() {
            // UISwitch'un değerine göre UIUserInterfaceStyle'ı ayarla
            if screenModeSwitch.isOn {
                // Kullanıcı dark mode'u seçti
                overrideUserInterfaceStyle = .dark
            } else {
                // Kullanıcı light mode'u seçti
                overrideUserInterfaceStyle = .light
            }
        }
    
    
    @IBAction func screenModeButtonAct(_ sender: UISwitch) {
        updateUIStyle()
//        let appDelegate = UIApplication.shared.windows.first
//        if sender.isOn {
//            appDelegate?.overrideUserInterfaceStyle = .dark
//        }
//        appDelegate?.overrideUserInterfaceStyle = .light
    }
    
    @IBAction func logoutButtonAct(_ sender: Any) {
        let actionSheet =  UIAlertController(title: "Are you sure you want to log out?", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { [weak self] _ in
            guard let strongSelf = self else {
                return
            }
            do {
                try  FirebaseAuth.Auth.auth().signOut()
                strongSelf.navigationController?.dismiss(animated: true, completion: nil)
                let vc = strongSelf.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                vc.modalPresentationStyle = .fullScreen
                strongSelf.present(vc, animated: true)
            }
            catch{
                print("An error occurred while logging out.")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(actionSheet, animated: true)

    }
    
}
