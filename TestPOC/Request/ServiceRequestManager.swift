//
//  ServiceRequestManager.swift
//  TestPOC
//
//  Created by Praveen Kumar on 5/29/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD

public let factsEndPoint: String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
public typealias ResponseCompletionHandler = (_ error: NSError?, _ responseJSON: Data?) -> (Void)

class RequestManager {
    static let shared = RequestManager()
    
    private init() {}
    
    // MARK: - GET api call using Alamofire library

    func getFactsListData(controller: UIViewController?, endPointUrl: String?, completion: @escaping ResponseCompletionHandler) {
        if Connectivity.isConnectedToInternet {
            HUD.show(.progress)
            Alamofire.request(factsEndPoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseString
                { response in
                    switch response.result
                    {
                    case .failure(let error):
                            HUD.show(.error)
                            completion(error as NSError, nil)
                    case .success(let jsonResponse):
                        HUD.show(.success)
                        if let jsonData = jsonResponse.data(using: .utf8) {
                            completion(nil, jsonData)
                        }
                    }
            }
        } else {
            let connectiviyAlert = UIAlertController(title: "Alert", message: "Please check your internet connection.", preferredStyle: UIAlertController.Style.alert)
            connectiviyAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            controller?.present(connectiviyAlert, animated: true, completion: nil)
        }
    }
    
}
