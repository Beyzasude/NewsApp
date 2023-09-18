//
//  Utilities.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 9.09.2023.
//

import Foundation
import UIKit

class Utilities {
    
    static func showAlert(from viewController: UIViewController, withMessage message: String) {
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
        
    }
    
    static func showCustomAlert(from viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showSuccessAlert(from viewController: UIViewController, withMessage message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Successful", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            completion?()
        }
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func publishDateFormat(publishedAt: String?) -> String {
        //gelen tarihi formatlama
        var dateStringFormat = ""
        let dateString = publishedAt ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMMM dd, yyyy"
            dateFormatter.locale = Locale(identifier: "en_US")
            let formattedDate = dateFormatter.string(from: date)
            print(formattedDate)
            dateStringFormat = formattedDate
            //publishTimeLabel.text = dateStringFormat
            return dateStringFormat
        } 
        return "Invalid date format."
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func isValidEmail(_ email: String) -> Bool {
            // Temel bir e-posta doğrulama kontrolü yapılabilir.
            // Bu örnekte, basit bir kontrol yapılıyor, gerçek bir e-posta doğrulama işlemi için daha kapsamlı bir çözüm kullanmanız önerilir.
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            return emailPredicate.evaluate(with: email)
        }
}
