//
//  GroupChatReplyCell.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 15/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout
class GroupChatReplyCell: UITableViewCell{
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postedDate: UILabel!
    
    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewHeightAnchor: NSLayoutConstraint!
    
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
        
        collectionView.register(UINib(nibName: "ImagePreviewCell", bundle: nil), forCellWithReuseIdentifier: "ImagePreviewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        configureCell()
        
        
    }
    
    func setData(){
        
        userImage.addImage(url: messageDetail?.userProfile)
        userName.text = messageDetail?.userName
        message.text = messageDetail?.comment
        //  seenBy.setTitle(messageDetail?.seenBy, for: .normal)
        //startConversation.setTitle(messageDetail?.startConversation, for: .normal)
        postedDate.text = messageDetail?.commentDate
        
        if messageDetail?.isCollectionHidden == true{
            collectionViewHeightAnchor.constant = 0
            //    pager.isHidden = true
        }else{
            collectionViewHeightAnchor.constant = UIScreen.main.bounds.width * 0.3
            //  pager.isHidden = false
        }
        
    }
}

extension GroupChatReplyCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func configureCell(){
        if let layout = collectionView.collectionViewLayout as? UPCarouselFlowLayout{
            layout.spacingMode = .overlap(visibleOffset: 8)
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
