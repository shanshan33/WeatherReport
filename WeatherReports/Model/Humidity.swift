//
//  Humidity.swift
//  WeatherReports
//
//  Created by Shanshan Zhao on 07/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import Foundation

public struct Humidity {
    var value: Double?
    
    public init(value: Double?) {
        self.value = value
    }
}

extension Humidity: JSONInitializable {
    public enum Key: String {
        case value = "2m"
    }
    
    public init(with json: JSON) throws {
        self.value = Humidity.optionalValue(for: .value, in: json)
    }
}
