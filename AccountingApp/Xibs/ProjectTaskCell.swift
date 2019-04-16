//
//  ProjectTaskCell.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 21/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit

class ProjectTaskCell: UITableViewCell{
    
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var task: ProjectTaskEntity?{
        didSet{
            setup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.isHidden = true
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
       // setup()
    }
    
    func setup(){
        taskName.text = task?.taskAndHours
        taskDescription.text = task?.taskDescription
        activityIndicator.isHidden = true
    }
}
