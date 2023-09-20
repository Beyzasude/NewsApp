//
//  Utilities.swift
//  NewsApp
//
//  Created by Beyza Sude Erol on 9.09.2023.
//

import Foundation
import UIKit

class Utilities {
    
    static var emptyURL = "https://i.pinimg.com/474x/e8/34/c0/e834c0ab77701a16ee1b3c03529dc639.jpg"
    
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
            dateStringFormat = formattedDate
            //publishTimeLabel.text = dateStringFormat
            return dateStringFormat
        }
        return "Invalid date format."
    }
    
    static func todayDate(todayDateLabel: UILabel){
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "E MMMM, yyyy"
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        todayDateLabel.text = formattedDate
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

extension UIViewController {
    func configureNavBarWithLogoImage() {
        var image = UIImage(named: "logo")
        
        if let originalImage = UIImage(named: "logo")?.withRenderingMode(.alwaysOriginal) {
            let newWidth: CGFloat = 30
            let newHeight: CGFloat = 30
            
            if let resizedImage = resizeImage(image: originalImage, newWidth: newWidth, newHeight: newHeight) {
                image = resizedImage.withRenderingMode(.alwaysOriginal)
            }
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
    }
    
    private func resizeImage(image: UIImage, newWidth: CGFloat, newHeight: CGFloat) -> UIImage? {
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}





