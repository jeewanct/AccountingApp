//
//  GroupMessageCollectionCell.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 14/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class GroupMessageCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var tableView: UITableView!
    //var delegate: SelectedProjectDelegate?
    weak var groupMessageInstance: GroupMessagesController?
    var cellNumber: Int!
    var groupMessage: [GroupDetailEntity]?{
        didSet{
            tableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "GroupMessageCell", bundle: nil), forCellReuseIdentifier: "GroupMessageCell")
    }
    
}


extension GroupMessageCollectionCell: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessage?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupMessageCell", for: indexPath) as! GroupMessageCell
        cell.collectionIndex = cellNumber
        cell.groupMessageInstance = groupMessageInstance
        cell.selectedMessage = indexPath.item
        cell.messageDetail = groupMessage?[indexPath.item]
        return cell
    }
    
}


extension GroupMessageCollectionCell: UITableViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard let indexNumber = cellNumber else {
            return
        }
        
        if groupMessageInstance?.groupList?[indexNumber].isMoreDataAvail == true{
            if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && groupMessageInstance?.groupList?[indexNumber].isLoadingList == false){
                //self. isLoadingList = true
               // self. loadMoreItemsForList()
                if indexNumber == 0 {
                    groupMessageInstance?.getNewDataFromServer()
                }else{
                    groupMessageInstance?.getAllDataFromServer()
                }
                
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


//extension GroupMessageCollectionCell: SelectedProjectDelegate{
//    
////    func startConversation(to section: Int) {
////        delegate?.startConversation(to: section)
////    }
//    
//}
