//
//  Networking.swift
//  AccountingApp
//
//  Created by JEEVAN TIWARI on 20/12/18.
//  Copyright © 2018 AccountingApp. All rights reserved.
//

import Foundation
import Alamofire

open class Networking: NSObject{
    
    public static let shared = Networking()
    
    open func getRequest<T: Decodable>(url: String, header: [String: String], completion: @escaping(T) -> Void, onError: @escaping(String) -> Void){
        
       
        
        
        guard let unwrappedUrl = URL(string: url) else {
            onError(NetworkError.invalidUrl.rawValue)
            return
        }
        
        var urlRequest = URLRequest(url: unwrappedUrl, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 200)
        urlRequest.allHTTPHeaderFields = header
        urlRequest.httpMethod = "GET"
        
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let jsonData = data{
                
                do{
                    let unwrappedData = try JSONDecoder().decode(T.self, from: jsonData)
                    
                    DispatchQueue.main.async {
                        completion(unwrappedData)
                    }
                    
                }catch let jsonUnwrappingError{
                    print("=============================In sdk json decoder error \(jsonUnwrappingError)")
                    onError(NetworkError.parsingError.rawValue)
                }
            }
            
            if let errorOccured = error{
                print("=============================In sdk network error\(errorOccured)")
                onError(errorOccured.localizedDescription)
            }
            
            
            }.resume()
        
        
    }
    
    open func postRequest<T: Decodable>(url: String, header: [String: String], data: Data, completion: @escaping(T) -> Void, onError: @escaping(String) -> Void){
        
      
        
        
        guard let unwrappedUrl = URL(string: url) else {
            onError(NetworkError.invalidUrl.rawValue)
            return
        }
        
        var urlRequest = URLRequest(url: unwrappedUrl, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 200)
        urlRequest.allHTTPHeaderFields = header
        urlRequest.httpBody = data
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        
//        Alamofire.request(urlRequest).responseJSON {
//            (response) in
//
//            switch response.result{
//            case .success(let value):
//
//                if let unwrappedData = response.data{
//                    do{
//                        let jsonData = try JSONDecoder().decode(T.self, from: unwrappedData)
//                        completion(jsonData)
//                    }catch let jsonParsingError{
//                        onError(NetworkError.parsingError.rawValue)
//                    }
//                }
//
//
//            case .failure(let error):
//                onError(error.localizedDescription)
//            }
//
//
//
//        }
        
        
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

            if let jsonData = data{

                do{
                    let unwrappedData = try JSONDecoder().decode(T.self, from: jsonData)

                    DispatchQueue.main.async {
                        completion(unwrappedData)
                    }

                }catch let jsonUnwrappingError{
                    print("=============================In sdk json decoder error \(jsonUnwrappingError)")
                    
                    DispatchQueue.main.async {
                        onError(NetworkError.parsingError.rawValue)
                    }
                    
                    
                    
                }
            }

            if let errorOccured = error{
                print("=============================In sdk network error\(errorOccured)")
                DispatchQueue.main.async {
                    onError(errorOccured.localizedDescription)
                }
                
            }


            }.resume()
        
        
        
    }
    
    
}


enum NetworkError: String{
    
    case noInternet = "You are offline."
    case invalidUrl = "Seems your url is invlaid."
    case parsingError = "Json Decoder fail to decode."
    
}


