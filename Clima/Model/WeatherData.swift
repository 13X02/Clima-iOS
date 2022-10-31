//
//  WeatherData.swift
//  Clima
//
//  Created by Abhijith H on 29/10/22.
//

import Foundation


struct WeatherData : Codable{
    let main : Main
    let weather : [Weather]
    let name : String
}


struct Weather : Codable{
    let id : Int
}

struct Main : Codable{
    let temp : Double
}
