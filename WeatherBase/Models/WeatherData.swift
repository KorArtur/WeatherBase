//
//  WeatherData.swift
//  WeatherBase
//
//  Created by Карина Короткая on 19.03.2024.
//


import Foundation

struct WeatherData: Codable {
    let base: String?
    let clouds: Clouds?
    let cod: Int?
    let coord: Coord?
    let dt, id: Int?
    let main: Main?
    let name: String?
    let sys: Sys?
    let timezone, visibility: Int?
    let weather: [Weather]
    let wind: Wind?
    
    init(data: [String: Any]) {
        base = nil
        clouds = nil
        cod = nil
        coord = nil
        dt = nil
        id = nil
        main = Main(from: data["main"] as? [String: Any] ?? [:])
        name = data["name"] as? String ?? ""
        sys = nil
        timezone = nil
        weather = (data["weather"] as? [[String: Any]] ?? []).compactMap { Weather(from: $0) }
        wind = nil
        visibility = nil
    }
}

struct Clouds: Codable {
    let all: Int?
}

struct Coord: Codable {
    let lat, lon: Double?
}

struct Main: Codable {
    let feelsLike: Double?
    let grndLevel, humidity, pressure, seaLevel: Int?
    let temp, tempMax, tempMin: Double?
    
    enum CodingKeys: String, CodingKey {
        case feelsLike = "feels_like"
        case grndLevel = "grnd_level"
        case humidity, pressure
        case seaLevel = "sea_level"
        case temp
        case tempMax = "temp_max"
        case tempMin = "temp_min"
    }
    
    init(from data: [String: Any]) {
        feelsLike = nil
        grndLevel = nil
        humidity = nil
        pressure = nil
        seaLevel = nil
        temp = data["temp"] as? Double ?? 0.0
        tempMax = data["temp_max"] as? Double ?? 0.0
        tempMin = data["temp_min"] as? Double ?? 0.0
    }
}

struct Sys: Codable {
    let country: String?
    let id, sunrise, sunset, type: Int?
}

struct Weather: Codable {
    let description, icon: String
    let id: Int?
    let main: String?
    
    init(from data: [String: Any]) {
        description = data["description"] as? String ?? ""
        icon = data["icon"] as? String ?? ""
        id = nil
        main = nil
        
    }
}

struct Wind: Codable {
    let deg: Int?
    let gust, speed: Double?
}

extension WeatherData {
    static func getWeather(from value: Any) -> WeatherData? {
        guard let data = value as? [String: Any] else { return nil }
        return WeatherData(data: data)
    }
}
