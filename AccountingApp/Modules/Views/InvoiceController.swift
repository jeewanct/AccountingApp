//
//  InvoiceController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit

enum InvoiceType{
    case scanned
    case unscanned
}

class InvoiceController: UIViewController{
   
    var presenter: ViewToPresenterProtocol?
    
    @IBOutlet weak var movingView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var reloadBtn: UIBarButtonItem!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Invoice"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
    }
    
    @IBAction func scannedInvoice(_ sender: Any) {
        showingInvoice = InvoiceType.scanned
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
    }
    
    
    @IBAction func pendingInvoice(_ sender: Any) {
        showingInvoice = InvoiceType.unscanned
        collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .right, animated: true)
    }
    
    @IBAction func handleCalendar(_ sender: Any) {
        openCalendar()
    }
    
    
    @IBAction func handleReload(_ sender: Any) {
        view.endEditing(true)
        getData()
        
    }
    
    var searchController: UISearchController!
    var showingInvoice = InvoiceType.scanned
    var invoiceData: InvoiceEntity?
}

extension InvoiceController{
    func configure(){
        self.navigationController?.hideTranslucency()
        navigationController?.navigationBar.prefersLargeTitles = false
        searchController = UISearchController(searchResultsController: nil)
        //searchController.searchBar.delegate = self
        //navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = InvoiceContants.searchInvoice.rawValue
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func openCalendar(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TaskCalendar") as! TaskCalendar
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .overCurrentContext
        let (startDate, endDate) = Helper.returnCalendarDates()
        vc.projectStartingDate = startDate
        vc.projectEndingDate = endDate
        vc.startDate = Date()
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
        vc.dateLabel.isHidden = true
    }
    
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
             cell.invoiceList = invoiceData?.searchScannedInvoice
        }else{
             cell.invoiceList = invoiceData?.searchUnscannedInvoice
        }
       
        cell.delegate = self
        return cell
    }

}

extension InvoiceController: UISearchResultsUpdating, CalendarDatesDelegate{
    
    
    func setCalendarDates(startDate: Date?, endDate: Date?) {
        let calendar = Calendar.current
        let date = Date()
        
        if showingInvoice == .scanned{
            invoiceData?.searchScannedInvoice =  invoiceData?.scannedInvoices.filter({ (hotel) -> Bool in
                return calendar.isDate(hotel.serverDate ?? Date(), inSameDayAs: startDate ?? Date())
            }) ?? [InvoiceDetailEntity]()
        }else{
            
            invoiceData?.searchUnscannedInvoice =   invoiceData?.scannedInvoices.filter({ (hotel) -> Bool in
                 return calendar.isDate(hotel.serverDate ?? Date(), inSameDayAs: startDate ?? Date())
            }) ?? [InvoiceDetailEntity]()
            
        }
        collectionView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    func getData(){
        reloadBtn.isEnabled = false
        presenter?.updateView()
    }
    
    func dataFetched(){
        reloadBtn.isEnabled = true
    }
    
}



extension InvoiceController: CellClicked{
   
    func cellClicked<T>(data: T) {
        if let invoice = data as? [InvoiceDescription]{
            let invoiceDetails =  InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "InvoiceDetailsController") as! InvoiceDetailsController
            invoiceDetails.invoiceDetail = InvoiceDetailsEntity(details: invoice)
            navigationController?.pushViewController(invoiceDetails, animated: true)
        }
    }
    
    // MARK: - Private instance methods
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        if showingInvoice == .scanned{
            invoiceData?.searchScannedInvoice = searchBarIsEmpty() ? invoiceData?.scannedInvoices ?? [InvoiceDetailEntity]() : invoiceData?.scannedInvoices.filter({ (hotel) -> Bool in
                return hotel.projectName?.range(of: searchText, options: .caseInsensitive) != nil
            }) ?? [InvoiceDetailEntity]()
        }else{
            
            invoiceData?.searchUnscannedInvoice = searchBarIsEmpty() ? invoiceData?.unscannedInvoices ?? [InvoiceDetailEntity]() : invoiceData?.scannedInvoices.filter({ (hotel) -> Bool in
                return hotel.projectName?.range(of: searchText, options: .caseInsensitive) != nil
            }) ?? [InvoiceDetailEntity]()
            
        }
        collectionView.reloadData()
    }
    
    

}

extension InvoiceController: PresenterToViewProtocol {
    
    func showContent<T>(news: T) {
        dataFetched()
        if let invoices = news as? InvoiceEntity{
            self.invoiceData = invoices
            collectionView.reloadData()
        }
    }
    
    func showError<T>(error: T) {
        dataFetched()
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
