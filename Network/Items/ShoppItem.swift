//
//  ShoppItem.swift
//  NetworkLayerExample
//
//  Created by Alessio Roberto on 05/03/2017.
//  Copyright © 2017 Tomasz Szulc. All rights reserved.
//

import Foundation

struct ShoppItem: ParsedItem {
    let uniqueId: String
    let name: String
    let price: Double
    
    init(uniqueId: String, name: String, price: Double) {
        self.uniqueId = uniqueId
        self.name = name
        self.price = price
    }
}
