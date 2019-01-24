//
//  CameraController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import UIKit
import Photos
import AVFoundation
import OpalImagePicker
import UPCarouselFlowLayout


class CameraController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var capturePreviewView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionCell()
        configureCameraController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func handleCapture(_ sender: Any) {
        
        camera.captureImage { (image, error) in
            
        }
        
    }
    
    
    @IBAction func handleGallery(_ sender: Any) {
        let imagePicker = OpalImagePickerController()
        imagePicker.imagePickerDelegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func handleFlash(_ sender: Any) {
        guard let flashButton = sender as? UIButton else { return }
        if flashButton.tag == 0{
            camera.flashMode = .on
            flashButton.tag = 1
            flashButton.setImage(#imageLiteral(resourceName: "flashOn"), for: .normal)
        }else{
            flashButton.tag = 0
            camera.flashMode = .off
            flashButton.setImage(#imageLiteral(resourceName: "flashOff"), for: .normal)
        }
    }
    
    @objc @IBAction func handleClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var seledtedImages = [CameraImages]()
    var presenter: ViewToPresenterProtocol?
    let camera = Camera()
    
}

extension CameraController: UICollectionViewDataSource{
    
    func configureCollectionCell(){
        if let layout = collectionView.collectionViewLayout as? UPCarouselFlowLayout{
            layout.spacingMode = .overlap(visibleOffset: UIScreen.main.bounds.width / 3)
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2, height: 200)
            layout.scrollDirection = .horizontal
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CameraControllerCell", for: indexPath) as! CameraControllerCell
        cell.cameraTypeLabel.text = [CameraType.single.rawValue, CameraType.multiple.rawValue, CameraType.combine.rawValue][indexPath.item]
        return cell
    }
    
}


// Camera setup

extension CameraController{
    
    
    func configureCameraController() {
        
        navigationController?.hideTranslucency()
        
        let downGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleClose(_:)))
        downGesture.direction = .down
        view.addGestureRecognizer(downGesture)
        
        
        camera.prepare {(error) in
            if let error = error {
                print(error)
            }
            
            try? self.camera.displayPreview(on: self.capturePreviewView)
        }
    }
}

extension CameraController: OpalImagePickerControllerDelegate{
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        
        dismiss(animated: true , completion: nil)
        
        images.forEach { (image) in
            self.seledtedImages.append(CameraImages(image: image))
        }
        
        let reviewController = CameraReviewRoutes.createModule() as? CameraReviewController
        reviewController?.images = seledtedImages
        navigationController?.pushViewController(reviewController ?? UIViewController(), animated: true)
        
    }
    
}



// Controller
extension CameraController: PresenterToViewProtocol {
    func showContent<T>(news: T) {
        
    }
    
    func showError<T>(error: T) {
        
    }
    
    
}


extension CameraController{
    
    public enum CameraType: String {
        case single = "SINGLE"
        case multiple = "MULTIPLE"
        case combine = "COMBINE"
    }
    
}
