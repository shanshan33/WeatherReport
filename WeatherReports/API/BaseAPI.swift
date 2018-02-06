//
//  BaseAPI.swift
//  WeatherReports
//
//  Created by Shanshan Zhao on 07/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import Foundation

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error?)
}

enum JSONError: Error {
    case NoData
    case ConversionFailed
}

class BaseAPI {
    public func request<T>(urlString: String, completion: @escaping (Result<T>) -> Void?) where T: JSONInitializable {
        guard let requestUrl = URL(string:urlString) else { return }
        let request = URLRequest(url:requestUrl)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                guard let data = data else {
                    throw JSONError.NoData
                }
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON {
                    guard let results = try? T.init(with: json) else {
                        throw JSONError.ConversionFailed
                    }
                    completion(.success(results))
                } else {
                    throw JSONError.ConversionFailed
                }
            } catch let error as NSError {
                print(error.debugDescription)
            }
            }.resume()
    }
}
