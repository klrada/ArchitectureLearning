//
//  ModelBuilder.swift
//  ArchitectureLearning
//
//  Created by kirada on 6/25/25.
//

import UIKit

protocol Builder {
    static func createMain() -> UIViewController
}

class ModelBuilder: Builder {
    static func createMain() -> UIViewController {
        let model = WeatherAPIManager()
        let view = WeatherViewController()
        let presenter = WeatherPresenter(view: view, apiManager: model)
        view.presenter = presenter
        return view
    }
}
