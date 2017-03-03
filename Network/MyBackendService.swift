//
//  MyBackendService.swift
//  NetworkLayerExample
//
//  Created by Alessio Roberto on 03/03/2017.
//  Copyright © 2017 Tomasz Szulc. All rights reserved.
//

import Foundation

public let DidPerformUnauthorizedOperation = "DidPerformUnauthorizedOperation"

public class MyBackendService: BackendService {
    
    private let conf: BackendConfiguration
    private let service = NetworkService()
    
    init(_ conf: BackendConfiguration) {
        self.conf = conf
    }
    
    public func request(_ request: BackendAPIRequest,
                        success: ((Any?) -> Void)? = nil,
                        failure: ((NSError) -> Void)? = nil) {
        
        let url = conf.baseURL.appendingPathComponent(request.endpoint)
        
        let headers = request.headers
        // Set authentication token if available.
        //        headers?["X-Api-Auth-Token"] = BackendAuth.shared.token
        
        service.makeRequest(for: url, method: request.method, query: request.query, params: request.parameters, headers: headers, success: { data in
            var json: Any? = nil
            if let data = data {
                json = try? JSONSerialization.jsonObject(with: data as Data, options: [])
            }
            success?(json)
            
        }, failure: { data, error, statusCode in
            if statusCode == 401 {
                // Operation not authorized
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: DidPerformUnauthorizedOperation), object: nil)
                return
            }
            
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data as Data, options: []) as AnyObject
                let info = [
                    NSLocalizedDescriptionKey: json?["error"] as? String ?? "",
                    NSLocalizedFailureReasonErrorKey: "Probably not allowed action."
                ]
                let error = NSError(domain: "BackendService", code: 0, userInfo: info)
                failure?(error)
            } else {
                failure?(error ?? NSError(domain: "BackendService", code: 0, userInfo: nil))
            }
        })
    }
    
    public func cancel() {
        service.cancel()
    }
}
