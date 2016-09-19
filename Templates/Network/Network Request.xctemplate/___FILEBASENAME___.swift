//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

import Foundation

class ___FILEBASENAMEASIDENTIFIER___: BackendAPIRequest {
    
    // Create private variables for parameters required for request
//    private let email: String
//    private let password: String
    
//    init(email: String, password: String) {
//        self.email = email
//        self.password = password
//    }
    
    var endpoint: String {
        return <#String#>
    }
    
    var method: NetworkService.Method {
        return <#NetworkService.Method#>
    }
    
    var query: NetworkService.QueryType {
        return <#NetworkService.QueryType#>
    }
    
    var parameters: [String : Any]? {
        return [
//            "email": email,
//            "password": password
        ]
    }
    
    var headers: [String : String]? {
        return defaultJSONHeaders()
    }
}
