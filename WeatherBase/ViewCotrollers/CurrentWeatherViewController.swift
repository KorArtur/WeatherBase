//
//  CurrentWeatherViewController.swift
//  WeatherBase
//
//  Created by Карина Короткая on 21.03.2024.
//

import UIKit

final class CurrentWeatherViewController: UIViewController {
    
    @IBOutlet private var cityNameLabel: UILabel!
    
    @IBOutlet private var sunView: UIImageView!
    @IBOutlet private var cloudOneView: UIImageView!
    @IBOutlet private var cloudTwoView: UIImageView!
    @IBOutlet private var cloudThreeView: UIImageView!
    
    var weatherCity: WeatherData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityNameLabel.text = weatherCity.name
        
        sunView.image = UIImage(named: "sun")
        cloudOneView.image = UIImage(named: "cloud")
        cloudTwoView.image = UIImage(named: "cloud")
        cloudThreeView.image = UIImage(named: "cloud")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        rotateSunRay()
        moveClouds()
    }
    
    func rotateSunRay() {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation")
        animation.duration = 20
        animation.repeatCount = .infinity
        animation.calculationMode = .paced
        animation.values = [0, CGFloat.pi * 2]
        sunView.layer.add(animation, forKey: "rotation")
    }
    
    func moveClouds() {
        UIView.animate(
            withDuration: 10,
            delay: 0,
            options: [.autoreverse, .curveEaseInOut, .repeat]) { [unowned self] in
                cloudOneView.transform = CGAffineTransform(translationX: 200, y: 0)
                cloudTwoView.transform = CGAffineTransform(translationX: 110, y: 0)
                cloudThreeView.transform = CGAffineTransform(translationX: 30, y: 0)
            }
    }
}
