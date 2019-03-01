//
//  ProjectDateCell.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 21/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

class ProjectDateCell: UITableViewCell{

    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var projectInstance: ProjectsController?
    
    var dateList: [ProjectDateEntity]?{
        didSet{
           collectionView.reloadData()
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
}

extension ProjectDateCell{
    func setup(){
        configureCollectionCell()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configureCollectionCell(){
        if let layout = collectionView.collectionViewLayout as? UPCarouselFlowLayout{
            layout.spacingMode = .overlap(visibleOffset: 0)
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2, height: 46)
            layout.scrollDirection = .horizontal
        }
    }
}

extension ProjectDateCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width * 0.3, height: 46)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectDateCollectionCell", for: indexPath) as! ProjectDateCollectionCell
        cell.dateDetail = dateList?[indexPath.item]
        return cell
    }
    
}

extension ProjectDateCell{
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let center = CGPoint(x: targetContentOffset.pointee.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
        if let ip = self.collectionView!.indexPathForItem(at: center) {
            //self.pageControl.currentPage = ip.row
            //print(ip.row)
            
            projectInstance?.projectEntity.currentDisplayTask = dateList?[ip.row].taskList
            
            let indexSet = IndexSet(arrayLiteral: 2)
            projectInstance?.tableView.reloadSections(indexSet, with: .automatic)
            
        }
        
    }
    
   
    
}
