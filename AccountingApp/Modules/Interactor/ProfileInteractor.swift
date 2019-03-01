//
//  ProfileInteractor.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//
import UIKit
import RxSwift
import CoreData
import ReusableFramework

class ProfileInteractor: PresentorToInterectorProtocol, APIRequest{
   
    var method: RequestType
    var path: String
    var parameters: Data?
    var headers: [String : String]
    var error = ""
    var context: AppDelegate
    
    init() {
        method = RequestType.POST
        let (userId, _) = UserHelper.companyID()
        path = LoginApis.logOutUser + "/\(userId)"
        parameters  = Data()
        headers = userId.getHeader()
        context = AppDelegate()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            context = appDelegate
        }
        
    }
    
    var presenter: InterectorToPresenterProtocol?
    
}


extension ProfileInteractor{
    
    func fetchData<T>(body: T){
        
        let forgotResponse: Observable<ProfileLogoutResponseEntity> = Network.shared.post(apiRequest: self)
        
        forgotResponse.subscribe(onNext: { (logoutResponse) in
            
            if logoutResponse.error == true{
                if let errorMessage = logoutResponse.message{
                    self.error = errorMessage
                }
            }
            
        }, onError: { [unowned self] (onError) in
            
            self.presenter?.dataFetchedFailed(error: onError.localizedDescription)
            
        }, onCompleted:  {
            
            if self.error == ""{
                self.removerPersisentData()
            }else{
                self.presenter?.dataFetchedFailed(error: self.error)
                self.error = ""
            }
            
        }) {
            
        }
        
    }
    
    
    func fetchData() {
        
        if let profileDetails = ProfileDatabase.fetchData(){
            createProfileEntity(profileDetails: profileDetails)
        }else{
            let profileDetails = ProfileEntity(image: "", name: ProfileConstants.profileName.rawValue, localImage: #imageLiteral(resourceName: "profilePlaceholder"), profileOption: getProfileOptions())
            self.presenter?.dataFetched(news: profileDetails)
        }
        
//        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//        }
//        
//        let request = NSFetchRequest<Profile>(entityName: "Profile")
//        do{
//            let profileData = try appdelegate.persistentContainer.viewContext.fetch(request)
//            if profileData.count > 0{
//                let profileDetails = profileData[0]
//                createProfileEntity(profileDetails: profileDetails)
//            }else{
//                let profileDetails = ProfileEntity(image: "", name: ProfileConstants.profileName.rawValue, localImage: #imageLiteral(resourceName: "profilePlaceholder"), profileOption: getProfileOptions())
//                self.presenter?.dataFetched(news: profileDetails)
//            }
//        }catch let databaseError{
//            
//        }
        
    }
}


extension ProfileInteractor{
    
    func createProfileEntity(profileDetails: Profile){
        
        guard let profileUrl = profileDetails.profileImage else {
            
            let profileDetails = ProfileEntity(image: "", name: profileDetails.name?.capitalized, localImage: #imageLiteral(resourceName: "profilePlaceholder"), profileOption: getProfileOptions())
            presenter?.dataFetched(news: profileDetails)
            return
        }
        
        let profileDetails = ProfileEntity(image: profileUrl, name: profileDetails.name?.capitalized, localImage: #imageLiteral(resourceName: "profilePlaceholder"), profileOption: getProfileOptions())
        presenter?.dataFetched(news: profileDetails)
        
    }
    
    func getProfileOptions() -> [ProfileOptionEntity] {
        
        return [
            ProfileOptionEntity(groupName: ProfileConstants.groups.rawValue, image: #imageLiteral(resourceName: "groups")),
            ProfileOptionEntity(groupName: ProfileConstants.notifications.rawValue, image: #imageLiteral(resourceName: "notification")),
            ProfileOptionEntity(groupName: ProfileConstants.settings.rawValue, image: #imageLiteral(resourceName: "settings")),
            ProfileOptionEntity(groupName: ProfileConstants.logout.rawValue, image: #imageLiteral(resourceName: "logout"))
        ]
    }
    
    func removerPersisentData(){
        UserHelper.deleteCredentials()
        ProfileDatabase.deleteData(entityName: "Profile", context: context)
        self.presenter?.dataFetched(news: "")
        
    }
}
