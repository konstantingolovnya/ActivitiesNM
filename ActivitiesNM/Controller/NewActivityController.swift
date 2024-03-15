//
//  NewActivityController.swift
//  ActivitiesNM
//
//  Created by Konstantin on 12.03.2024.
//

import UIKit

class NewActivityController: UITableViewController {
    
    @IBOutlet var photoImageView: UIImageView! {
        didSet {
            photoImageView.layer.cornerRadius = 10
            photoImageView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet var nameTextField: RoundedTextField! {
        didSet {
            nameTextField.tag = 1
            nameTextField.becomeFirstResponder()
            nameTextField.delegate = self
        }
    }
    
    @IBOutlet var typeTextField: RoundedTextField! {
        didSet {
            typeTextField.tag = 2
            typeTextField.delegate = self
        }
    }
    
    @IBOutlet var addressTextField: RoundedTextField! {
        didSet {
            addressTextField.tag = 3
            addressTextField.delegate = self
        }
    }
    
    @IBOutlet var phoneTextField: RoundedTextField! {
        didSet {
            phoneTextField.tag = 4
            phoneTextField.delegate = self
        }
    }
    
    @IBOutlet var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.tag = 5
            descriptionTextView.layer.cornerRadius = 10
            descriptionTextView.layer.masksToBounds = true
        }
    }
    
    var activity: Activity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        if let appearance = navigationController?.navigationBar.standardAppearance {
            
            if let customFont = UIFont(name: "Nunito-Bold", size: 40) {
                appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!, .font: customFont]
            }
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
        }
        
        let margins = photoImageView.superview!.layoutMarginsGuide
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        photoImageView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        
        let tap = UIGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - UITableViewDelegate Protocol
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let photoSourceRequestController = UIAlertController(title: "", message: "Загрузите фото", preferredStyle: .actionSheet)
            let cameraAction = UIAlertAction(title: "Сделать фото", style: .default) { action in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    
                    self.present(imagePicker, animated: true)
                    imagePicker.delegate = self
                }
            }
            
            let photoLibraryAction = UIAlertAction(title: "Выбрать фото", style: .default) { action in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    
                    self.present(imagePicker, animated: true)
                    imagePicker.delegate = self
                }
            }
            
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
            
            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibraryAction)
            photoSourceRequestController.addAction(cancelAction)
            
            if let popoverController = photoSourceRequestController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            present(photoSourceRequestController, animated: true)
        }
    }
    
    //MARK: - Save Action
    @IBAction func saveButtonAction(sender: UIButton) {
        if nameTextField.text == "" || typeTextField.text == "" || phoneTextField.text == "" || addressTextField.text == "" || descriptionTextView.text == "" {
            let formValidationController = UIAlertController(title: "Не удалось сохранить", message: "Пожалуйста, заполните все поля.", preferredStyle: .alert)
            let formValidationAction = UIAlertAction(title: "Хорошо", style: .cancel)
            
            formValidationController.addAction(formValidationAction)
            
            present(formValidationController, animated: true)
            
            return
        }
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            
            activity = Activity(context: appDelegate.persistentContainer.viewContext)
            activity.name = nameTextField.text!
            activity.type = typeTextField.text!
            activity.phone = phoneTextField.text!
            activity.location = addressTextField.text!
            activity.summary = descriptionTextView.text!
            activity.isFavorite = false
            
            if let imageData = photoImageView.image?.pngData() {
                activity.image = imageData
            }
            
            appDelegate.saveContext()
        }
        
        dismiss(animated: true)
    }
    
}

//MARK: - UITextFieldDelegate Protocol
extension NewActivityController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        return true
    }
}

//MARK: - UIImagePickerControllerDelegate Protocol, UINavigationControllerDelegate Protocol
extension NewActivityController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        
        dismiss(animated: true)
    }
}
