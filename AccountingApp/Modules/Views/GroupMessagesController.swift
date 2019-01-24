//
//  GroupMessages.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 14/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit

class GroupMessagesController: UIViewController{
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var movingView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title  = "Group Chat"
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title  = ""
    }
    
    @IBAction func handleCreateConversation(_ sender: Any) {
        
        let conversation = ConversationRoute.createModule()
        navigationController?.pushViewController(conversation, animated: true)
    }
    
    @IBAction func handleAll(_ sender: Any) {
        collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .left, animated: true)
    }
    
    @IBAction func handleNew(_ sender: Any) {
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: true)
    }
    
    
    var messageParams: (String?, String?)?
    
    var presenter: ViewToPresenterProtocol?
}

extension GroupMessagesController{
    
    func setup(){
        
        if let (groupId, subGroupId) = messageParams{
            
            guard let unwrappedGroupId = groupId else { return }
            
            
            if let unwrappedSubGroupId = subGroupId{
                
            }else{
                addCreateSubGroupBarButton()
            }
            
        }
    }
    
    func addCreateSubGroupBarButton(){
        
        let createSubGroupButton = UIBarButtonItem(title: GroupMessageEnum.createSubGroup.rawValue, style: .plain, target: self, action: #selector(handleCreateSubGroup))
        navigationItem.rightBarButtonItem = createSubGroupButton
    }
    

}


extension GroupMessagesController{
    
    @objc func handleCreateSubGroup(){
        let createSubgroup = CreateSubGroupRoute.createModule()
        navigationController?.pushViewController(createSubgroup, animated: true)
    }
}


extension GroupMessagesController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
            self.movingView.transform = CGAffineTransform(translationX: scrollView.bounds.origin.x / 2, y: 0)
        }, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupMessageCollectionCell", for: indexPath) as! GroupMessageCollectionCell
        cell.delegate = self
        return cell
    }
}

extension GroupMessagesController: SelectedProjectDelegate{
    
    func startConversation(to section: Int) {
        let chat = GroupChatRoute.createModule()
        navigationController?.pushViewController(chat, animated: true)
    }
    
    
}


extension GroupMessagesController: PresenterToViewProtocol{
    
    func showContent<T>(news: T) {
        
    }
    
    func showError<T>(error: T) {
        
    }
    
}
