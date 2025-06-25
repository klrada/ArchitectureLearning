//
//  WeatherAPIManager.swift
//  ArchitectureLearning
//
//  Created by kirada on 6/24/25.
//

import Foundation

protocol WeatherAPIManagerProtocol {
    func fetchWeather(city: String, completion: @escaping(Result<WeatherModel, Error>) -> Void)
    func fetchWeatherByCoordinates(lat: Double, lon: Double, completion: @escaping (Result<WeatherModel, Error>) -> Void)
}

class WeatherAPIManager: WeatherAPIManagerProtocol {
    
    let apiKey = "931d448113c6408e422df8bd436c3283"
    
    func fetchWeather(city: String, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        let geoURL = "https://api.openweathermap.org/geo/1.0/direct?q=\(city)&appid=\(apiKey)"
        
        guard let geoURL = URL(string: geoURL) else { return }
        
        var geoRequest = URLRequest(url: geoURL)
        geoRequest.httpMethod = "GET"
        
        let geoTask = URLSession.shared.dataTask(with: geoRequest) { data, _, error in
            guard let data = data, error == nil else {
                print("Ошибка API 1: \(error?.localizedDescription ?? "Нет данных")")
                return
            }
            
            do {
                let location = try JSONDecoder().decode([GeoModel].self, from: data)
                guard let location = location.first else {
                    print("Город не найден")
                    return
                }
                
                self.fetchWeatherByCoordinates(lat: location.lat, lon: location.lon) { result in
                    completion(result)
                }
            } catch {
                completion(.failure(error))
            }
        }
        geoTask.resume()
    }
    
    func fetchWeatherByCoordinates(lat: Double, lon: Double, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        let weatherURL = "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&appid=\(apiKey)"
        
        guard let weatherURL = URL(string: weatherURL) else { return }
        
        var weatherRequest = URLRequest(url: weatherURL)
        weatherRequest.httpMethod = "GET"
        
        let weatherTask = URLSession.shared.dataTask(with: weatherRequest) { data, _, error in
            guard let data = data, error == nil else {
                print("Ошибка API 2: \(error?.localizedDescription ?? "Нет данных")")
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion(.success(weather))
            } catch {
                completion(.failure(error))
            }
        }
        weatherTask.resume()
    }
    
}
