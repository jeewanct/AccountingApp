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
    @IBOutlet weak var pager: UIPageControl!
   // var uploadInvoice: [MultiAiModel]!
    var invoice: UploadAiModel?
    var uploadInvoice: UploadInvoiceEntity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
        navigationItem.title = UploadInvoiceEnum.title.rawValue
        collectionView.layoutIfNeeded()
        collectionView.reloadData()
        pager.numberOfPages = invoice?.aiData?.count ?? 0
    }
    
    @IBAction func handleSubmit(_ sender: Any) {
        uploadInvoice.invoiceDetails = invoice?.aiData
        presenter?.updateView(body: uploadInvoice)
    }

    var presenter: ViewToPresenterProtocol?
}

extension UploadInvoiceController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / (UIScreen.main.bounds.width - 64))
        pager.currentPage = pageNumber
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 64, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return invoice?.aiData?.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UploadInvoiceEnum.uploadAiToServerCell.rawValue, for: indexPath) as! UploadAiToServerCell
        cell.section = indexPath.item
        cell.parentInstance = self
        cell.uploadInvoice = invoice?.aiData?[indexPath.item]
        return cell
    }
    
}

extension UploadInvoiceController: PresenterToViewProtocol{
    
    func showContent<T>(news: T) {
        if let data = news as? String{
            let actionController = UIAlertController(title: "", message: data, preferredStyle: .actionSheet)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            actionController.addAction(okAction)
            self.present(actionController, animated: true, completion: nil)
        }
    }
    
    func showError<T>(error: T) {
        if let getError = error as? String{
            self.showAlert(message: getError)
        }
    }
    
}
