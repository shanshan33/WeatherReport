//
//  PersistenceService.swift
//  WeatherReports
//
//  Created by Shanshan Zhao on 07/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import Foundation
import CoreData

class PersistenceService {
    
//    private init() {}
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    static var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "WeatherReports")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    static func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    static func saveObject(timeStamp:String, date: NSDate, humidity: Double, rainPossible: String, snowrisk: String, temperature: String) {

        let report = Report(context: context)
        report.timeStamp = timeStamp
        report.date = date
        report.humidity = humidity
        report.rainPossible = rainPossible
        report.snowrisk = snowrisk
        report.temperature = temperature
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    static func fetchAndSortReports() -> [Report]? {
        var reports: [Report]? = nil
        do {
            reports = try context.fetch(Report.fetchRequest())
            reports = reports?.sorted(by: {$0.date?.compare($1.date! as Date) == .orderedAscending
            })
            return reports
        } catch {
            return reports
        }
    }
    
    static func deleteObject(report: Report) {
        context.delete(report)
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    static func clean() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Report")
        let delete = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(delete)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
    }

    
}
