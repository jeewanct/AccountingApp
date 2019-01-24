//
//  SettingsController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 14/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class SettingsController: UIViewController{
    
    @IBOutlet weak var switchButton: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Settings"
        switchButton.isOn = CredentialsCheck.isSecured()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        
    }
    @IBAction func handleSwitch(_ sender: Any) {
        
        if switchButton.isOn {
            UserDefaults.standard.set(true, forKey: KeysEnum.isBiometric.rawValue)
            ChangeRootViewController.changeRootViewController(to: ChangeToControllerEnum.LoginController)
            
        }else{
            UserDefaults.standard.set(true, forKey: KeysEnum.isBiometric.rawValue)
            
        }
        
    }
    
}

