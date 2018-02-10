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
    
    func fetchWeatherInfos(_ urlString: String, completionHandler: @escaping (_ reports: [Report], _ error: Error?) -> Void) {
        var reports: [Report] = []
        weatherAPI.fetchWeather(urlString, withCompletion: { [weak self] (result, error) in
            switch result {
            case.success (let fetchResult):
                guard let weatherInfos = fetchResult.data else { return }
                if (self?.existedReport().isEmpty == false) {
                    self?.deleteExsitReport()
                }
                for weatherInfo in weatherInfos {
                    let report = Report(context: PersistenceService.context)
                    report.timeStamp = self?.formateDateString(string: weatherInfo.key)
                    report.date = self?.stringToDate(string: weatherInfo.key) as NSDate?
                    
                    if let temp = weatherInfo.value.temperature?.value,
                        let rain = weatherInfo.value.rain,
                        let humidity = weatherInfo.value.humidity?.value,
                        let snowrick = weatherInfo.value.snowrisk {
                        report.temperature = self?.tempToCelsius(kelvin: temp)
                        report.rainPossible = self?.rainPossibleText(num: rain)
                        report.humidity = humidity
                        report.snowrisk = snowrick
                    }

                    PersistenceService.saveContext()
                    reports.append(report)
                }
                reports = reports.sorted(by: {
                    $0.date?.compare($1.date! as Date) == .orderedAscending
                })
                completionHandler(reports, nil)
            case.failure(let error):
                guard let offlineReport = self?.existedReport() else { return }
                completionHandler(offlineReport, error?.localizedDescription as? Error)
            }
        })
    }
    
    func existedReport() -> [Report] {
        var existReport: [Report] = []
        let fetchRequest: NSFetchRequest<Report> = Report.fetchRequest()
        do {
            existReport = try PersistenceService.context.fetch(fetchRequest) as [Report]
        } catch {
            print("fetch persistence data failed")
        }
        existReport = existReport.sorted(by: {
            $0.date?.compare($1.date! as Date) == .orderedAscending
        })
        return existReport
    }
    
    func deleteExsitReport() {
        let fetchRequest: NSFetchRequest<Report> = Report.fetchRequest()
        if let result = try? PersistenceService.context.fetch(fetchRequest) {
            for record in result {
                PersistenceService.context.delete(record)
            }
        }
    }
    
    private func tempToCelsius(kelvin: Double) -> String {
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
    
    private func rainPossibleText(num: Double) -> String {
        if num == 0.0 {
            return "Pas de pluie"
        } else {
           return "\(num * 100) % precipitation"
        }
    }
}



