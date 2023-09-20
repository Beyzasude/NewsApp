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
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
   
    var viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getData(userName: userNameLabel, email: emailLabel, phone: phoneLabel, country: countryLabel)
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 65
        self.profileImageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
        self.profileImageView.addGestureRecognizer(gesture)
    }
    
    @objc private func didTapChangeProfilePic() {
        presentPhotoActionSheet()
    }
    
    @IBAction func darkLigtModeSegmentAct(_ sender: UISegmentedControl) {
        viewModel.screenMode(sender: sender)
    }
    
    @IBAction func languageModeSegmentAct(_ sender: UISegmentedControl) {
        viewModel.languageMode(sender: sender)
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
                print(error.localizedDescription)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(actionSheet, animated: true)

    }
    
    
    
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profil Fotoğrafı",
                                            message: "Nasıl fotoğraf seçmek istersiniz?",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "İptal",
                                            style: .cancel,
                                            handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: "Fotoğraf Çek",
                                            style: .default,
                                            handler: { [weak self] _ in
            self?.presentCamera()
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Fotoğraf Seç",
                                            style: .default,
                                            handler: { [weak self] _ in
            self?.presentPhotoPicker()
            
        }))
        present(actionSheet, animated: true)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else{
            return
        }
        self.profileImageView.image = selectedImage
        //self.lblUploadPhoto.isHidden = true
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

