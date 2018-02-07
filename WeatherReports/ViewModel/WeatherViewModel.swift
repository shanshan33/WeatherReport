//
//  WeatherViewModel.swift
//  InfoWeather
//
//  Created by Shanshan Zhao on 07/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import Foundation
import UIKit

class WeatherViewModel {
    
    let weatherAPI = WeatherAPI()
    var timeStamp: String?
    var date: Date?
    var rainPossible: String?
    var temperature: Double?
    
    convenience init(timeStamp: String?, rainPossible: String?, temperature: Double?, date: Date?) {
        self.init()
        self.timeStamp = timeStamp
        self.rainPossible = rainPossible
        self.temperature = temperature
        self.date = date
    }
    
    func fetchWeatherInfos(_ urlString: String, completionHandler: @escaping (_ firstAlbum: [WeatherViewModel], _ error: Error?) -> Void) {
        var weatherViewModels: [WeatherViewModel] = []
        
        weatherAPI.fetchWeather(urlString, withCompletion: { [weak self] (result) in
            switch result {
            case.success (let fetchResult):
                guard let weatherInfos = fetchResult.data else { return }
                for weatherInfo in weatherInfos {
                    self?.date = self?.stringToDate(string: weatherInfo.key)
                    self?.timeStamp = self?.formateDateString(string: weatherInfo.key)
                    self?.rainPossible = self?.rainPossibleText(num: weatherInfo.value.rain!)
                    self?.temperature = weatherInfo.value.temperature?.value
                    let viewModel = WeatherViewModel(timeStamp: self?.timeStamp, rainPossible: self?.rainPossible, temperature: self?.temperature, date: self?.date)
                    
                    
                    // If i save the result dirtely into presistence. maybe i don't need viewModel?
                    // and pass [Report] into completionHandler to viewController ?
                    
                    let report = Report(context: PersistenceService.context)
                    report.timeStamp = self?.timeStamp
                    report.temperature = (self?.temperature)!
                    PersistenceService.saveContext()
                    
                    // use Report object
                    
                    weatherViewModels.append(viewModel)
                }
                weatherViewModels = weatherViewModels.sorted(by: {
                    $0.date?.compare($1.date!) == .orderedAscending
                })
                completionHandler(weatherViewModels, nil)
            case.failure(let error):
                completionHandler([], error?.localizedDescription as? Error)
            }
        })
    }

    private func formateDateString(string: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: string) //according to date format your date string
        dateFormatter.dateFormat = "EEEE, MMM d, h a"
        return dateFormatter.string(from: date!)
    }
    
    private func stringToDate(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: string)!
    }
    
    private func rainPossibleText(num: Double) -> String? {
        if num == 0.0 {
            return "Pas de pluie"
        } else {
           return "\(num * 100) % precipitation"
        }
    }
}



