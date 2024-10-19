//
//  UserProfileViewController.swift
//  PillCare
//
//  Created by Moin Janjua on 13/08/2024.
//

import UIKit

class UserProfileViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var u_View: UIView!
    @IBOutlet weak var UserProfile_image: UIImageView!
    @IBOutlet weak var Add_Info_Btn: UIButton!
    @IBOutlet weak var Name_Texetfield: UITextField!
    @IBOutlet weak var description_Textfield: UITextField!
    var pickedImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        u_View.layer.cornerRadius = 15
        
        Add_Info_Btn.layer.cornerRadius = 20
        Add_Info_Btn.clipsToBounds = true
        description_Textfield.delegate = self
        //    imagePiker Works
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        UserProfile_image.isUserInteractionEnabled = true
        UserProfile_image.addGestureRecognizer(tapGesture)
       // UserProfile_image.layer.cornerRadius = 50
        
        let tapGestureDiss = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGestureDiss.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureDiss)

        // Load data if available
        loadData()
        
        makeImageViewCircular(imageView: UserProfile_image)
    }
    @objc func hideKeyboard()
      {
          view.endEditing(true)
      }

    func makeImageViewCircular(imageView: UIImageView) {
           // Ensure the UIImageView is square
           imageView.layer.cornerRadius = imageView.frame.size.width / 2
           imageView.clipsToBounds = true
       }
    
    //ImagePicker Works
    @objc func imageViewTapped() {
        openGallery()
    }
    func openGallery() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    func yourFunctionToTriggerImagePicker() {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let pickedImage = info[.originalImage] as? UIImage {
               picker.dismiss(animated: true) {
                   self.pickedImage = pickedImage
                   self.UserProfile_image.image = pickedImage
               }
           }
       }
    
    @objc func saveData() {
           // Save text fields
           UserDefaults.standard.set(Name_Texetfield.text, forKey: "name")
           UserDefaults.standard.set(description_Textfield.text, forKey: "description")

           // Save image
           if let image = UserProfile_image.image, let imageData = image.pngData() {
               UserDefaults.standard.set(imageData, forKey: "savedImage")
           }
           // Notify user
           let alert = UIAlertController(title: "Success", message: "Data has been saved successfully!", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
       }
    
    func loadData() {
        // Load text fields
        Name_Texetfield.text = UserDefaults.standard.string(forKey: "name")
        description_Textfield.text = UserDefaults.standard.string(forKey: "description")
        
        // Load image
        if let imageData = UserDefaults.standard.data(forKey: "savedImage"), let image = UIImage(data: imageData) {
            UserProfile_image.image = image
        }
    }

    @IBAction func AddInformationButton(_ sender: Any) {
        saveData()
        Add_Info_Btn.setTitle("Update", for: .normal)
    }
    
}
