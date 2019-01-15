//
//  GroupChatHeader.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 15/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class GroupChatHeader: UIView{
    
    @IBOutlet weak var cardView: CardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        cardView.roundCorners1(corners: [.topLeft, .topRight], radius: 10)
    }
}
