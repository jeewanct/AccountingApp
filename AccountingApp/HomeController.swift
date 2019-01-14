//
//  HomeController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit

class HomeController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    lazy var cameraButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "cameraTab").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleCamera), for: .touchUpInside)
        return btn
    }()
    
}

extension HomeController{
    
    func setup(){
        
        
        
        
        let reports =  UINavigationController(rootViewController: ReportsRoute.createModule())
        let projects =  UINavigationController(rootViewController: ProjectRoute.createModule())
        let camera = UINavigationController(rootViewController: CameraRoute.createModule())
        let invoice = UINavigationController(rootViewController:  InvoiceRoute.createModule())
        let profile = UINavigationController(rootViewController:  ProfileRoute.createModule())
       
        viewControllers = [reports, projects, camera, invoice, profile]
        
        addViews()
    }
    
    func addViews(){
        tabBar.addSubview(cameraButton)
        
        tabBar.centerXAnchor.constraint(equalTo: cameraButton.centerXAnchor).isActive = true
        cameraButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
        cameraButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
        tabBar.topAnchor.constraint(equalTo: cameraButton.centerYAnchor, constant: -15).isActive = true
    }
    
}

extension HomeController{
    
    @objc func handleCamera(){
        
        let camera = CameraRoute.createModule()
        self.present(UINavigationController(rootViewController: camera), animated: true, completion: nil)
        
    }
    
}
