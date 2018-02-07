//
//  WeatherAPI.swift
//  WeatherReports
//
//  Created by Shanshan Zhao on 07/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error?)
}

enum JSONError: Error {
    case NoData
    case ConversionFailed
}

class WeatherAPI {
    func fetchWeather(_ urlString: String, withCompletion completion: ((Result<WeatherResult>?, Error?) -> Void)?) {
        
        guard let requestUrl = URL(string:urlString) else { return }
        let request = URLRequest(url:requestUrl)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                guard let data = data else {
                    throw JSONError.NoData
                }

                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON {
                    guard let results = try? WeatherResult.init(with: json) else {
                        throw JSONError.ConversionFailed
                    }
                    completion!(.success(results), nil )
                } else {
                    throw JSONError.ConversionFailed
                }
            } catch let error as NSError {
                print(error.debugDescription)
                completion!(.failure(error), nil)
            }
            }.resume()
    }
}
