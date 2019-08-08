//
//  APIHelper.swift
//  BookSearch
//
//  Created by Leo Wirasanto on 8/6/19.
//  Copyright © 2019 Leo. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class APIHelper: NSObject {
    static let instance = APIHelper()
    
    static let sessionManager: SessionManager = {
        
        let serverTrustPolicies: [String: ServerTrustPolicy] = [:]
        
        let configuration = URLSessionConfiguration.default
        let delegate = SessionDelegate()
        
        return Alamofire.SessionManager(serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
    }()
    
    override init() {
        super.init()
    }
    
    func getApi(params: Parameters?, endPoint: String, callback: @escaping(APIResult<JSON>)-> Void) { 
        
        let url = Constants.BASE_URL + endPoint
        
        APIHelper.sessionManager.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: [String: String]())
            .responseString{ response in
                if let value = response.result.value {
                    print("[js] Response String: \(value)")
                    
                    if let url = response.request?.url {
                        print("Request URL: \(url)")
                    }
                }
            }
            .responseJSON { (response) in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    callback(.success(json))
                case .failure(let error ):
                    callback(.failure(error as NSError))
                }
        }
    }
}
