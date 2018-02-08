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
{ "cape": 0, "humidite":{ "2m":
77.1
},
"iso_zero":
0,
"nebulosite":
{
"basse":
0,
"haute":
55,
"moyenne":
0,
"totale":
55
},
"pluie":
0,
"pluie_convective":
0,
"pression":
{
"niveau_de_la_mer":
102100
},
"risque_neige":
"non",
"temperature":
{
"2m":
267,
"500hPa":
-0.1,
"850hPa":
-0.1,
"sol":
269.8
},
"vent_direction":
{
"10m":
344
},
"vent_moyen":
{
"10m":
5.4
},
"vent_rafales":
{
"10m":
7.1
}
}

"""
        
        let weatherJSONString = json.data(using: .utf8)!
        let jsonObjects = try! JSONSerialization.jsonObject(with: weatherJSONString) as! JSON
        // This is amazing to change super long ugly json into pretty string lool
        let data = try! JSONSerialization.data(withJSONObject: jsonObjects, options: .prettyPrinted)
        let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        print(string)
        

        //JSONSerialization.jsonObject(with: weatherJSONString) as! JSON
 //       let weather = try? Weather(with: jsonObjects)
 //       XCTAssertNotNil(weather)
 //       XCTAssertEqual(name, weather?.name)
    }

}
