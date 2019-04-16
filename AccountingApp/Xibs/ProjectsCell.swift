//
//  ProjectsCollectionCell.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 21/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

class ProjectsCell: UITableViewCell{
    
    @IBOutlet weak var collectionView: UICollectionView!
    weak var projectInstance: ProjectsController?
    var projects: [ProjectsEntity]?{
        didSet{
            collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    @IBAction func editProject(_ sender: Any) {
        
    }
    
}

extension ProjectsCell{
    func setup(){
        collectionView.delegate = self
        collectionView.dataSource =  self
        
        if let layout = collectionView.collectionViewLayout as? UPCarouselFlowLayout{
            layout.spacingMode = .overlap(visibleOffset: 8)
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 200)
            layout.scrollDirection = .horizontal
        }
    }
}

extension ProjectsCell: UICollectionViewDelegate, UICollectionViewDataSource{

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (projects?.count ?? 0) > 5{
            return 5
        }
        return projects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectDetailCell", for: indexPath) as! ProjectDetailCell
        cell.project = projects?[indexPath.item]
        cell.parentInstance = projectInstance
        return cell
    }
    
    
}

extension ProjectsCell{
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//
//        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
//        if let ip = self.collectionView!.indexPathForItem(at: center) {
//            //self.pageControl.currentPage = ip.row
//            print(ip.row)
//        }
//    }
//
    
    
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let center = CGPoint(x: targetContentOffset.pointee.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
        if let ip = self.collectionView!.indexPathForItem(at: center) {
            //self.pageControl.currentPage = ip.row
            //print(ip.row)
            
            projectInstance?.projectEntity.currentDisplayDate = projects?[ip.row].dates
            if let taskDates = projects?[ip.row].dates{
                projectInstance?.notTasks.isHidden = true
                if taskDates.count > 0 {
                    projectInstance?.projectEntity.currentDisplayTask = taskDates[0].taskList
                }else{
                    projectInstance?.notTasks.isHidden = false
                    projectInstance?.projectEntity.currentDisplayTask = nil
                }
                
            }else{
                projectInstance?.notTasks.isHidden = false
            }
           // projectInstance?.tableView.reloadData()
            let indexSet = IndexSet(arrayLiteral: 1,2)
            projectInstance?.tableView.reloadSections(indexSet, with: .automatic)
            
        }
    
    }
    
}
