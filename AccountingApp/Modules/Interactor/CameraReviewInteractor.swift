//
//  CameraReviewInteractor.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 14/01/19.
//  Copyright © 2019 AccountingApp. All rights reserved.
//

import Foundation
import RxSwift
import CoreData
import ReusableFramework


class CameraReviewInteractor: PresentorToInterectorProtocol, APIRequest, APIMultipartRequest{
    
    var multiFormData: MultipartEntity
    var url: String
    var method: RequestType
    var path: String
    var parameters: Data?
    var headers: [String : String]
    var appdelegate: AppDelegate
    var projectList: [CameraProjectListEntity]?
    
    init() {
        
        method = RequestType.GET
        let (userId, companyId) = UserHelper.companyID()
        path = ProjectApis.getProjectList + ProjectApis.userId + "\(userId)" + ProjectApis.companyId + "\(companyId)"
        parameters = Data()
        headers = path.getHeader()
        appdelegate = AppDelegate()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            appdelegate = appDelegate
        }
        
        url = CameraApis.uploadImages
        multiFormData = MultipartEntity(parameters: [:], imageData: [MultipartImageInfoEntity(imageData: Data(), withName: "")])
    }
    
    var presenter: InterectorToPresenterProtocol?
    
}


extension CameraReviewInteractor{
    
    func fetchData<T>(body: T) where T : Decodable, T : Encodable {
        
        method = RequestType.POST
        guard let imageData = body as? [Data] else {
            presenter?.dataFetchedFailed(error: ErrorCodeEnum.noImagesFound.rawValue)
            return
        }
        
        var arrayofImages = [MultipartImageInfoEntity]()
        
        for data in imageData{
            arrayofImages.append(MultipartImageInfoEntity(imageData: data, withName: "image"))
        }
        var invoiceInformation = [MultiAiModel]()
         var count = 0
        arrayofImages.map { (images)  in
            multiFormData.imageData = [images]
          
            let invoiceDetails: Observable<MultiAiModel> = Network.shared.multipartRequest(request: self)
            invoiceDetails.subscribe(onNext: { (response) in
                invoiceInformation.append(response)
            }, onError: { (error) in
                self.presenter?.dataFetchedFailed(error: error.localizedDescription)
            }, onCompleted: {
                if count == imageData.count - 1{
                    self.presenter?.dataFetched(news: invoiceInformation)
                 //   self.invoiceDetailsSave(list: invoiceInformation)
                }
                count = count + 1
            }, onDisposed: {
                
            })
        }
        
        
//       var observableData =  imageData.map { (imageData) -> Observable<MultiAiModel> in
//            headers = [:]
//            multiFormData.imageData = [MultipartImageInfoEntity(imageData: imageData, withName: "image")]
//            return Network.shared.multipartRequest(request: self)
//        }.map { (obserVable) -> MultiAiModel? in
//            var multiData = MultiAiModel()
//
//            obserVable.subscribe(onNext: { (value) in
//                return value
//            }, onError: { (error) in
//
//            }, onCompleted: {
//
//            }, onDisposed: {
//
//            })
//            return nil
//        }
        
        
      //  print(dump(observableData))
        
//        for observerable in observableData{
//
//            observerable.subscribe(onNext: { (values) in
//                print(values)
//            }, onError: { (error) in
//                print(error)
//            }, onCompleted: {
//
//            }) {
//
//            }
//
//        }
       
        
    
    }
    
    func invoiceDetailsSave(list:  [MultiAiModel]){
        print(list)
        
    }
    
    func fetchData() {
        
        method = RequestType.GET
        let projectList: Observable<CameraProjectEntity> = Network.get(apiRequest: self)
        
        projectList.subscribe(onNext: { (response) in
            self.projectList = response.data
        }, onError: { (error) in
            self.saveProjectList()
        }, onCompleted: {
            self.saveProjectList()
        }) {
            
        }
        
    }
    
    func saveProjectList(){
        
        if let list = projectList{
            
         let allProjectList = CamerReviewDatabase.saveToDatabase(appdelegate: appdelegate, projectLists: list)
            self.presenter?.dataFetched(news: allProjectList)
        }else{
            self.presenter?.dataFetchedFailed(error: AlertMessage.projectListFetchFailed.rawValue)
        }
        
    }
    
}
