//
//  Temperature.swift
//  InfoWeather
//
//  Created by Shanshan Zhao on 07/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import Foundation

public struct Temperature {
    let value: Double?
    let sol: Double?
}

extension Temperature {
    public init(sol:Double?, value: Double?) {
        self.sol = sol
        self.value = value
    }
}

extension Temperature: JSONInitializable {
    public enum Key: String {
        case sol  = "sol"
        case value = "2m"
    }
    
    public init(with json: JSON) throws {
        self.sol = Temperature.optionalValue(for: .sol, in: json)
        self.value = Temperature.optionalValue(for: .value, in: json)
    }
}
