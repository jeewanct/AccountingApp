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
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var projectView: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var cardView: CardView!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var pagerControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureCollectionCell()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func handleUpload(_ sender: Any) {
        uploadButton.addButtonIndicator()
        self.notInternetView()
    }
    
    @IBAction func handleZoom(_ sender: Any) {
        
    }
    
    @objc func handleProject(){
        let projectList = CustomPopup()
        projectList.frame = self.view.frame
        self.view.addSubview(projectList)
    }
    
    
    var selectProject: ButtonView!
    var titleForBill: TextFieldView!
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
        
        pagerControl.numberOfPages = 2
    }
}

extension CameraReviewController: UICollectionViewDataSource{
    
    func configureCollectionCell(){
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CameraReviewCell", for: indexPath)
        return cell
    }
}


extension CameraReviewController: UICollectionViewDelegate{
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let current = targetContentOffset.pointee.x / collectionView.frame.width
        pagerControl.currentPage = Int(current)
        
    }
}


extension CameraReviewController: PresenterToViewProtocol{
    
    func showContent<T>(news: T) {
        
        
        
    }
    
    func showError() {
        
    }
    
}
