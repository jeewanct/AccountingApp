//
//  ProjectDetailCell.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 21/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit

class ProjectDetailCell: UICollectionViewCell{
    
    var project: ProjectsEntity?{
        didSet{
            setup()
        }
    }
    
    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var createdByLbl: UILabel!
    @IBOutlet weak var canEdit: UIButton!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    
    weak var parentInstance: ProjectsController?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(){
        if let editValue = project?.canEdit{
            canEdit.isHidden = !editValue
        }
        
        projectName.text = project?.projectName
        startDate.text = project?.startDate
        endDate.text = project?.endDate
        createdByLbl.text = project?.createdBy
        
        
    }
    @IBAction func handleEdit(_ sender: Any) {
        let editProject = CreateProjectEntity(projectId: project?.projectId, createdBy: project?.createdBy, type: CreateProjectTypeEnum.edit.rawValue)
        editProject.ProjectAssignTo = project?.assigneeList
        editProject.ProjectName = project?.projectName
        editProject.ProjectBudGet = project?.projectBudget
        editProject.serverStartDate = project?.serverStartDate
        editProject.serverEndDate = project?.serverEndDate
        parentInstance?.handleEditProjects(editProject: editProject)
    }
    
    
}
