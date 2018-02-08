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
    
    @IBOutlet weak var todayTempertureLabel: UILabel!
    var weatherViewModel = WeatherViewModel()
        var weatherReport = [Report]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.contents = UIImage(named: "background")?.cgImage
        self.weatherListTableView.layer.cornerRadius = 20
        fetchWeatherListOfParis()
        self.navigationItem.title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func fetchWeatherListOfParis() {
        weatherViewModel.fetchWeatherInfos(Constants.weatherURL) { (weatherReports, error) in
            self.weatherReport = weatherReports
            DispatchQueue.main.async {
                self.weatherListTableView.reloadData()
                self.todayTempertureLabel.text = self.weatherReport.first?.temperature
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let weatherDetail = storyboard.instantiateViewController(withIdentifier: "WeatherDetailsViewController") as? WeatherDetailsViewController {
            let report = self.weatherReport[indexPath.row]
            weatherDetail.viewModel = WeatherDetailsViewModel(humidity: report.humidity, rainPossible: report.rainPossible, snowrisk: report.snowrisk, temperature: report.temperature)
            self.navigationController?.pushViewController(weatherDetail, animated: true)
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherReport.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherBasicCell", for: indexPath) as? WeatherBasicCell
 
        if self.weatherReport.count > 0 {
            cell?.configCell(report: self.weatherReport[indexPath.row])
        }
        return cell!
    }
}



