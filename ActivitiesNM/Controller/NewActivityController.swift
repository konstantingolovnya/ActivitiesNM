//
//  NewActivityController.swift
//  ActivitiesNM
//
//  Created by Konstantin on 12.03.2024.
//

import UIKit

class NewActivityController: UITableViewController {
    
    var activity: Activity!
    private var activityAttributes = [String: String]()
    
    private let newActivityLabels = ["НАЗВАНИЕ", "ТИП", "АДРЕС", "ТЕЛЕФОН", "ПРИМЕЧАНИЕ"]
    private let newActivityBody = ["Введите название активности", "Введите тип активности", "Введите адрес активности", "Введите номер телефона активности", "Замечательное место, можно провести здесь выходные."]
    
    //MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Новая активность"
        setupNavigationBar()
        setupTableView()
        
        let saveNewActivityButton = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveNewActivityButtonTapped))
        navigationItem.rightBarButtonItem = saveNewActivityButton
    }
    
    //MARK: - Setup Methods
    private func setupNavigationBar() {
        if let appearance = navigationController?.navigationBar.standardAppearance {
            if let customFont = UIFont(name: "Nunito-Bold", size: 40) {
                appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!, .font: customFont]
            }
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(NewActivityTextFieldCell.self, forCellReuseIdentifier: String(describing: NewActivityTextFieldCell.self))
        tableView.register(NewActivityDescriptionTextCell.self, forCellReuseIdentifier: String(describing: NewActivityDescriptionTextCell.self))
        tableView.register(NewActivityPhotoCell.self, forHeaderFooterViewReuseIdentifier: String(describing: NewActivityPhotoCell.self))
    }
    
    //MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newActivityLabels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0...3:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewActivityTextFieldCell.self), for: indexPath) as! NewActivityTextFieldCell
            cell.configure(labelText: newActivityLabels[indexPath.row], placeholderText: newActivityBody[indexPath.row], tag: indexPath.row, delegate: self)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewActivityDescriptionTextCell.self), for: indexPath) as! NewActivityDescriptionTextCell
            cell.configure(labelText: newActivityLabels[indexPath.row], text: newActivityBody[indexPath.row], tag: indexPath.row)
            return cell
        default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: NewActivityPhotoCell.self)) as! NewActivityPhotoCell
        headerView.tapHandler = { [unowned self] _ in
            headerTapped(headerView: headerView)
        }
        return headerView
    }
    
    //MARK: - Adding a photo
    private func headerTapped(headerView: UITableViewHeaderFooterView) {
        let photoSourceRequestController = UIAlertController(title: "", message: "Загрузите фото", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Сделать фото", style: .default) { _ in
            self.presentImagePicker(with: .camera)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Выбрать фото", style: .default) { _ in
            self.presentImagePicker(with: .photoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        photoSourceRequestController.addAction(cameraAction)
        photoSourceRequestController.addAction(photoLibraryAction)
        photoSourceRequestController.addAction(cancelAction)
        
        if let popoverController = photoSourceRequestController.popoverPresentationController {
            popoverController.sourceView = headerView
            popoverController.sourceRect = headerView.bounds
        }
        present(photoSourceRequestController, animated: true)
    }
    
    private func presentImagePicker(with sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = false
            imagePicker.sourceType = sourceType
            imagePicker.delegate = self
            present(imagePicker, animated: true)
        }
    }
    
    //MARK: - Save Action
    @objc private func saveNewActivityButtonTapped() {
        for i in 0..<newActivityLabels.count {
            let indexPath = IndexPath(row: i, section: 0)
            if i == newActivityLabels.count - 1 {
                if let cell = tableView.cellForRow(at: indexPath) as? NewActivityDescriptionTextCell, !cell.body.text.isEmpty {
                    activityAttributes[newActivityLabels[i]] = cell.body.text
                }
            } else {
                if let cell = tableView.cellForRow(at: indexPath) as? NewActivityTextFieldCell, !cell.body.text!.isEmpty {
                    activityAttributes[newActivityLabels[i]] = cell.body.text
                }
            }
        }
        
        if activityAttributes.count != newActivityLabels.count {
            presentFormValidationAlert()
            return
        }
        
        saveActivity()
        dismiss(animated: true)
    }
    
    private func presentFormValidationAlert() {
        let alertController = UIAlertController(title: "Не удалось сохранить", message: "Пожалуйста, заполните все поля.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Хорошо", style: .cancel)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
    private func saveActivity() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            activity = Activity(context: appDelegate.persistentContainer.viewContext)
            activity.name = activityAttributes[newActivityLabels[0]]!
            activity.type = activityAttributes[newActivityLabels[1]]!
            activity.location = activityAttributes[newActivityLabels[2]]!
            activity.phone = activityAttributes[newActivityLabels[3]]!
            activity.summary = activityAttributes[newActivityLabels[4]]!
            activity.isFavorite = false
            
            if let headerView = tableView.headerView(forSection: 0) as? NewActivityPhotoCell, let imageData = headerView.photoImageView.image?.pngData() {
                activity.image = imageData
            }
            appDelegate.saveContext()
        }
    }
}

//MARK: - UITextFieldDelegate Protocol
extension NewActivityController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) as? UITextField {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        return true
    }
}

//MARK: - UIImagePickerControllerDelegate Protocol, UINavigationControllerDelegate Protocol
extension NewActivityController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let headerView = tableView.headerView(forSection: 0) as? NewActivityPhotoCell, let selectedImage = info[.originalImage] as? UIImage {
            headerView.photoImageView.image = selectedImage
            headerView.photoImageView.contentMode = .scaleAspectFill
            headerView.photoImageView.clipsToBounds = true
        }
        dismiss(animated: true)
    }
}

// MARK: - Custom UITableViewCell Configurations
extension NewActivityTextFieldCell {
    func configure(labelText: String, placeholderText: String, tag: Int, delegate: UITextFieldDelegate) {
        self.label.text = labelText
        self.body.placeholder = placeholderText
        self.body.tag = tag
        self.body.delegate = delegate
    }
}

extension NewActivityDescriptionTextCell {
    func configure(labelText: String, text: String, tag: Int) {
        self.label.text = labelText
        self.body.text = text
        self.body.tag = tag
    }
}
