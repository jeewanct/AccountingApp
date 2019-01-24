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
    
    var task: ProjectTaskEntity?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup(){
        taskName.text = task?.taskAndHours
        taskDescription.text = task?.taskDescription
    }
    
    
}
