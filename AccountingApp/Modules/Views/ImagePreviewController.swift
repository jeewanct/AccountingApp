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
    
    var images: [CameraImages]?
    
}


//MARK: Collection View Delegates & Data source

extension ImagePreviewController: UICollectionViewDataSource{
    
    func configureCollectionView(){
        
        navigationItem.title = CameraEnum.title.rawValue
        
        if let count = images?.count{
            numberOfImages.numberOfPages = count
        }
        
        collectionView.register(UINib(nibName: ProjectNibs.imagePreviewCell.rawValue, bundle: nil), forCellWithReuseIdentifier: ProjectNibs.imagePreviewCell.rawValue)
        
        if let layout = collectionView.collectionViewLayout as? UPCarouselFlowLayout{
            layout.spacingMode = .overlap(visibleOffset: 0)
            layout.itemSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
            layout.scrollDirection = .horizontal
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProjectNibs.imagePreviewCell.rawValue, for: indexPath) as! ImagePreviewCell
        cell.imageView.image = images?[indexPath.item].image
        return cell
    }
    
    
    
    
    
}

extension ImagePreviewController: UICollectionViewDelegate{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let center = CGPoint(x: targetContentOffset.pointee.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
        if let ip = self.collectionView!.indexPathForItem(at: center) {
            //self.pageControl.currentPage = ip.row
            //print(ip.row)
            print(ip.row)
            
            numberOfImages.currentPage = ip.row
            
        }
        
    }

    
    
}
