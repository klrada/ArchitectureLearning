//
//  WeatherModel.swift
//  ArchitectureLearning
//
//  Created by kirada on 6/24/25.
//

import Foundation

struct GeoModel: Codable {
    let lat: Double
    let lon: Double
}

struct WeatherModel: Codable {
    let current: CurrentWeather
}

struct CurrentWeather: Codable {
    let dt: Int
    let temp: Double
}
