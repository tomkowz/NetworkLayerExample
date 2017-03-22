//
//  UserShoppingOperation.swift
//  NetworkLayerExample
//
//  Created by Alessio Roberto on 05/03/2017.
//  Copyright © 2017 Tomasz Szulc. All rights reserved.
//

import Foundation

final class UserShoppingOperation: ServiceOperation {
    private let request: UserShoppingRequest
    
    public var success: (([ShoppItem]) -> Void)? = nil
    public var failure: ((NSError) -> Void)? = nil
    
    public init(uniqueId: String, service: BackendService? = nil) {
        request = UserShoppingRequest(uniqueId: uniqueId)
        super.init(service: service)
    }
    
    public override func start() {
        super.start()
        service.request(request, success: handleSuccess, failure: handleFailure)
    }
    
    private func handleSuccess(_ response: Any?) {
        do {
            let item = try UserShoppingResponseMapper.process(response)
            self.success?(item)
            self.finish()
        } catch {
            handleFailure(NSError.cannotParseResponse())
        }
    }
    
    private func handleFailure(_ error: NSError) {
        self.failure?(error)
        self.finish()
    }
}
