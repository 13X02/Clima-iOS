//
//  WeatherModel.swift
//  Clima
//
//  Created by Abhijith H on 29/10/22.
//

import Foundation


struct WeatherModel {
    
    let cityName : String
    let temp : Double
    let conditionId : Int
    var tempString : String{
        return String(format: "%.1f", temp)
    }
    
    var conditionName : String{
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
