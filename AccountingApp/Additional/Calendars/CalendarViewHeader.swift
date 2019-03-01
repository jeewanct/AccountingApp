//
//  CalendarViewHeader.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 25/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit
import JTAppleCalendar


class CalendarViewHeader: JTAppleCollectionReusableView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    func addViews(){
        addSubview(monthLabel)
        monthLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        monthLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        monthLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        monthLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        //monthLabel.anchorToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let monthLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "<  January  >"
        //lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Quicksand-Bold", size: 15)
        return lbl
    }()
    
}
