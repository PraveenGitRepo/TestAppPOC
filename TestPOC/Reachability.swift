//
//  Reachability.swift
//  TestPOC
//
//  Created by Praveen Kumar on 5/23/19.
//  Copyright © 2019 Praveen. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
