//
//  GroupMessages.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 14/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import UIKit
import ReusableFramework



class GroupMessagesController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var movingView: UIView!
    @IBOutlet weak var noDataImage: UIImageView!
    @IBOutlet weak var allButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
        navigationItem.title  = "Group Chat"
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title  = ""
    }
    
    @IBAction func handleCreateConversation(_ sender: Any) {
        
        let conversation = ConversationRoute.createModule() as? ConversationController
        let conversationEntity = CreateConversationEntity(type: ConversationType.create.rawValue)
        conversationEntity.subGroupId = groupInformation.subGroupId
        conversationEntity.projectId = groupInformation.projectId
        
        conversation?.conversationEntity = conversationEntity
        navigationController?.pushViewController(conversation ??  ConversationRoute.createModule(), animated: true)
    
    }
    
    @IBAction func handleAll(_ sender: Any) {
    
        collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .left, animated: true)
        if let allButton = sender as? UIButton{
            if allButton.tag == 0 {
                allButton.tag = 1
                groupInformation.type = GroupMessageType.seen.rawValue
                getAllDataFromServer()
                
            }
        }
        
        
    }
    
    @IBAction func handleNew(_ sender: Any) {
    
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: true)
        getNewDataFromServer()
        
    }
    
    var groupList: [GroupUIEntity]?
    var groupInformation: GroupInformationEntity!
    var presenter: ViewToPresenterProtocol?
}

extension GroupMessagesController{
    
    func setup(){
        
        if groupInformation.groupType == GroupType.group.rawValue{
            addCreateSubGroupBarButton()
        }
        callServer()
        
    }
    
    func callServer(){
        if Reachability.isConnectedToNetwork(){
            showDataIndicator()
            if let groupMessage = groupInformation{
                self.presenter?.updateView(body: groupMessage)
            }
        }else{
            self.notInternetView()
        }
    }
    
    func addCreateSubGroupBarButton(){
        
        let createSubGroupButton = UIBarButtonItem(title: GroupMessageEnum.createSubGroup.rawValue, style: .plain, target: self, action: #selector(handleCreateSubGroup))
        navigationItem.rightBarButtonItem = createSubGroupButton
    }
    

}


extension GroupMessagesController{
    
    @objc func handleCreateSubGroup(){
        let createSubgroup = CreateSubGroupRoute.createModule() as?  CreateSubGrouController
        let subGroupInfo = SubGroupUIEntity(groupId: groupInformation.projectId, groupName: groupInformation.projectName)
        createSubgroup?.subGroupEntity = subGroupInfo
        navigationController?.pushViewController(createSubgroup ?? CreateSubGroupRoute.createModule() , animated: true)
    }
}


extension GroupMessagesController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseIn, animations: {
            self.movingView.transform = CGAffineTransform(translationX: scrollView.bounds.origin.x / 2, y: 0)
        }, completion: nil)
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if  Int(targetContentOffset.pointee.x / UIScreen.main.bounds.width) == 1{
            handleAll(allButton)
        }
        
        let pageNumber = Int(targetContentOffset.pointee.x / UIScreen.main.bounds.width)
        switch pageNumber{
        case 0:
            noDataImage.isHidden = groupList?[pageNumber].noData ?? false
        default:
             noDataImage.isHidden = groupList?[pageNumber].noData ?? false
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groupList?.count ?? 0
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupMessageCollectionCell", for: indexPath) as! GroupMessageCollectionCell
        //cell.delegate = self
        cell.cellNumber = indexPath.item
        cell.groupMessageInstance = self
        cell.groupMessage = groupList?[indexPath.item].groupChatList
        return cell
    }
}

extension GroupMessagesController: SelectedProjectDelegate{
    
    func startConversation(atSection: Int, atItem: Int) {
        let chat = GroupChatRoute.createModule() as? GroupChatController
        let groupchat = GroupChatEntity()
        groupchat.message = groupList?[atSection].groupChatList?[atItem]
        chat?.groupMessage  = groupchat
        
        let conversationEntity = CreateConversationEntity(projectId: groupInformation.projectId, subGroupId: groupInformation.subGroupId, comment: "", type: ConversationType.create.rawValue,parentComentId: groupList?[atSection].groupChatList?[atItem].commentId)
        conversationEntity.parentCommentId = groupList?[atSection].groupChatList?[atItem].commentId ?? "0"
        chat?.conversationEntity = conversationEntity
        
        navigationController?.pushViewController(chat ?? GroupChatRoute.createModule(), animated: true)
    }
    
    func deleteEditComment(atSection: Int, atItem: Int){
        
        let deleteGroupEntity = GroupMessageDeleteEntity(projectId: groupInformation.projectId, subGroupId: groupInformation.subGroupId, commentId: groupList?[atSection].groupChatList?[atItem].commentId)
        self.presenter?.updateView(body: deleteGroupEntity)
       // present(actionController, animated: true, completion: nil)
        
        
    }
    
    func editMessage(atSection: Int, atItem: Int){
    
        let conversation = ConversationRoute.createModule() as? ConversationController
        let editConversation  = CreateConversationEntity(projectId: groupInformation.projectId, subGroupId: groupInformation.subGroupId, comment: groupList?[atSection].groupChatList?[atItem].comment  , type: ConversationType.update.rawValue, parentComentId: "0")
        
        editConversation.imagePath  = groupList?[atSection].groupChatList?[atItem].imagesArray
        conversation?.conversationEntity = editConversation
        
        navigationController?.pushViewController(conversation ?? UIViewController(), animated: true)
 
    }
    
    func deleteMessage(atSection: Int, atItem: Int){
        //let alertController = uialer
        let deleteModel = GroupMessageDeleteEntity(projectId: groupInformation.projectId, subGroupId: groupInformation.subGroupId, commentId: groupList?[atSection].groupChatList?[atItem].commentId)
        presenter?.updateView(body: deleteModel)
    }
}

extension GroupMessagesController{
    
    func  getAllDataFromServer(){
        callServer()
    }
    
    func   getNewDataFromServer(){
        
    }
    
}


extension GroupMessagesController: PresenterToViewProtocol{
    
    func showContent<T>(news: T) {
        
        hideDataIndicator()
        if let groupListEntity = news as? GroupUIEntity{
            
            noDataImage.isHidden = groupListEntity.noData
            
            if groupInformation.type == GroupMessageType.unseen.rawValue{
                self.groupList = [groupListEntity, groupListEntity]
            }else{
                if let previousValue = groupList{
                    var finalGroupList = [GroupUIEntity]()
                    finalGroupList.append(previousValue[0])
                    finalGroupList.append(groupListEntity)
                    self.groupList = finalGroupList
                }
            }
            
            //self.groupList = groupListEntity
            collectionView.reloadData()
            
        }
        
        if let (message, error) = news as? (String?, Bool?){
            
            self.showAlert(message: message!)
             allButton.tag = 0
            self.handleNew("")
            callServer()
        
        }
        
    }
    
    func showError<T>(error: T) {
        hideDataIndicator()
    }
    
}
