//
//  WeatherTest.swift
//  WeatherReportsTests
//
//  Created by Shanshan Zhao on 08/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import XCTest
@testable import WeatherReports

class WeatherTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBasicParsing() {
        let json = """
{
  "vent_rafales" : {
    "10m" : 7.0999999999999996
  },
  "pression" : {
    "niveau_de_la_mer" : 102100
  },
  "pluie" : 0,
  "risque_neige" : "non",
  "vent_moyen" : {
    "10m" : 5.4000000000000004
  },
  "nebulosite" : {
    "totale" : 55,
    "haute" : 55,
    "basse" : 0,
    "moyenne" : 0
  },
  "pluie_convective" : 0,
  "vent_direction" : {
    "10m" : 344
  },
  "iso_zero" : 0,
  "temperature" : {
    "sol" : 269.80000000000001,
    "2m" : 267,
    "500hPa" : -0.10000000000000001,
    "850hPa" : -0.10000000000000001
  },
  "humidite" : {
    "2m" : 77.099999999999994
  },
  "cape" : 0
}
"""
        let weatherJSONString = json.data(using: .utf8)!
        let jsonObjects = try! JSONSerialization.jsonObject(with: weatherJSONString) as! JSON
        //        Just figure out this amazing way to avoir full screen json, make it into prettier way 😂
        //        let data = try! JSONSerialization.data(withJSONObject: jsonObjects, options: .prettyPrinted)
        //        let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        //        print(string)
        
        let weather = try? Weather(with: jsonObjects)
        XCTAssertNotNil(weather)
        XCTAssertEqual("non", weather?.snowrisk)
        XCTAssertEqual(77.099999999999994, weather?.humidity?.value)
        XCTAssertEqual(267, weather?.temperature?.value)
    }
    
    func test_init_method() {
        let temperature = Temperature(value: 267, sol: 267)
        let humidity = Humidity(value: 77)
        let weather = Weather(rain: 0, temperature: temperature , humidity: humidity, snowrisk: "non")
        XCTAssertNotNil(weather)
        XCTAssertEqual(weather.humidity?.value, 77)
        XCTAssertEqual(weather.snowrisk,"non")
    }
}
