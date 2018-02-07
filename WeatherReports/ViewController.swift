//
//  ViewController.swift
//  WeatherReports
//
//  Created by Shanshan Zhao on 07/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
 
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherListTableView: UITableView!
    
    var weatherViewModel = WeatherViewModel()
    var weatherViewModels: [WeatherViewModel] = []
    
    var weatherReport = [Report]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        weatherViewModel.fetchWeatherInfos("https://www.infoclimat.fr/public-api/gfs/json?_ll=48.8566,2.3522&_auth=U0kEE1UrByVXelptUyVVfANrADVdKwgvBXkLaABlBXgHbARlBmZRN1E%2FVCkGKQYwWXRVNgoxAjIDaFEpXS9TMlM5BGhVPgdgVzhaP1N8VX4DLQBhXX0ILwVuC20AcwVgB2MEfgZgUTVRIFQ0BjUGMVl1VSoKNAI%2FA2FRMV03UzBTMQRmVTIHYlcnWidTZlUwAzcAZl1mCGEFZgs6AGsFbgc2BGUGYlEzUSBUPgY2BjVZblU3Cj0COQNgUSldL1NJU0MEfVV2BydXbVp%2BU35VNANuADQ%3D&_c=c0e8963a1462ec64214942bf624a8d15") { (weatherReports, error) in
            self.weatherReport = weatherReports
            DispatchQueue.main.async {
                self.weatherListTableView.reloadData()
            }
        }
        
        let fetchRequest: NSFetchRequest<Report> = Report.fetchRequest()
        do {
           let weatherList = try PersistenceService.context.fetch(fetchRequest)
            self.weatherReport = weatherList
        } catch { }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherReport.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        if  self.weatherReport.count > 0 {
            cell.textLabel?.text = self.weatherReport[indexPath.row].timeStamp
        }
        return cell
    }
}



