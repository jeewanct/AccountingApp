//
//  NotificationControllerDetails.swift
//  CameraApp
//
//  Created by Jeevan Tiwari on 17/09/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class NotificationControllerDetails: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "NOTIFICATION DETAIL"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
        tabBarController?.tabBar.isHidden = false
    }
}

extension NotificationControllerDetails: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationDetailsCell", for: indexPath) as! NotificationDetailsCell
        return cell
    }
}
