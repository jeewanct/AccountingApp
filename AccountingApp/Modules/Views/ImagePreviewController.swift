//
//  ImagePreviewController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 10/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout


class ImagePreviewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var numberOfImages: UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    var imagePath: [String]?
    
}


//MARK: Collection View Delegates & Data source

extension ImagePreviewController: UICollectionViewDataSource{
    
    func configureCollectionView(){
        
        collectionView.register(UINib(nibName: ProjectNibs.imagePreviewCell.rawValue, bundle: nil), forCellWithReuseIdentifier: ProjectNibs.imagePreviewCell.rawValue)
        
        if let layout = collectionView.collectionViewLayout as? UPCarouselFlowLayout{
            layout.spacingMode = .overlap(visibleOffset: 0)
            layout.itemSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
            layout.scrollDirection = .horizontal
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProjectNibs.imagePreviewCell.rawValue, for: indexPath) as! ImagePreviewCell
        return cell
    }
    
    
    
}

extension ImagePreviewController: UICollectionViewDelegate{
    
    
}
