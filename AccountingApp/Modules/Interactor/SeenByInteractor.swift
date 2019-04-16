//
//  SeenByInteractor.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 04/03/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation
import RxSwift
import ReusableFramework
class SeenByInteractor: PresentorToInterectorProtocol, APIRequest {
    var method: RequestType
    var path: String
    var parameters: Data?
    var headers: [String : String]
    var response: SeenByModel?
    init() {
        method = .GET
        path = GroupsControllerApi.getSeenBy
        headers = path.getHeader()
    }
    
    var presenter: InterectorToPresenterProtocol?
    func fetchData<T>(body: T) where T : Decodable, T : Encodable {
        if let seenBy = body as? SeenByRequest{
            path = path + "?commentId=\(seenBy.commentId)&subGroupId=\(seenBy.subGroupId)"
            getSeenBy()
        }
    }
    
    func fetchData() {
    }
    
    func getSeenBy(){
        let seenBy: Observable<SeenByModel> = Network.get(apiRequest: self)
        seenBy.subscribe(onNext: { (response) in
            self.response = response
        }, onError: { (error) in
            self.presenter?.dataFetchedFailed(error: error.localizedDescription)
        }, onCompleted: {
            if self.response?.error == true{
                self.presenter?.dataFetchedFailed(error: self.response?.message)
            }else{
                self.presenter?.dataFetched(news: self.response?.data?.result)
            }
        }) {
        }
    }
}



