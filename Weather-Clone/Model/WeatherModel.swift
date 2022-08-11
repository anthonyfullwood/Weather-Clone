//
//  CurrentWeatherModel.swift
//  Weather-Clone
//
//  Created by Anthony Fullwood on 19/05/1401 AP.
//

import Foundation

struct WeatherModel{
    
    let cityName: String
    let temperature: Double
    let description: String
    let htemperature: Double
    let ltemperature: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let windSpeed: Double
    
    var feelsLikeString: String{
        return String(format: "%.f",feels_like)
    }
    
    var windSpeedString: String{
        return String(format: "%.f",windSpeed)
    }
    
    var temperatureString: String{
        return String(format: "%.f",temperature)
    }
    
    var htemperatureString: String{
        return String(format: "%.f",htemperature)
    }
    
    var ltemperatureString: String{
        return String(format: "%.f",ltemperature)
    }
    
}
