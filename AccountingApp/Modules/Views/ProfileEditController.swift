//
//  ProfileEditController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 15/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit
import ReusableFramework


class ProfileEditController: UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        presenter?.updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationItem.title = EditContants.editTitle.rawValue
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationItem.title = ""
    }
    
    let editRequest = EditRequestEntity()
    var editDetails: EditProfileEntity?
    var presenter: ViewToPresenterProtocol?
    let imagePicker = UIImagePickerController()
    
}

extension ProfileEditController{
    
    func configureTableView(){
        
        imagePicker.delegate = self
        
        tableView.estimatedRowHeight = 50
        tableView.estimatedSectionFooterHeight = 50
        tableView.estimatedSectionHeaderHeight = 50
        
        tableView.register(UINib(nibName: EditContants.editProfileImageCell.rawValue, bundle: nil), forCellReuseIdentifier: EditContants.editProfileImageCell.rawValue)
        tableView.register(UINib(nibName: EditContants.editProfileTextCell.rawValue, bundle: nil), forCellReuseIdentifier: EditContants.editProfileTextCell.rawValue)
        tableView.register(UINib(nibName: EditContants.editProfileButtonCell.rawValue, bundle: nil), forCellReuseIdentifier: EditContants.editProfileButtonCell.rawValue)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0: return view.frame.width * 0.3 + 16
        default: return view.frame.height * 0.07 + 16
            
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0, 2: return 1
        default: return editDetails?.userInfo.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: EditContants.editProfileImageCell.rawValue, for: indexPath) as! EditProfileImageCell
            cell.profileImageButton.addTarget(self, action: #selector(handleProfile), for: .touchUpInside)
            cell.imageName = editDetails?.userImage
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: EditContants.editProfileButtonCell.rawValue, for: indexPath) as! EditProfileButtonCell
            cell.updateButton.addTarget(self, action: #selector(handleUpdate(btn:)), for: .touchUpInside)
            cell.uploadInfo = editDetails?.updateButtonEntity
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: EditContants.editProfileTextCell.rawValue, for: indexPath) as! EditProfileTextCell
            cell.editInfo = editDetails?.userInfo[indexPath.item]
            return cell
        }
    }
}

extension ProfileEditController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @objc func handleProfile(){
        
        let ac = UIAlertController(title: EditContants.imageTitle.rawValue, message: "", preferredStyle: .actionSheet)
        
        let firstpOtion = UIAlertAction(title: EditContants.selectGallery.rawValue, style: .default) { (action) in
            self.handleGallery()
        }
        
        let secondOption = UIAlertAction(title: EditContants.selectCamera.rawValue, style: .default) { (action) in
            self.handleCamera()
        }
        
        let cancelOption = UIAlertAction(title: EditContants.cancel.rawValue, style: .cancel, handler: nil)
        
        ac.addAction(firstpOtion)
        ac.addAction(secondOption)
        ac.addAction(cancelOption)
        present(ac, animated: true, completion: nil)
        
    }
    
    
    @objc func handleGallery(){
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func handleCamera(){
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            let cell = tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? EditProfileImageCell
            cell?.profileImageButton.setImage(pickedImage.withRenderingMode(.alwaysOriginal), for: .normal)
                editDetails?.updateButtonEntity.tag = 1
                editRequest.image = pickedImage.jpegData(compressionQuality: 0)
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleUpdate(btn: UIButton){
        
        let (firstName, lastName) = getFirstLastCell()
        
        if btn.tag == 0 && firstName?.textField.text == "" && lastName?.textField.text == "" {
            self.sheetStyleAlert(message: EditContants.nothingToUpdate.rawValue)
        }else{
            
            if Reachability.isConnectedToNetwork(){
                editProfile(btn: btn)
            }else{
                self.notInternetView()
            }
            
        }
        
        
    }
    
    func editProfile(btn: UIButton){
        
        
        let (firstNameCell, lastNameCell) = getFirstLastCell()
        
        if let firstName = firstNameCell?.textField.text{
            editRequest.firstName = firstName
        }else{
            editRequest.firstName = firstNameCell?.textField.placeholder
        }
        
        if let lastName = lastNameCell?.textField.text{
            editRequest.lastName = lastName
        }else{
            editRequest.lastName = lastNameCell?.textField.placeholder
        }
        
        editDetails?.updateButtonEntity.isAnimating = true
        
        let indexSet = IndexSet(arrayLiteral: 2)
        tableView.reloadSections(indexSet, with: .none)
        presenter?.updateView(body: editRequest)
        
    }
    
    func getFirstLastCell() -> (EditProfileTextCell?, EditProfileTextCell?){
        let firstNameCell = tableView.cellForRow(at: IndexPath(item: 0, section: 1)) as? EditProfileTextCell
        let lastNameCell = tableView.cellForRow(at: IndexPath(item: 1, section: 1)) as? EditProfileTextCell
        
        return (firstNameCell, lastNameCell)
        
    }
    
}


extension ProfileEditController: PresenterToViewProtocol{
    
    func showContent<T>(news: T) {
        
        if let content = news as? EditProfileEntity{
            self.editDetails = content
            tableView.reloadData()
        }
        
        if let message = news as? String{
            self.sheetStyleAlert(message: message)
            presenter?.updateView()
        }
        
    }
    
    func showError<T>(error: T) {
        if let getError = error as? String{
            self.sheetStyleAlert(message: getError)
        }
        
    }
    
}
