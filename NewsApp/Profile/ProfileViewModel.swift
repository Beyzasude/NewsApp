//
//  ProfileViewModel.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 11.09.2023.
//

import Foundation
import Firebase
import UIKit

class ProfileViewModel {
    func getData(userName: UILabel, email: UILabel, phone: UILabel, country:UILabel){
       
        //showActivityIndicator()
        let db = Firestore.firestore()
        let userDocument = db.collection("users").document()
        let userId = Auth.auth().currentUser?.uid
        db.collection("users").whereField("userId", isEqualTo: userId!).getDocuments { (querySnapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let documents = querySnapshot?.documents else {
                print(error?.localizedDescription as Any)
                return
            }
            for document in documents {
                let data = document.data()
                
                if let username = data["username"] as? String {
                    DispatchQueue.main.async {
                        userName.text = username
                    }
                }
                if let emailF = data["email"] as? String {
                    DispatchQueue.main.async {
                        email.text = emailF
                    }
                }
                if let countryF = data["country"] as? String {
                    DispatchQueue.main.async {
                        country.text = countryF
                    }
                }
                if let phoneNumberF = data["phoneNumber"] as? String {
                    DispatchQueue.main.async {
                        phone.text = phoneNumberF
                    }
                }
            }
            //self.hideActivityIndicator()
        }
    }
    
    func screenMode(sender: UISegmentedControl) {
        let appDelegate = UIApplication.shared.windows.first
        if sender.selectedSegmentIndex == 1 {
            appDelegate?.overrideUserInterfaceStyle = .dark
        }
        else{
            appDelegate?.overrideUserInterfaceStyle = .light
        }
    }
    
    func languageMode(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 1 {
            UserDefaults.standard.set("tr", forKey: "language")
        }
        else{
            UserDefaults.standard.set("en", forKey: "language")
        }
    }
    
    
}
