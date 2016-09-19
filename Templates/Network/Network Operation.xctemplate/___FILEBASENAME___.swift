//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

import Foundation

public class ___FILEBASENAMEASIDENTIFIER___: ServiceOperation {
    
    private let request: <#BackendAPIRequest#>
    
    public var success: ((UserItem) -> Void)?
    public var failure: ((NSError) -> Void)?
    
//    public init(email: String, password: String) {
//        request = <#BackendAPIRequest()#>
//        super.init()
//    }
    
    public override func start() {
        super.start()
        service.request(request, success: handleSuccess, failure: handleFailure)
    }
    
    private func handleSuccess(_ response: AnyObject?) {
        do {
            let item = try SignInResponseMapper.process(response)
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

