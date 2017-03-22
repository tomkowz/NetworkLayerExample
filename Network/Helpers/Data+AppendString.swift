//
//  Data+AppendString.swift
//  NetworkLayerExample
//
//  Created by Alessio Roberto on 02/03/2017.
//  Copyright © 2017 Tomasz Szulc. All rights reserved.
//

import Foundation

extension Data {
    /// Append string to NSMutableData
    /// Rather than littering my code with calls to `dataUsingEncoding` to convert strings to NSData, and then add that data to the NSMutableData,
    /// this wraps it in a nice convenient little extension to NSMutableData.
    /// This converts using UTF-8.
    ///
    /// - Parameter string: The string to be added to the `NSMutableData`.
    mutating func append(string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
