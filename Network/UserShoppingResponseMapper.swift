//
//  UserShoppingResponseMapper.swift
//  NetworkLayerExample
//
//  Created by Alessio Roberto on 05/03/2017.
//  Copyright © 2017 Tomasz Szulc. All rights reserved.
//

import Foundation

final class UserShoppingResponseMapper: ArrayResponseMapper<ShoppItem>, ResponseMapperProtocol {
    static func process(_ obj: Any?) throws -> [ShoppItem] {
        
        return try process(obj, mapper: { (jsonData) -> ShoppItem in
            let json = jsonData as AnyObject
            let uniqueId = json["unique_id"] as? String
            let name = json["name"] as? String
            let price = json["price"] as? Double
            
            if let uniqueId = uniqueId, let name = name, let price = price {
                return ShoppItem(uniqueId: uniqueId, name: name, price: price)
            } else {
                throw ResponseMapperError.missingAttribute
            }
        })
    }
}
