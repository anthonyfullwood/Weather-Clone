//
//  ViewController.swift
//  Weather-Clone
//
//  Created by Anthony Fullwood on 18/05/1401 AP.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, WeatherManagerDelegate {
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
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
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()
        
        //Rounds edges of UIViews for different weather cards
        card1.layer.cornerRadius = 20
        card2.layer.cornerRadius = 20
        card3.layer.cornerRadius = 20
        card4.layer.cornerRadius = 20
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Calls weather manager objects's method for getting weather info with city name
        weatherManager.fetchWeather(cityName:"cupertino")
    }

    @IBAction func currentLocationPressed(_ sender: UIButton) {
        
        locationManager.requestLocation()
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        
        
        if let city = searchTextField.text {
            
            weatherManager.fetchWeather(cityName: city)
            
            searchTextField.text = ""
            searchTextField.resignFirstResponder()
        }
        
    }
    
    //MARK: - WeatherManager Delegate methods
    func didUpdateWeather(weather: WeatherModel) {
        
        //Updates UI with weather data recieved from weather manager on main thread
        DispatchQueue.main.async {
            
            self.nameLabel.text = weather.cityName
            self.tempLabel.text = weather.temperatureString
            self.descriptionLabel.text = weather.description
            self.hTempLabel.text = weather.htemperatureString
            self.lTempLabel.text = weather.ltemperatureString
            self.windSpeedLabel.text = weather.windSpeedString
            self.feelsLikeLabel.text = weather.feelsLikeString
            self.pressureLabel.text = String(weather.pressure)
            self.humidityLabel.text = String(weather.humidity)
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - UTextField delegate extension
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
            weatherManager.fetchWeather(cityName: city)
        }
        
        textField.resignFirstResponder()
        return true
    }
    
}

//MARK: - CLLocation delegate extension
extension WeatherViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        let latitute = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        
        
        //Calls weather manager objects's method for getting weather info with coordinates
        if let lat = latitute, let lon = longitude{
            weatherManager.fetchWeather(with: lat, longitude: lon)
        }
       
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
