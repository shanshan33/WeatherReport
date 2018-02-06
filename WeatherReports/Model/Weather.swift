//
//  Weather.swift
//  InfoWeather
//
//  Created by Shanshan Zhao on 07/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import Foundation

public struct Weather {
    let rain:  Double?
    let temperature: Temperature?
}

extension Weather {
    public init(temperature:Temperature?, rain: Double?) {
        self.temperature = temperature
        self.rain = rain
    }
}

extension Weather: JSONInitializable {
    public enum Key: String {
        case temperature  = "temperature"
        case rain = "pluie"
    }
    
    public init(with json: JSON) throws {
        self.temperature = try Weather.optionalValue(for: .temperature, in: json).flatMap(Temperature.init(with: ))
        self.rain = Weather.optionalValue(for: .rain, in: json)
    }
}
