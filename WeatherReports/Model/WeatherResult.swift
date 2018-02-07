//
//  WeatherResult.swift
//  InfoWeather
//
//  Created by Shanshan Zhao on 07/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import Foundation

public struct WeatherResult {
    let data: [String: Weather]?
    let request_key: String?
}

extension WeatherResult {
    init(request_key: String?, data: [String: Weather]?) {
        self.data = data
        self.request_key = request_key
    }
}

extension WeatherResult: JSONInitializable {
    public enum Key: String {
        case data = "data"
        case request_key = "request_key"
    }
    
    public init(with json: JSON) throws {
        var result: [String: Weather] = [:]
        var weathers: [Weather] = []
        var keys: [String] = []
        
        for case let result in json {
            if result.key.count == "yyyy-MM-dd HH:mm:ss".count {
                let weather = try Weather.init(with: result.value as! JSON)
                weathers.append(weather)
                keys.append(result.key)
            }
        }
        for (index, element) in keys.enumerated(){
            result[element] = weathers[index]
        }
        self.data = result
        self.request_key = WeatherResult.optionalValue(for: .request_key, in: json)
    }
}
