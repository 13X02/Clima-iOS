//
//  ViewController.swift
//  Clima
//

//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController  {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    var locationManager = CLLocationManager()
    var weatherManager = WeatherManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherManager.delegate = self
        searchTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func locationButtonPressed(_ sender: UIButton) {
        
        locationManager.requestLocation()
    }
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }

}
//MARK: - WeatherDelegate
extension WeatherViewController : WeatherManagerDelegate{
    

    func didUpdateWeather(_ weatherManager:WeatherManager, weather:WeatherModel){
        print(weather.temp)
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName :weather.conditionName)
            self.temperatureLabel.text = weather.tempString
        }
    }
}
//MARK: - TextField Delegate
extension WeatherViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }else{
            textField.placeholder = "Enter the place"
            return false
        }
    }
}
//MARK: - CLocationManagerDelegate
extension WeatherViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let long = location.coordinate.longitude
            let lat = location.coordinate.latitude
            
            weatherManager.fetchWeather(latitude: lat,longitude:long)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
