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
    func startConversation(to section: Int)
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
    
    
    var selectedMessage: Int?
    var delegate: SelectedProjectDelegate?
    
    
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
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        startConversation.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
        
    }
    
    @IBAction func handleSeenBy(_ sender: Any) {
    }
    
    @IBAction func handleStartConv(_ sender: Any) {
        if let selected = selectedMessage{
            delegate?.startConversation(to: selected)
        }
        
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagePreviewCell", for: indexPath) as! ImagePreviewCell
        return cell
    }
    
}
