//
//  CalendarCell.swift
//  CameraApp
//
//  Created by JEEVAN TIWARI on 25/04/18.
//  Copyright © 2018 JEEVAN TIWARI. All rights reserved.
//

import UIKit
import JTAppleCalendar


class CalendarViewCell: JTAppleCell{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        backgroundColor = .clear
    }
    
    
    override func draw(_ rect: CGRect) {
        selectedView.layer.cornerRadius = selectedView.frame.height / 2
    }
    
    func addViews(){
        addSubview(selectedView)
        selectedView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        selectedView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        selectedView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        selectedView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        
        
        addSubview(dateLabel)
        dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 1)
        lbl.font = UIFont(name: "Quicksand-Light", size: 15)
        return lbl
    }()
    
    let selectedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
}
