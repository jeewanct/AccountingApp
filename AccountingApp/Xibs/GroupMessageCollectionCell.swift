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
    var delegate: SelectedProjectDelegate?
    
    
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupMessageCell", for: indexPath) as! GroupMessageCell
        cell.delegate = self
        cell.selectedMessage = indexPath.item
        return cell
    }
    
}


extension GroupMessageCollectionCell: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


extension GroupMessageCollectionCell: SelectedProjectDelegate{
    
    func startConversation(to section: Int) {
        delegate?.startConversation(to: section)
    }
    
}
