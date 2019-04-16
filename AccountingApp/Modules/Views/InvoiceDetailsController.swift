//
//  InvoiceDetailsController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 21/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

class InvoiceDetailsController: UIViewController{

    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var invoiceCollectionView: UICollectionView!
    var invoiceDetail: InvoiceDetailsEntity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationItem.title = InvoiceContants.title.rawValue
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    func setup(){
      //  imageCollectionView.register(UINib(nibName: "CollectionCellWithImage", bundle: nil), forCellWithReuseIdentifier: "CollectionCellWithImage")
        if let layout = imageCollectionView.collectionViewLayout as? UPCarouselFlowLayout{
            layout.spacingMode = .overlap(visibleOffset: 8)
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: imageCollectionView.frame.height)
            layout.scrollDirection = .horizontal
        }
    }
}


extension InvoiceDetailsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: imageCollectionView.frame.width, height: imageCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageCollectionView{
            return invoiceDetail.invoiceImage.count
        }
        return invoiceDetail.invoiceDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == imageCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InvoiceImageCell", for: indexPath) as! InvoiceImageCell
            cell.image.addImage(url: invoiceDetail.invoiceImage[indexPath.item])
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InvoiceDetailCollectionCell", for: indexPath) as! InvoiceDetailCollectionCell
        cell.invoiceDetail = invoiceDetail.invoiceDetails[indexPath.item]
        return cell
        
    }
    
    
}
