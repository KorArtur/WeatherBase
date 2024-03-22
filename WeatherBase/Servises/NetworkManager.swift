//
//  NetworkManager.swift
//  WeatherBase
//
//  Created by Карина Короткая on 19.03.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let apiKey = "239984673fcc9cd389be094b9a97cbbc"
    private init() {}
    
    func fetchWeather(for city: String,
                      completion: @escaping(Result<WeatherData, NetworkError>) -> Void
    ) {
        let stringUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&lang=ru&APPID=\(apiKey)"
        guard let url = URL(string: stringUrl) else { return }
        
        URLSession.shared.dataTask(with: url) {  data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherData.self, from: data)
                completion(.success(weatherData))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
