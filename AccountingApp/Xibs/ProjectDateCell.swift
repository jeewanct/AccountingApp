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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectDateCollectionCell", for: indexPath) as! ProjectDateCollectionCell
        //cell.dateDetail = dateList?[indexPath.item]
        return cell
    }
    
}

extension ProjectDateCell{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ProjectDateCollectionCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ProjectDateCollectionCell
        
    }
    
}
