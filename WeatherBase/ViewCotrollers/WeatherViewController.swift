//
//  WeatherViewController.swift
//  WeatherBase
//
//  Created by Карина Короткая on 19.03.2024.
//

import UIKit

final class WeatherViewController: UITableViewController {
    
    var weatherCity: [WeatherData] = []
    let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "minimalist-natural-wallpaper-for-mobile-phone-free-photo.jpg"))
    }
    
    @IBAction private func addCityButtonTaped(_ sender: Any) {
        addCityAlert { city in
            self.downloadWeather(for: city)
        }
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        weatherCity.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "weatherCityCell",
            for: indexPath
        ) as? WeatherCityCell else { return UITableViewCell() }
        
        let weather = weatherCity[indexPath.row]
        cell.configure(with: weather)
        
        return cell
    }
    
    private func addCityAlert(completion: @escaping (String) -> Void) {
        let alertController = UIAlertController(
            title: "Добавление города",
            message: "Введите название города на английском",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "Ок", style: .default) { (action) in
            let alertTextField = alertController.textFields?.first
            guard let text = alertTextField?.text else { return }
            completion(text)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Город"
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func downloadWeather(for city: String) {
        networkManager.fetchWeatherData(for: city) { result in
            switch result {
            case .success(let data):
                self.weatherCity.append(data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(for: error.localizedDescription)
                }
            }
        }
    }
    
    private func showAlert(for error: String) {
            let alertController = UIAlertController(
            title: "Ошибка",
            message: error,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "Ок", style: .default) { _ in }
        
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}





