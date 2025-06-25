//
//  WeatherViewController.swift
//  ArchitectureLearning
//
//  Created by kirada on 6/24/25.
//

import UIKit

class WeatherViewController: UIViewController {
    
    lazy var searchTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.borderStyle = .roundedRect
        $0.autocapitalizationType = .none
        $0.placeholder = "City"
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = UIColor.darkGray.cgColor
        return $0
    }(UITextField())
    
    lazy var searchButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = .darkGray
        $0.addTarget(self, action: #selector(search), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    lazy var timeLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 27, weight: .semibold)
        return $0
    }(UILabel())
    
    lazy var temperatureLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 27, weight: .semibold)
        return $0
    }(UILabel())
    
    var presenter: WeatherPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(temperatureLabel)
        view.addSubview(timeLabel)
        
        makeConstraints()
        
    }
    
    func makeConstraints() {
        
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -10),
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
            
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 15),
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            temperatureLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    @objc func search() {
        
        let request = searchTextField.text ?? ""
        
        guard !request.isEmpty else {
            print("Поле ввода пустое")
            return
        }
        
        presenter?.setWeather(city: request)
    }
    
    
}

extension WeatherViewController: WeatherViewPresenterProtocol {
    func showWeather(date: String, temperature: Double) {
        timeLabel.text = date
        temperatureLabel.text = String(temperature)
    }
}
