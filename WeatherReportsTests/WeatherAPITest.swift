//
//  WeatherAPITest.swift
//  WeatherReportsTests
//
//  Created by Shanshan Zhao on 08/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import XCTest
@testable import WeatherReports

class WeatherAPITest: XCTestCase {
    
    var weatherAPI = WeatherAPI()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testfetchWeather() {
        let expectation = XCTestExpectation(description: "fetch matched weather reports")
        weatherAPI.fetchWeather(Constants.weatherURL) { (result, error) in
            switch result {
            case .success(let list):
                guard let results = list.data else { return }
                XCTAssertNotNil(results, "Received weather report list should not be nil")
                
                let firstTimeStamp = results.first?.key
                XCTAssertNotNil(firstTimeStamp, "TimeStamps should not be nil in first received Weather Report, ")
                XCTAssertEqual(firstTimeStamp?.count, "yyyy-MM-dd HH:mm:ss".count, "should be the same lenght. a lazy way to test format")

                let firstWeather = results.first?.value
                XCTAssertNotNil(firstWeather?.humidity, "humidity should not be nil in first received Weather Report ")
                XCTAssertNotNil(firstWeather?.temperature, "temperature should not be nil in first received Weather Report ")
                XCTAssertNotNil(firstWeather?.rain, "rain should not be nil in first received Weather Report ")
                expectation.fulfill()

            case .failure(let error):
                print("my error \(String(describing: error))")
            }
        }
        self.wait(for: [expectation], timeout: 5)
    }
    
}
