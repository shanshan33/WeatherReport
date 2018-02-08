//
//  WeatherDetailsViewController.swift
//  WeatherReports
//
//  Created by Shanshan Zhao on 08/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import UIKit
import CoreData

class WeatherDetailsViewController: UIViewController {
    
    var viewModel = WeatherDetailsViewModel()

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var snowriskLabel: UILabel!
    @IBOutlet weak var rainriskLabel: UILabel!
    @IBOutlet weak var huminityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.contents = UIImage(named: "background")?.cgImage
        setNavigationBarAppearence()
        self.navigationController?.navigationBar.isHidden = false
        setupReportDetail(viewModel:viewModel)
    }

    
    private func setNavigationBarAppearence() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupReportDetail(viewModel: WeatherDetailsViewModel)
    {
        temperatureLabel.text = viewModel.temperature
        if let humidity = viewModel.humidity, let rain = viewModel.rainPossible, let snow = viewModel.snowrisk {
            snowriskLabel.text =  "☃️ \(snow)"
            huminityLabel.text = "💧 Humidite \(Int(humidity))%"
            rainriskLabel.text = "☔️ " + rain
        }
    }

}
