//
//  ProfileInteractor.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ProfileInteractor: PresentorToInterectorProtocol{
    
    var presenter: InterectorToPresenterProtocol?
    
    func fetchData<T>(body: T) where T : Decodable, T : Encodable {
        
    }
    
    
    func fetchData() {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let request = NSFetchRequest<Profile>(entityName: "Profile")
        do{
             let profileData = try appdelegate.persistentContainer.viewContext.fetch(request)
            if profileData.count > 0{
                let profileDetails = profileData[0]
                presenter?.dataFetched(news: profileDetails)
            }
        }catch let databaseError{
        }
        
    }
    
}
