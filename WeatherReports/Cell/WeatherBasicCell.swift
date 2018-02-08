//
//  WeatherBasicTableViewCell.swift
//  WeatherReports
//
//  Created by Shanshan Zhao on 08/02/2018.
//  Copyright © 2018 Shanshan Zhao. All rights reserved.
//

import UIKit

class WeatherBasicCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configCell(report: Report) {
        self.temperatureLabel.text = report.temperature
        self.weekdayLabel.text = report.timeStamp
        if let date = report.date {
        self.hourLabel.text = self.hourFormat(date: date)
        }
    }
    
    private func hourFormat(date: NSDate) -> String {
        let amFormatter = DateFormatter()
        amFormatter.dateFormat  = " h a"
        let hour = amFormatter.string(from: date as Date)
        return hour
    }
}
