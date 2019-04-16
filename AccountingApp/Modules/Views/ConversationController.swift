//
//  ConversationController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 15/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout
import OpalImagePicker



class ConversationController: UIViewController{
    
    @IBOutlet var keyboardToolbar: UIToolbar!
    @IBOutlet weak var conversationText: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupDelegates()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "New Conversation"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       // conversationText.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
    }
    
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func handleSend(_ sender: Any) {
        checkFroEmpty()
    }
    
    @IBAction func handleCamera(_ sender: Any) {
        setupCamera()
    }
    
    @IBAction func handleGallery(_ sender: Any) {
        setupGallery()
    }
    
    var conversationEntity: CreateConversationEntity?
    var selectedImages = [UIImage]()
    let imagePicker = UIImagePickerController()
    var presenter: ViewToPresenterProtocol?
    
    
}

extension ConversationController{
    
    func setup(){
        
        imagePicker.delegate = self
        collectionView.register(UINib(nibName: "ConversationCell", bundle: nil), forCellWithReuseIdentifier: "ConversationCell")
        if let layout = collectionView.collectionViewLayout as? UPCarouselFlowLayout{
            layout.spacingMode = .overlap(visibleOffset: UIScreen.main.bounds.width * 0.1 )
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.7 , height: collectionView.frame.height)
            layout.scrollDirection = .horizontal
        }

        frowWhichScreen()
        
       
        
  
    }
    
    func frowWhichScreen(){
        
        if let fromScreen = conversationEntity{
            if let comment = fromScreen.comment{
                conversationText.text = comment
            }
            
        }else{
            conversationEntity = CreateConversationEntity(type: ConversationType.create.rawValue)
        }
        
    }
    
    
}


extension ConversationController: UITextViewDelegate{
    func setupDelegates(){
        conversationText.delegate = self
        conversationText.inputAccessoryView = keyboardToolbar
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
}


extension ConversationController: OpalImagePickerControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @objc func handleSend(){
        checkFroEmpty()
    }
    
    @objc func setupGallery(){
        let imagePicker = OpalImagePickerController()
        imagePicker.imagePickerDelegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func setupCamera(){
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImages.append(pickedImage)
            setupCollectionView()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        
        dismiss(animated: true, completion: nil)
        selectedImages.append(contentsOf: images)
        setupCollectionView()
        
    }
    
    func setupCollectionView(){
        if selectedImages.count > 0 {
            animate(to: view.frame.height * 0.17)
        }else{
            animate(to: -( view.frame.height * 0.17))
        }
        collectionView.reloadData()
        
    }
    
    func animate(to: CGFloat){
        UIView.animate(withDuration: 0.4) {
            self.collectionHeight.constant = to
            self.view.layoutIfNeeded()
        }
    }
    
    
    
}

extension ConversationController: ImageDeleteDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func deleteImage(at index: Int) {
        selectedImages.remove(at: index)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 20) / 2, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConversationCell", for: indexPath) as! ConversationCell
        cell.delegate = self
        cell.deleteButton.tag = indexPath.item
        cell.image.image = selectedImages[indexPath.item]
        return cell
    }
    
}

extension ConversationController{
    
    func checkFroEmpty(){
        if conversationText.text == CreateConversationEnum.startConversation.rawValue && selectedImages.count == 0{
            self.showAlert(message: CreateConversationEnum.emptyFields.rawValue)
        }else{
            callServer()
        }
    }
    
    func callServer(){
        if selectedImages.count  > 0{
            conversationEntity?.imageData = selectedImages.convertImageToData(images: selectedImages)
        }
        
        
        if conversationText.text != CreateConversationEnum.startConversation.rawValue{
             conversationEntity?.comment = conversationText.text
        }
       
        if let createConversation = conversationEntity{
            self.showDataIndicator()
            self.presenter?.updateView(body: createConversation)
        }
        
    }
    
}
extension ConversationController: PresenterToViewProtocol{

    
    func showContent<T>(news: T) {
        self.hideDataIndicator()
        
        if let data = news as? Bool{
            if data == true{
                self.showAlert(message: CreateConversationEnum.conversationFailed.rawValue)
            }else{
                let alertController = UIAlertController(title: "", message: CreateConversationEnum.conversationCreated.rawValue, preferredStyle: .actionSheet)
                let action = UIAlertAction(title: "Ok", style: .default) { (action) in
                    self.navigationController?.popViewController(animated: true)
                }
                alertController.addAction(action)
                present(alertController, animated: true, completion: nil)
            }
            
        }
        
    }
    
    func showError<T>(error: T) {
        self.hideDataIndicator()
        self.showAlert(message: error as? String ?? "" )
    }
    
}
