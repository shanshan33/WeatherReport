//
//  WeatherListAPI.swift
//  WeatherReports
//
//  Created by Shanshan Zhao on 07/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import Foundation

class WeatherAPI: BaseAPI {
    
    func fetchWeather(_ urlString: String, withCompletion completion: ((Result<WeatherResult>) -> Void)?) {
        request(urlString: urlString) { (result) -> Void? in
            completion?(result)
        }
    }
}
