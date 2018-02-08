//
//  WeatherDetailViewModel.swift
//  WeatherReports
//
//  Created by Shanshan Zhao on 08/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import Foundation

class WeatherDetailsViewModel {
    
    var humidity: Double?
    var rainPossible: String?
    var snowrisk: String?
    var temperature: String?
    
    convenience init(humidity: Double?, rainPossible: String?, snowrisk: String?, temperature: String?) {
        self.init()
        self.rainPossible = rainPossible
        self.temperature = temperature
        self.humidity = humidity
        self.snowrisk = snowrisk
    }
}
