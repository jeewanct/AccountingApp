//
//  GroupChatController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 15/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit
import OpalImagePicker
import UPCarouselFlowLayout

class GroupChatController: UIViewController{
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var replyText: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
     @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    
    @IBOutlet weak var replyToToolBar: UIToolbar!
    @IBOutlet weak var replyToName: UILabel!
    @IBOutlet weak var replyToMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configure()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Group Chat"

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        replyText.delegate = self
      //  replyText.becomeFirstResponder()
    }
    
    @IBAction func handleSend(_ sender: Any) {
        replyToToolBar.isHidden = true
        checkFroEmpty()
        
    }
    
    @IBAction func handleGallery(_ sender: Any) {
        setupGallery()
        
    }
    @IBAction func handleCloseReply(_ sender: Any) {
        replyToToolBar.isHidden = true
    }
    
    var createChate: GroupChatRequestEntity?
    var conversationEntity: CreateConversationEntity?
    var groupMessage: GroupChatEntity?
    var selectedImages = [UIImage]()
    var sendMessageView: ReplyChatView!
    var presenter: ViewToPresenterProtocol?

}

extension GroupChatController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
}

extension GroupChatController: UITableViewDataSource, UITableViewDelegate {
    
    func configureTableView(){
        tableView.register(UINib(nibName: "GroupChatHeader", bundle: nil), forCellReuseIdentifier: "GroupChatHeader")
        tableView.register(UINib(nibName: "GroupChatReplyCell", bundle: nil), forCellReuseIdentifier: "GroupChatReplyCell")
    }
    
  
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return groupMessage?.replies?.count ?? 0
        }
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupChatHeader", for: indexPath) as! GroupChatHeader
            cell.messageDetail = groupMessage?.message
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupChatReplyCell", for: indexPath) as! GroupChatReplyCell
            cell.messageDetail = groupMessage?.replies?[indexPath.item]
            return cell
        }
    }
    
   
    
    
}

extension GroupChatController{
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1{
            return true
        }
        
        return false
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteButton = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            
            print("copy button tapped")
            
        }
        deleteButton.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
        //deleteButton.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "deleteProject"))
        
        
        let editButton = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            
            print("Access button tapped")
            
        }
        //editButton.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "editTask"))
        editButton.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
    
    
    let replyButton = UITableViewRowAction(style: .normal, title: "Reply") { action, index in
        
        print("Access button tapped")
        self.replyTo(at: indexPath)
        
    }
    
    replyButton.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.568627451, blue: 0.9568627451, alpha: 1)
    
    
        if groupMessage?.replies?[indexPath.item].isEditButtonEnable == true{
             return [deleteButton, editButton, replyButton]
        }
        
        
        return [ replyButton]
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
    }
    
    
    func replyTo(at: IndexPath){
        
        let chatInfo = groupMessage?.replies?[at.item]
        replyToToolBar.isHidden = false
        replyToName.text = chatInfo?.userName
        replyToMessage.text = chatInfo?.comment
        replyText.becomeFirstResponder()
        
    }


}

extension GroupChatController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ImageDeleteDelegate{
    
    
    func getData(){
        view.layoutIfNeeded()
        self.showDataIndicator()
        if let groupChat = groupMessage{
            presenter?.updateView(body: groupChat)
             //presenter?.updateView(body: groupChat)
        }
       
    }
    
    func configure(){
        collectionView.register(UINib(nibName: "ConversationCell", bundle: nil), forCellWithReuseIdentifier: "ConversationCell")
        
        if let layout = collectionView.collectionViewLayout as? UPCarouselFlowLayout{
            layout.spacingMode = .overlap(visibleOffset: UIScreen.main.bounds.width * 0.1 )
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.7 , height: collectionView.frame.height)
            layout.scrollDirection = .horizontal
        }
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
    
    func deleteImage(at index: Int) {
        selectedImages.remove(at: index)
        collectionView.reloadData()
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: (collectionView.frame.width - 20) / 2, height: collectionView.frame.height)
//    }
    
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
extension GroupChatController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, OpalImagePickerControllerDelegate{
    
    func setupGallery(){
        
        let ac = UIAlertController(title: EditContants.imageTitle.rawValue, message: "", preferredStyle: .actionSheet)
        
        let firstpOtion = UIAlertAction(title: EditContants.selectGallery.rawValue, style: .default) { (action) in
            self.handleCustomGallery()
        }
        
        let secondOption = UIAlertAction(title: EditContants.selectCamera.rawValue, style: .default) { (action) in
            self.handleCamera()
        }
        
        let cancelOption = UIAlertAction(title: EditContants.cancel.rawValue, style: .cancel, handler: nil)
        
        ac.addAction(firstpOtion)
        ac.addAction(secondOption)
        ac.addAction(cancelOption)
        present(ac, animated: true, completion: nil)
        
        
    }
    
    func handleCustomGallery(){
        let imagePicker = OpalImagePickerController()
        imagePicker.imagePickerDelegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func handleCamera(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        dismiss(animated: true, completion: nil)
        selectedImages.append(contentsOf: images)
        setupCollectionView()
       
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImages.append(pickedImage)
            setupCollectionView()
        }
        dismiss(animated: true, completion: nil)
        
    }
    
}


extension GroupChatController{
    
    func checkFroEmpty(){
        if replyText.text == "" && selectedImages.count == 0{
            self.showAlert(message: CreateConversationEnum.emptyFields.rawValue)
        }else{
            callServer()
        }
    }
    
    func callServer(){
        view.endEditing(true)
        if selectedImages.count  > 0{
            conversationEntity?.imageData = selectedImages.convertImageToData(images: selectedImages)
        }
        conversationEntity?.comment = replyText.text
        if let createConversation = conversationEntity{
            self.showDataIndicator()
            createConversation.parentCommentId = groupMessage?.message?.commentId ?? "0"
            self.presenter?.updateView(body: createConversation)
        }
        
    }
    
}

extension GroupChatController: PresenterToViewProtocol{
    
    func showContent<T>(news: T) {
        self.hideDataIndicator()
        
        if let data = news as? GroupResponseEntity{
            replyText.text = ""
            animate(to: 0)
            selectedImages.removeAll()
            collectionView.reloadData()
            groupMessage?.currentIndex = data.index
            groupMessage?.isMoreDataAvail = data.isMoreDataAvail ?? true
            groupMessage?.replies = data.messages
            tableView.reloadData()
        }
        
        if let (message, error) = news as? (String?, Bool?){
            self.showAlert(message: message!)
             replyText.text = ""
            animate(to: 0)
            selectedImages.removeAll()
            collectionView.reloadData()
            getData()
        }
        
    }
    
    func showError<T>(error: T) {
        self.hideDataIndicator()
        if let errorMessage = error as? String{
            self.showAlert(message: errorMessage)
        }
    }
    
}
