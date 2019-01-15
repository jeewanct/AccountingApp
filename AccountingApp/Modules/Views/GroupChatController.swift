//
//  GroupChatController.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 15/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class GroupChatController: UICollectionViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Group Chat"

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    var presenter: ViewToPresenterProtocol?

}

extension GroupChatController: UICollectionViewDelegateFlowLayout {
    
    func configureCollectionView(){
        collectionView.register(UINib(nibName: "GroupChatHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "GroupChatHeader")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "GroupChatHeader", for: indexPath)
        return header
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupChatCell", for: indexPath)
        return cell
    }
    
   
    
    
}



extension GroupChatController: PresenterToViewProtocol{
    
    func showContent<T>(news: T) {
        
    }
    
    func showError() {
        
    }
    
}
