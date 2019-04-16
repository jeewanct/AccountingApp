//
//  ProfileViewController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//


import UIKit
import ReusableFramework


class ProfileController: UITableViewController{
    
    var presenter: ViewToPresenterProtocol?
    
    var profileDetails: ProfileEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
    }
    
    @IBAction func handleEditProfile(_ sender: Any) {
        
        let editChat = ProfileEditRoute.createModule()
        navigationController?.pushViewController(editChat, animated: true)
    }
    
}

extension ProfileController{
    
    func setup(){
        
        tableView.register(UINib(nibName: "ProfileImageCell", bundle: nil), forCellReuseIdentifier: "ProfileImageCell")
        tableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")
        self.navigationController?.hideTranslucency()
        presenter?.updateView()
        
    }
    
}


extension ProfileController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
   override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    if indexPath.section == 0 {
        return UITableView.automaticDimension
    }
        return UIScreen.main.bounds.height * 0.07
    }
    
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if section == 0 {
        return 1
    }
        return profileDetails?.profileOptions?.count ?? 0
    }
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileImageCell", for: indexPath) as! ProfileImageCell
        cell.userName.text = profileDetails?.name
        cell.imageName = profileDetails?.imageUrl
        return cell
    }
    
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        cell.optionImageView.image = profileDetails?.profileOptions?[indexPath.item].image
        cell.optionLabel.text = profileDetails?.profileOptions?[indexPath.item].groupName
        return cell
    }
}


extension ProfileController{
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if indexPath.section == 1{
        switch indexPath.item {
        case 0:
            let groupController = GroupRoutes.createModule()
            navigationController?.pushViewController(groupController, animated: true)
        case 1:
            let storyBoard = UIStoryboard(name: "Notification", bundle: nil).instantiateViewController(withIdentifier: "NotificationController") as! NotificationController
            navigationController?.pushViewController(storyBoard, animated: true)
        case 2:
            let storyBoard = InvoiceRoute.mainstoryboard
            let settingsController = storyBoard.instantiateViewController(withIdentifier: "SettingsController") as! SettingsController
            navigationController?.pushViewController(settingsController, animated: true)
        case 3:
            
            handleLogout()
        default:
            print("")
        }
    }
    }
}

extension ProfileController{
    
    func handleLogout(){
        
        if Reachability.isConnectedToNetwork(){
            showConfirmationMessageToUser()
        }else{
            self.notInternetView()
        }
        
    }
    
    func showConfirmationMessageToUser(){
        
        let alertController = UIAlertController(title: "", message: AlertMessage.logout.rawValue + UserHelper.nameOfUser() + "?", preferredStyle: .actionSheet)
        
        let okAction = UIAlertAction(title: AlertMessage.ok.rawValue, style: .default) { [unowned self] (action) in
            
            self.showIndicator(value: true)
            self.presenter?.updateView(body: "")
            
        }
        
        let cancelAction = UIAlertAction(title: AlertMessage.cancel.rawValue, style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }

    func showIndicator(value: Bool){
        
        let logoutIndex = IndexPath(item: 3, section: 1)
        let cell = tableView.cellForRow(at: logoutIndex) as? ProfileCell
        
        if value == true{
            cell?.showActivityIndicator()
        }else{
            cell?.hideActivityIndicator()
        }
        
        
        view.isUserInteractionEnabled = !value
    }
    
    func logoutSuccess(){
        showIndicator(value: false)
        
        ChangeRootViewController.changeRootViewController(to: ChangeToControllerEnum.LoginController)
        
    }
    
    func logoutFailed(){
        showIndicator(value: false)
    }
    
}

extension ProfileController: PresenterToViewProtocol {
   
    func showContent<T>(news: T) {
        
        if let profileData = news as? ProfileEntity{
           profileDetails = profileData
            tableView.reloadData()
        }
        
        if let _ = news as? String{
            logoutSuccess()
        }
        
    }
    
    func showError<T>(error: T) {
        if let errorMessage = error as? String{
            self.showAlert(message: errorMessage)
            logoutFailed()
        }
    }

}
