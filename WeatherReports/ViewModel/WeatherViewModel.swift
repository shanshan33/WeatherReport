//
//  WeatherViewModel.swift
//  InfoWeather
//
//  Created by Shanshan Zhao on 07/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class WeatherViewModel {
    
    let weatherAPI = WeatherAPI()
    
    func fetchWeatherInfos(_ urlString: String, completionHandler: @escaping (_ reports: [Report]?, _ error: Error?) -> Void) {
        var reports: [Report]? = nil
        weatherAPI.fetchWeather(urlString, withCompletion: { [weak self] (result, error) in
            switch result {
            case.success (let fetchResult):
                guard let weatherInfos = fetchResult.data else { return }
                PersistenceService.clean()
                
                for weatherInfo in weatherInfos {
                    guard let timeStamp = self?.formateDateString(string: weatherInfo.key),
                        let date = self?.stringToDate(string: weatherInfo.key) as NSDate?,
                        let temp = self?.tempToCelsius(kelvin: weatherInfo.value.temperature?.value),
                        let rain = self?.rainPossibleText(num: weatherInfo.value.rain),
                        let humidity = weatherInfo.value.humidity?.value,
                        let snowrick = weatherInfo.value.snowrisk else { return }

                    PersistenceService.saveObject(timeStamp: timeStamp, date: date, humidity: humidity, rainPossible: rain, snowrisk: snowrick, temperature: temp)
                    reports = PersistenceService.fetchAndSortReports()
                }
                completionHandler(reports, nil)
            case.failure(let error):
                guard let offlineReport = PersistenceService.fetchAndSortReports() else { return }
                completionHandler(offlineReport, error?.localizedDescription as? Error)
            }
        })
    }
    
    private func tempToCelsius(kelvin: Double?) -> String? {
        guard let kelvin = kelvin else { return nil }
        let celsius = kelvin - 273.16
        return String(format: "%.0f°", celsius)
    }

    private func formateDateString(string: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: string) else { return nil }
        dateFormatter.dateFormat = "EEEE, MMM d "
        return dateFormatter.string(from: date)
    }
    
    private func stringToDate(string: String) -> Date {
        var date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let newDate = dateFormatter.date(from: string) {
            date = newDate
        }
        return date
    }
    
    private func rainPossibleText(num: Double?) -> String? {
        guard let num = num else { return nil }
        if num == 0.0 {
            return "Pas de pluie"
        } else {
            return "\(num * 100) % precipitation"
        }
    }
}



