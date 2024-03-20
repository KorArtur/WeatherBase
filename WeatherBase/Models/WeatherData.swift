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
}

struct Sys: Codable {
    let country: String?
    let id, sunrise, sunset, type: Int?
}

struct Weather: Codable {
    let description, icon: String
    let id: Int?
    let main: String?
}

struct Wind: Codable {
    let deg: Int?
    let gust, speed: Double?
}
