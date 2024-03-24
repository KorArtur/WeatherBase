//
//  WeatherCityCell.swift
//  WeatherBase
//
//  Created by Карина Короткая on 19.03.2024.
//

import Foundation
import UIKit

final class WeatherCityCell: UITableViewCell {
    
    @IBOutlet private var weatherIconView: UIImageView!
    
    @IBOutlet private var cityLabel: UILabel!
    @IBOutlet private var conditionLabel: UILabel!
    @IBOutlet private var temperatureLabel: UILabel!
    @IBOutlet private var maxTempLabel: UILabel!
    @IBOutlet private var minTempLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
    }
    
    func configure(with weather: WeatherData) {
        weatherIconView.image = UIImage(named: weather.weather.first?.icon ?? "sun.max")
        cityLabel.text = weather.name
        conditionLabel.text = weather.weather.first?.description
        temperatureLabel.text = "\(weather.main?.temp ?? 0)°C"
        maxTempLabel.text = "max: \(weather.main?.tempMax ?? 0)°C"
        minTempLabel.text = "min: \(weather.main?.tempMin ?? 0)°C"
    }
}
