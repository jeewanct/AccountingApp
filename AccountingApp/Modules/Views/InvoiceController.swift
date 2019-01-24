//
//  InvoiceController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit

class InvoiceController: UIViewController{
   
    var presenter: ViewToPresenterProtocol?
    
    @IBOutlet weak var movingView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hideTranslucency()
        presenter?.updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Invoice"
        //navigationController?.navigationBar.prefersLargeTitles = false
        //tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
        //navigationController?.navigationBar.prefersLargeTitles = true
        //tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func scannedInvoice(_ sender: Any) {
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
    }
    
    
    @IBAction func pendingInvoice(_ sender: Any) {
        collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .right, animated: true)
    }
    
    var invoiceData: InvoiceEntity?
}

extension InvoiceController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
            self.movingView.transform = CGAffineTransform(translationX: scrollView.bounds.origin.x / 2, y: 0)
        }, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InvoiceCollectionCell", for: indexPath) as! InvoiceCollectionCell
        if indexPath.item == 0 {
             cell.invoiceList = invoiceData?.scannedInvoices
        }else{
             cell.invoiceList = invoiceData?.unscannedInvoices
        }
       
        cell.delegate = self
        return cell
    }

}

extension InvoiceController: CellClicked{
   
    func cellClicked<T>(data: T) {
        if let invoice = data as? Invoices{
            let invoiceDetails = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "InvoiceDetailsController") as! InvoiceDetailsController
            navigationController?.pushViewController(invoiceDetails, animated: true)
        }
    }

}

extension InvoiceController: PresenterToViewProtocol {
    
    func showContent<T>(news: T) {
        if let invoices = news as? InvoiceEntity{
            self.invoiceData = invoices
            collectionView.reloadData()
        }
    }
    
    func showError<T>(error: T) {
        if let errorMessage = error as? String{
            
            if errorMessage == ErrorCodeEnum.logout.rawValue{
                let alertController = UIAlertController(title: "", message: AlertMessage.sessionExpired.rawValue + UserHelper.nameOfUser() + "?", preferredStyle: .actionSheet)
                
                let okAction = UIAlertAction(title: AlertMessage.ok.rawValue, style: .default) { [unowned self] (action) in
                    UserHelper.logoutUser()
                    
                    DispatchQueue.main.async {
    
                        ChangeRootViewController.changeRootViewController(to: ChangeToControllerEnum.LoginController)
                    }
                    
                    
                }
            
               
                
                alertController.addAction(okAction)
               
                
                present(alertController, animated: true, completion: nil)
            }else{
                self.sheetStyleAlert(message: errorMessage)
            }
            
        }
    }
    
}
