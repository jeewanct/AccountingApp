//
//  NotificationCell.swift
//  CameraApp
//
//  Created by Jeevan Tiwari on 17/09/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell{
    
    @IBOutlet weak var notificationLbl: UILabel!
    
    @IBOutlet weak var notificationTimeLbl: UILabel!
    
    @IBOutlet weak var notificationImage: UIImageView!
    
    var notificationData: NotificationList?{
        didSet{
            setData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        notificationImage.image = #imageLiteral(resourceName: "notificationProfile").withRenderingMode(.alwaysTemplate)
        notificationImage.tintColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
    }
    
    func setData(){
        
        if let data = notificationData{
            
            notificationLbl.attributedText = LogicHelper.returnAttributedString(firstElement: notificationData?.NotificationTitle, secondElement: notificationData?.NotificationBody)
            
            
            notificationTimeLbl.text = LogicHelper.timeAgoSinceDate(LogicHelper.shared.convertStringToDate(date: data.CreatedDate), currentDate: Date(), numericDates: true)
            
        }
        
    }
}
