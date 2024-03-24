//
//  NetworkManager.swift
//  WeatherBase
//
//  Created by Карина Короткая on 19.03.2024.
//

import Foundation
import Alamofire

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
        guard let url = createWeatherURL(for: city, apiKey: apiKey) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
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
    
    func fetchWeatherManual(for city: String,
                            completion: @escaping(Result<WeatherData, AFError>) -> Void) {
        guard let url = createWeatherURL(for: city, apiKey: apiKey) else { return }
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let weatherData = WeatherData.getWeather(from: value)
                    guard let weatherData else {
                        completion(.failure(.parameterEncoderFailed(reason: .encoderFailed(error: NetworkError.decodingError))))
                        return
                    }
                    completion(.success(weatherData))
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
    }
    
    private func createWeatherURL(for city: String, apiKey: String) -> URL? {
        let stringUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&lang=ru&APPID=\(apiKey)"
        return URL(string: stringUrl)
    }
}

