//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//___COPYRIGHT___
//

import Foundation

final class ___FILEBASENAMEASIDENTIFIER___: ResponseMapper<<#ParsedItem#>>, ResponseMapperProtocol {
    
    static func process(_ obj: AnyObject?) throws -> UserItem {
        return try process(obj, parse: { json in
            let object = json["object"] as? String
            
            if let object = object {
                return <#ParsedItem()#>
            }
            return nil
        })
    }
}
