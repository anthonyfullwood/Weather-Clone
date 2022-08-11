//
//  WeatherData.swift
//  Weather-Clone
//
//  Created by Anthony Fullwood on 19/05/1401 AP.
//

import Foundation

struct WeatherData: Codable{
    
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
}

struct Main: Codable{
    
    let temp: Double
    let temp_max: Double
    let temp_min: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    
}

struct Wind: Codable{
    
    let speed: Double
}
struct Weather: Codable{
    
    let main: String
   
}


