//
//  CameraReviewController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 08/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit
import ReusableFramework
import UPCarouselFlowLayout


class CameraReviewController: UIViewController{
    
    @IBOutlet var keyboardToolBar: UIToolbar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var projectView: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var cardView: CardView!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var pagerControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionCell()
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupView()
        setupDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Review"

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
    }
    
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func handleUpload(_ sender: Any) {
        goToUploadScreen()
    }
    
    @IBAction func handleZoom(_ sender: Any) {
        let previewController = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "ImagePreviewController") as! ImagePreviewController
        previewController.images = images
        navigationController?.pushViewController(previewController, animated: true)
    }
    
    @objc func handleProject(){
       
        let customPopUp = InvoiceRoute.mainstoryboard.instantiateViewController(withIdentifier: "CustomPopUpController") as! CustomPopUpController
        customPopUp.projectList = projectList
        customPopUp.delegate = self
        customPopUp.modalTransitionStyle = .crossDissolve
        customPopUp.modalPresentationStyle = .overCurrentContext
        present(customPopUp, animated: true, completion: nil)
        
    }
    
    var images: [CameraImages]?
    var selectProject: ButtonView!
    var titleForBill: TextFieldView!
    var projectList: [CameraProjectUIEntity]?
    var presenter: ViewToPresenterProtocol?
}


extension CameraReviewController{
    func setupView(){
        
        selectProject = UIView.fromNib()
        titleForBill = UIView.fromNib()
        
        selectProject.infoLabel.text = CameraReviewControllerEnum.project.rawValue
        selectProject.selectButton.addTarget(self, action: #selector(handleProject), for: .touchUpInside)
        
        titleForBill.infoLabel.text = CameraReviewControllerEnum.mentionTitle.rawValue
        titleForBill.inputTextField.placeholder = CameraReviewControllerEnum.egElectricity.rawValue
        
        selectProject.frame = projectView.bounds
        titleForBill.frame = detailView.bounds
        
        projectView.addSubview(selectProject)
        detailView.addSubview(titleForBill)
        
        pagerControl.numberOfPages = images?.count ?? 0
        
        presenter?.updateView()
        selectProject.selectButton.addButtonIndicator()
    }
}


extension CameraReviewController: UITextFieldDelegate{
    
    func setupDelegates(){
        titleForBill.inputTextField.delegate = self
        titleForBill.inputTextField.inputAccessoryView = keyboardToolBar
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case titleForBill:
            view.endEditing(true)
        default:
            print("")
            //view.endEditing(true)
        }
        return false
    }
}


extension CameraReviewController: UICollectionViewDataSource{
    
    func configureCollectionCell(){
        
        pagerControl.numberOfPages = images?.count ?? 0
        
        if let layout = collectionView.collectionViewLayout as? UPCarouselFlowLayout{
            layout.spacingMode = .overlap(visibleOffset: 8)
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: collectionView.frame.height)
            layout.scrollDirection = .horizontal
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CameraReviewCell", for: indexPath) as! CameraReviewCell
        cell.image.image = images?[indexPath.item].image
        return cell
    }
}


extension CameraReviewController: UICollectionViewDelegate{
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if let layout = collectionView.collectionViewLayout as? UPCarouselFlowLayout{
            let current = targetContentOffset.pointee.x / layout.itemSize.width
            print(current)
            pagerControl.currentPage = Int(current) - 1
         
        }
        
        
        
    }
}

extension CameraReviewController: ProjectSelectedDelegate{
    
    @objc func handleRefreshProjectList(){
        presenter?.updateView()
    }
    
    
    func didSelectedProject(withName name: String?, andProjectId is: String?) {
        selectProject.selectButton.setTitle(name, for: .normal)
    }
    
    
    func goToUploadScreen(){
        
        if selectProject.selectButton.isEmpty{
            self.sheetStyleAlert(message: CameraErrorEnum.selectProject.rawValue)
        }else if titleForBill.inputTextField.isEmpty(){
            self.sheetStyleAlert(message: CameraErrorEnum.selectTitle.rawValue)
        }else{
            if Reachability.isConnectedToNetwork(){
                getInformationOfBills()
            }else{
                self.notInternetView()
            }
            
        }
    
        
    }
    
    func getInformationOfBills(){
        uploadButton.hideButtonIndicator(title: CameraEnum.upload.rawValue)
        uploadButton.showActvityIndicator()
        if let image = images{
            let imageData =  image.map { (value) -> Data in
                return value.imageData
            }
            self.presenter?.updateView(body: imageData)
            
        }
        
//        let upload = UploadInvoiceRoute.createModule()
//        self.navigationController?.pushViewController(upload, animated: true)
        
    }
    
    func goToserverUpload(){
        let uploadController = UploadInvoiceRoute.createModule()
        navigationController?.pushViewController(uploadController, animated: true)
    }

}

extension CameraReviewController: PresenterToViewProtocol{
    
    func showContent<T>(news: T) {
        selectProject.selectButton.hideButtonIndicator(title: CameraEnum.select.rawValue)
        selectProject.refreshButton.isHidden = true
        uploadButton.hideActivityIndicator(title: CameraEnum.upload.rawValue)
        if let list = news as? [CameraProjectUIEntity]{
            self.projectList = list
        }
        
        if let imageData = news as? [MultiAiModel] {
            goToserverUpload()
        }
    }
    
    func showError<T>(error: T) {
        selectProject.selectButton.hideButtonIndicator(title: CameraEnum.select.rawValue)
         uploadButton.hideActivityIndicator(title: CameraEnum.upload.rawValue)
        if let errorMessage = error as? String{
            self.sheetStyleAlert(message: errorMessage)
            selectProject.refreshButton.isHidden = false
            selectProject.refreshButton.addTarget(self, action: #selector(handleRefreshProjectList), for: .touchUpInside)
        }
    }
    
}
