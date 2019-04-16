//
//  NotificationController.swift
//  CameraApp
//
//  Created by Jeevan Tiwari on 17/09/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit
import RealmSwift


class NotificationController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         tableView.tableFooterView = UIView()
         NotificationCenter.default.addObserver(self, selector: #selector(apiResponse(notification:)), name: Notification.Name(rawValue: "ApiSuccess"), object: nil)
        getNotificationList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "NOTIFICATIONS"
        tabBarController?.tabBar.isHidden = true
        navigationController?.hidesBarsOnSwipe = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
        tabBarController?.tabBar.isHidden = false
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    var offset = 1
    var notificationList = [NotificationList]()
    var activityIndicator = ActivityIndicatorView()
    
}


extension NotificationController{
    
    func getNotificationList(){
       
        NotificationManager.getNotifications(offset: offset)
    }
    
    @objc func apiResponse(notification: Notification){
        
        if let userInfo = notification.userInfo as? [String: Any]{
            
            if let _ = userInfo["noData"] as? Bool{
                offset = -1
            }
            
            if let error =  userInfo["error"] as? Bool{
                if !error{
                    offset = offset + 1
                    getDataFromDatabase()
                }else{
                    
                    if let message = userInfo["messsage"] as? String{
                        Alerts.shared.displaySimpleAlert(displayIn: self, title: "", message: message)
                    }
                    
                }
            }
            
        }
    }
    
    
    func getDataFromDatabase(){
        
        
        notificationList = NotificationManager.getNotificationListFromData()
        tableView.reloadData()
        
    }
    
}


extension NotificationController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        cell.notificationData = notificationList[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch notificationList[indexPath.item].projecttype {
        case 1,2,5:
            let story = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationProject") as! NotificationProject
            story.projectId = String(notificationList[indexPath.item].projectid)
            navigationController?.pushViewController(story, animated: true)
        case 3:
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let replyToChat = storyBoard.instantiateViewController(withIdentifier: "ReplyToConversationController") as! ReplyToConversationController
//            if let _ = groupData{
//                replyToChat.projectId = groupData?.ProjectID
//            }else{
//                replyToChat.projectId = subGroupData?.GroupId
//            }
//            
//            replyToChat.groupData = conversationData
//            replyToChat.subGroupId = subGroupData?.SubGroupId
            
            navigationController?.pushViewController(replyToChat, animated: true)
        
        case 4:
            let controller = InvoiceDetailController()
            controller.from = String(notificationList[indexPath.item].InvoiceId)
            navigationController?.pushViewController(controller, animated: true)
        default:
            print()
        }
        
        
        
        
        
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "UploadUnscannedVoices") as! UploadUnscannedVoices
//        vc.uploadData = unscannedModel?[indexPath.item]
//        parentInstance?.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == notificationList.count - 2{
            if offset != -1{
                getNotificationList()
            }
        }
    }
}
