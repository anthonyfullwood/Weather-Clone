//
//  ViewController.swift
//  Weather-Clone
//
//  Created by Anthony Fullwood on 18/05/1401 AP.
//

import UIKit

class WeatherViewController: UIViewController {

    let weatherManager = WeatherManager()
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var hTempLabel: UILabel!
    @IBOutlet weak var lTempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        weatherManager.fetchWeather(cityName:"cupertino")
    }

    @IBAction func currentLocationPressed(_ sender: UIButton) {
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
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
        
        
        textField.resignFirstResponder()
        return true
    }
    
}
