//
//  WeatherManager.swift
//  Weather-Clone
//
//  Created by Anthony Fullwood on 19/05/1401 AP.
//

import Foundation

struct WeatherManager{
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=86911fd19e56b71a7b4bf094ebdd2972&exclude=minutely&units=metric"
    
    
    func fetchWeather(cityName: String){
        
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        
        let url = URL(string: urlString)
        let session = URLSession(configuration: .default)
        
        if let url = url {
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    return
                }
                
                if let safeData = data{
                    
                    parseData(data: safeData)
                }
                
            }
            
            task.resume()
            
        }
        
    }
    
    func parseData(data: Data){
        
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(CurrentWeatherData.self, from: data)
            
            print(decodedData.main.temp_max)
            
        }catch{
            print(error)
        }
        
    }
}
