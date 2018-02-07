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
    let humidity: Humidity?
    let snowrisk: String?
}

extension Weather {
    public init(temperature:Temperature?, rain: Double?, humidity: Humidity?, snowrisk: String?) {
        self.temperature = temperature
        self.rain = rain
        self.humidity = humidity
        self.snowrisk = snowrisk
    }
}

extension Weather: JSONInitializable {
    public enum Key: String {
        case temperature  = "temperature"
        case rain = "pluie"
        case humidity = "humidite"
        case snowrisk = "risque_neige"
    }
    
    public init(with json: JSON) throws {
        self.temperature = try Weather.optionalValue(for: .temperature, in: json).flatMap(Temperature.init(with: ))
        self.humidity = try Weather.optionalValue(for: .humidity, in: json).flatMap(Humidity.init(with: ))
        self.rain = Weather.optionalValue(for: .rain, in: json)
        self.snowrisk = Weather.optionalValue(for: .snowrisk, in: json)
    }
}
