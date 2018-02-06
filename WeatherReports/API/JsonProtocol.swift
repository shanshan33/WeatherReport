//
//  JsonProtocol.swift
//  WeatherReports
//
//  Created by Shanshan Zhao on 07/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import Foundation
/**
 *  A 'JSONInitializable' protocol
 *  This was inspired by Rajiv JhoomucK & Rob Napier
 *  https://medium.com/@jhoomuck/consuming-json-in-swift-sans-cocoapods-part-2-11ed52f4e05d
 */

public typealias JSON = [String:Any]

public enum JSONInitializableError: Error {
    case initializationError(key: String)
}

public protocol JSONInitializable {
    associatedtype Key: RawRepresentable
    init(with json: JSON) throws
}

public extension JSONInitializable where Key.RawValue == String {
    static func value<T>(for jsonKey: Key, in jsonObject: JSON) throws -> T {
        guard let value = jsonObject[jsonKey.rawValue] as? T else {
            throw JSONInitializableError.initializationError(key: jsonKey.rawValue)
        }
        return value
    }
    
    static func optionalValue<T>(for jsonKey: Key, in jsonObject: JSON) -> T? {
        return try? value(for: jsonKey, in: jsonObject)
    }
}
