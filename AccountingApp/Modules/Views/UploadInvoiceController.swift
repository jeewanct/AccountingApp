//
//  UploadInvoiceController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 21/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class UploadInvoiceController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = UploadInvoiceEnum.title.rawValue
    }
    
    var presenter: ViewToPresenterProtocol?
}

extension UploadInvoiceController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UploadInvoiceEnum.uploadAiToServerCell.rawValue, for: indexPath)
        return cell
    }
    
    
}

extension UploadInvoiceController: PresenterToViewProtocol{
    
    func showContent<T>(news: T) {
        
    }
    
    func showError<T>(error: T) {
        
    }
    
}
