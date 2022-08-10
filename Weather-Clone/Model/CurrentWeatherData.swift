//
//  WeatherData.swift
//  Weather-Clone
//
//  Created by Anthony Fullwood on 19/05/1401 AP.
//

import Foundation

struct CurrentWeatherData: Codable{
    
    let name: String
    let main: Main
    //let hourly: [Hourly]
    //let daily: [Daily]
    let weather: [Weather]
}

struct Main: Codable{
    
    let temp: Double
    let temp_max: Double
    let temp_min: Double
    
}

/*struct Hourly: Codable{
    
    let dt: Int
    let temp: Double
    let weather: [Weather]
}

struct Daily: Codable{
    
    let dt: Int
    let temp: Double
    let weather: [Weather]
}*/

struct Weather: Codable{
    
    let description: String
    let id: Int
}


