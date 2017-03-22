//
//  String+Encode.swift
//  NetworkLayerExample
//
//  Created by Alessio Roberto on 01/03/2017.
//  Copyright © 2017 Tomasz Szulc. All rights reserved.
//

import Foundation

extension String {
    func htmlContentToString() -> String {
        return self.replacingOccurrences(of:"<[^>]+>", with: "" , options: .regularExpression, range: nil).trimmingCharacters(in: .whitespaces)
    }
    
    func encode() -> String {
        let customAllowedSet =  CharacterSet(charactersIn: "+\"#%/<>?@\\^`{|}").inverted
        if let encodedString = self.addingPercentEncoding(withAllowedCharacters: customAllowedSet) {
            return encodedString
        }
        return self
    }
}
