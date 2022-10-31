//
//  WeatherManager.swift
//  Clima
//
//  Created by Abhijith H on 28/10/22.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager:WeatherManager ,weather:WeatherModel)
}

struct WeatherManager{
    
    var delegate : WeatherManagerDelegate?
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=apikeyhere"
    
    func fetchWeather(cityName : String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString:urlString)
    }
    func fetchWeather(latitude : CLLocationDegrees , longitude : CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        print(urlString)
        performRequest(urlString:urlString)
    }
    
    func performRequest(urlString : String){
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url, completionHandler: {(data,response,error) in
                if error != nil{
                    print(error)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(self ,weather: weather)
                    }
                }
            })
            
            task.resume()
        }
    }
    
    func parseJSON(weatherData:Data)->WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weatherData = WeatherModel(cityName: name, temp: temp, conditionId: id)
            return weatherData
        }
        catch{
            print(error)
            return nil
        }
    }

}
