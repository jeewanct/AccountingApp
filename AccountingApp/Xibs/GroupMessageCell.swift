//
//  GroupMessageCell.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 14/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

protocol SelectedProjectDelegate: class {
    func startConversation(atSection: Int, atItem: Int)
}


class GroupMessageCell: UITableViewCell{
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postedDate: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var seenBy: UIButton!
    @IBOutlet weak var startConversation: UIButton!
    @IBOutlet weak var pager: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightAnchor: NSLayoutConstraint!
    @IBOutlet weak var moreButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var selectedMessage: Int?
    var collectionIndex: Int!
    
    weak var groupMessageInstance: GroupMessagesController?
   // var delegate: SelectedProjectDelegate?
    var messageDetail: GroupDetailEntity?{
        didSet{
            setData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup(){
        activityIndicator.isHidden = true
        collectionView.register(UINib(nibName: "ImagePreviewCell", bundle: nil), forCellWithReuseIdentifier: "ImagePreviewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        configureCell()
        
        
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        startConversation.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
    }
    
    @IBAction func handleSeenBy(_ sender: Any) {
        
        
    }
    
    @IBAction func handleStartConv(_ sender: Any) {
//        if let selected = selectedMessage{
//            groupMessageInstance?.startConversation(to: selected)
//        }
//
        if let atSection = collectionIndex, let row = selectedMessage{
            groupMessageInstance?.startConversation(atSection: atSection, atItem: row)
        }
    }
    
    
    @IBAction func handleMore(_ sender: Any) {
       
        let actionController = UIAlertController(title: GroupMessageEnum.warning.rawValue, message: GroupMessageEnum.title.rawValue, preferredStyle: .actionSheet)
        
        let editAction = UIAlertAction(title: GroupMessageEnum.edit.rawValue, style: .default) { (action) in
            if let atSection = self.collectionIndex, let row = self.selectedMessage{
                self.groupMessageInstance?.editMessage(atSection: atSection, atItem: row)
                
            }
            //self.editMessage(atSection: atSection, atItem: atItem)
        }
        
        let deleteAction = UIAlertAction(title: GroupMessageEnum.delete.rawValue, style: .default) { (action) in
            if let atSection = self.collectionIndex, let row = self.selectedMessage{
                self.groupMessageInstance?.deleteMessage(atSection: atSection, atItem: row)
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            }
            //self.deleteMessage(atSection: atSection, atItem: atItem)
        }
        
        let cancelAction = UIAlertAction(title: GroupMessageEnum.cancel.rawValue, style: .cancel, handler: nil)
        
        actionController.addAction(editAction)
        actionController.addAction(deleteAction)
        actionController.addAction(cancelAction)
        groupMessageInstance?.present(actionController, animated: true, completion: nil)
    
    }
    
    
}

extension GroupMessageCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func configureCell(){
        if let layout = collectionView.collectionViewLayout as? UPCarouselFlowLayout{
            layout.spacingMode = .overlap(visibleOffset: 0)
            layout.itemSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
            layout.scrollDirection = .horizontal
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messageDetail?.imagesArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagePreviewCell", for: indexPath) as! ImagePreviewCell
        cell.imageView.addImage(url: messageDetail?.imagesArray?[indexPath.item])
        return cell
    }
    
}


extension GroupMessageCell{
    
    func setData(){
        
        userImage.addImage(url: messageDetail?.userProfile)
        userName.text = messageDetail?.userName
        message.text = messageDetail?.comment
        seenBy.setTitle(messageDetail?.seenBy, for: .normal)
        startConversation.setTitle(messageDetail?.startConversation, for: .normal)
        postedDate.text = messageDetail?.commentDate
        
        if messageDetail?.isCollectionHidden == true{
            collectionViewHeightAnchor.constant = 0
            pager.isHidden = true
        }else{
            collectionViewHeightAnchor.constant = UIScreen.main.bounds.width * 0.3
            pager.isHidden = false
        }
        
        if let count = messageDetail?.imagesArray?.count{
            pager.numberOfPages = count
        }
        
        if let moreButtonHidden = messageDetail?.isEditButtonEnable{
            moreButton.isHidden = moreButtonHidden
        }
        
    }
    
    
}
