//
//  CurrentWeatherViewController.swift
//  WeatherBase
//
//  Created by Карина Короткая on 21.03.2024.
//

import UIKit

final class CurrentWeatherViewController: UIViewController {

    var weatherCity: WeatherData!
    
    @IBOutlet private var cityNameLabel: UILabel!
    @IBOutlet private var sunView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityNameLabel.text = weatherCity.name
        sunView.image = UIImage(named: "sun")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
    }
    
    private func rotateSun() {
        
    }
}
