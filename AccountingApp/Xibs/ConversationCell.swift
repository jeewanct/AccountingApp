//
//  ConversationCell.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 10/02/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

protocol ImageDeleteDelegate{
    func deleteImage(at index: Int)
}
class ConversationCell: UICollectionViewCell{
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    var delegate: ImageDeleteDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    @IBAction func handleDelete(){
        delegate?.deleteImage(at: deleteButton.tag)
    }
}
