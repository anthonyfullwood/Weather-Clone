//
//  ViewController.swift
//  Weather-Clone
//
//  Created by Anthony Fullwood on 18/05/1401 AP.
//

import UIKit

class WeatherViewController: UIViewController, WeatherManagerDelegate {
    
    
    var weatherManager = WeatherManager()
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var hTempLabel: UILabel!
    @IBOutlet weak var lTempLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var card1: UIView!
    @IBOutlet weak var card2: UIView!
    @IBOutlet weak var card3: UIView!
    @IBOutlet weak var card4: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
        
        card1.layer.cornerRadius = 20
        card2.layer.cornerRadius = 20
        card3.layer.cornerRadius = 20
        card4.layer.cornerRadius = 20
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        weatherManager.fetchWeather(cityName:"cupertino")
    }

    @IBAction func currentLocationPressed(_ sender: UIButton) {
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city.trimmingCharacters(in: .whitespacesAndNewlines))
            
            searchTextField.text = ""
            searchTextField.resignFirstResponder()
        }
        
    }
    
    func didUpdateWeather(weather: WeatherModel) {
        
        DispatchQueue.main.async {
            
            self.nameLabel.text = weather.cityName
            self.tempLabel.text = weather.temperatureString
            self.descriptionLabel.text = weather.description
            self.hTempLabel.text = weather.htemperatureString
            self.lTempLabel.text = weather.ltemperatureString
            self.windSpeedLabel.text = weather.windSpeedString
            self.feelsLikeLabel.text = String(weather.feels_like)
            self.pressureLabel.text = String(weather.pressure)
            self.humidityLabel.text = String(weather.humidity)
        }
        
    }
}

extension WeatherViewController: UITextFieldDelegate{
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        textField.text = ""
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        if let city = textField.text {
            weatherManager.fetchWeather(cityName: city.trimmingCharacters(in: .whitespacesAndNewlines))
        }
        
        textField.resignFirstResponder()
        return true
    }
    
}
