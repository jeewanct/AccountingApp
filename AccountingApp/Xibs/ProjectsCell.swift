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
    var projects: [ProjectsEntity]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
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
        return projects?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectDetailCell", for: indexPath) as! ProjectDetailCell
        cell.project = projects?[indexPath.item]
        return cell
    }
    
    
}

extension ProjectsCell{
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if let layout = collectionView.collectionViewLayout as? UPCarouselFlowLayout{
            
            
           print(layout.itemSize.width)
            print(UIScreen.main.bounds.width)
            let current = targetContentOffset.pointee.x / (layout.itemSize.width - 32 * 2)
            print(Int(current))
            //pagerControl.currentPage = Int(current) - 1
            
        }
        
        
        
    }
    
}
