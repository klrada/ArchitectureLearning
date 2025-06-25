//
//  WeatherPresenter.swift
//  ArchitectureLearning
//
//  Created by kirada on 6/24/25.
//

import Foundation

protocol WeatherViewPresenterProtocol: AnyObject {
    func showWeather(date: String, temperature: Double)
}

protocol WeatherPresenterProtocol: AnyObject {
    func setWeather(city: String)
}

class WeatherPresenter: WeatherPresenterProtocol {
    
    weak var view: WeatherViewPresenterProtocol?
    var apiManager: WeatherAPIManagerProtocol
    
    init(view: WeatherViewPresenterProtocol?, apiManager: WeatherAPIManagerProtocol) {
        self.view = view
        self.apiManager = apiManager
    }
    
    func setWeather(city: String) {
        apiManager.fetchWeather(city: city) { result in
            switch result {
            case .success(let weather):
                self.view?.showWeather(date: String(weather.current.dt), temperature: weather.current.temp)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
