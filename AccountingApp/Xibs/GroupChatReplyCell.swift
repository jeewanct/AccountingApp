//
//  GroupChatReplyCell.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 15/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class GroupChatReplyCell: UITableViewCell{
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postedDate: UILabel!
    
    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
