//
//  UserShoppingRequest.swift
//  NetworkLayerExample
//
//  Created by Alessio Roberto on 05/03/2017.
//  Copyright © 2017 Tomasz Szulc. All rights reserved.
//

import Foundation

struct UserShoppingRequest: BackendAPIRequest {
    private let uniqueId: String
    
    init(uniqueId: String) {
        self.uniqueId = uniqueId
    }
    
    var endpoint: String {
        return "/shopping/\(uniqueId)"
    }
    
    var method: Method {
        return .get
    }
    
    var query: Query {
        return .path
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var headers: [String: String]? {
        return defaultJSONHeaders()
    }
}
