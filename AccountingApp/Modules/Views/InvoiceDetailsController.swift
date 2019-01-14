//
//  InvoiceDetailsController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 21/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit

class InvoiceDetailsController: UIViewController{

    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var invoiceCollectionView: UICollectionView!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        imageCollectionView.register(UINib(nibName: "CollectionCellWithImage", bundle: nil), forCellWithReuseIdentifier: "CollectionCellWithImage")
        
    }

}


extension InvoiceDetailsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: imageCollectionView.frame.width, height: imageCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCellWithImage", for: indexPath) as! CollectionCellWithImage
        return cell
    }
    
    
}
