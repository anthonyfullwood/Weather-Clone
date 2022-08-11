//
//  WeatherManager.swift
//  Weather-Clone
//
//  Created by Anthony Fullwood on 19/05/1401 AP.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(weather: WeatherModel)
    
    func didFailWithError(error: Error)
}

struct WeatherManager{
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=86911fd19e56b71a7b4bf094ebdd2972&units=metric"
        
    var delegate: WeatherManagerDelegate?
    
    // Method for fetching weather with a city name
    func fetchWeather(cityName: String){
        
        let urlString = "\(weatherURL)&q=\(removeWhiteSpaceBetweenWords(string: cityName))"
        performRequest(urlString: urlString)
    }
    
    // Method for fetching weather with a coordinates
    func fetchWeather(with latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: urlString)
    }
    
    // Method for getting data from api provider
    func performRequest(urlString: String){
        
        let url = URL(string: urlString)
        let session = URLSession(configuration: .default)
        
        if let url = url {
            
            let task = session.dataTask(with: url) { data, response, error in
                
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    
                    if let weather = parseJSON(data: safeData){
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
                
            }
            
            task.resume()
            
        }
        
    }
    
    //Method for coverting JSON data into a swift readable format
    func parseJSON(data: Data) -> WeatherModel?{
        
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            
            let cityName = decodedData.name
            let description = decodedData.weather[0].main
            let temp = decodedData.main.temp
            let hTemp = decodedData.main.temp_max
            let lTemp = decodedData.main.temp_min
            let wind = decodedData.wind.speed
            let humidity = decodedData.main.humidity
            let pressure = decodedData.main.pressure
            let feels_like = decodedData.main.feels_like
            
            let weather = WeatherModel(cityName: cityName, temperature: temp, description:description, htemperature: hTemp, ltemperature: lTemp, feels_like: feels_like, pressure: pressure, humidity: humidity, windSpeed: wind)
            
            return weather
            
            
        }catch{
            
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
    // Method for coverting city names with whitespace to a url readable format
    func removeWhiteSpaceBetweenWords(string: String) -> String{
        
        var arr = Array(string)
    
        for (i,char) in  arr.enumerated(){
            
            if char == " " {
                
                if arr[i+1] != " "{
                    arr[i] = "+"
                    
                }else{
                    break
                }
            }
        }
        
        return String(arr).trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
