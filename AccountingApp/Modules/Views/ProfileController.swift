//
//  ProfileViewController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//


import UIKit

class ProfileController: UIViewController{
    
    var presenter: ViewToPresenterProtocol?
    
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = false
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
        navigationController?.navigationBar.prefersLargeTitles = true
        tabBarController?.tabBar.isHidden = true
    }
}

extension ProfileController{
    
    func setup(){
        tableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")
        self.navigationController?.hideTranslucency()
        presenter?.updateView()
        
    }
    
}


extension ProfileController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.07
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        cell.optionImageView.image = [#imageLiteral(resourceName: "groups"), #imageLiteral(resourceName: "notification"), #imageLiteral(resourceName: "settings"), #imageLiteral(resourceName: "logout")][indexPath.item]
        cell.optionLabel.text = [ProfileConstants.groups, ProfileConstants.notifications, ProfileConstants.settings, ProfileConstants.logout][indexPath.item]
        return cell
    }
}


extension ProfileController{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            let groupController = GroupRoutes.createModule()
            navigationController?.pushViewController(groupController, animated: true)
        case 2:
            let storyBoard = InvoiceRoute.mainstoryboard
            let settingsController = storyBoard.instantiateViewController(withIdentifier: "SettingsController") as! SettingsController
            navigationController?.pushViewController(settingsController, animated: true)
        default:
            print("")
        }
    }
}

extension ProfileController: PresenterToViewProtocol {
   
    func showContent<T>(news: T) {
        
        if let profileData = news as? Profile{
            userName.text = profileData.name
            userProfile.addImage(url: profileData.profileImage)
        }
        
    }
    
    func showError() {
        
    }

}
