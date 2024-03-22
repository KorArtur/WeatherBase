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
    
    func fetchWeatherData(
        for city: String,
        completion: @escaping(Result<WeatherData, NetworkError>) -> Void
    ) {
        
        let stringUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&lang=ru&APPID=\(apiKey)"
        guard let url = URL(string: stringUrl) else {return}
        
        fetch(WeatherData.self, from: url) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetch<T: Decodable>(
        _ type: T.Type,
        from url: URL,
        completion: @escaping(Result<T, NetworkError>) -> Void
    ) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dataModel = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
