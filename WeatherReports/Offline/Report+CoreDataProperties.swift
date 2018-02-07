//
//  Report+CoreDataProperties.swift
//  WeatherReports
//
//  Created by Shanshan Zhao on 07/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//
//

import Foundation
import CoreData


extension Report {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Report> {
        return NSFetchRequest<Report>(entityName: "Report")
    }

    @NSManaged public var temperature: Double
    @NSManaged public var timeStamp: String?
    @NSManaged public var rainPossible: String?
    @NSManaged public var humidity: Double
    @NSManaged public var snowrisk: String?
    @NSManaged public var date: NSDate?

}
