//
//  ViewController.swift
//  WeatherNCR
//
//  Created by William Ngo on 20/07/2019.
//  Copyright © 2019 William Ngo. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import SVProgressHUD

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {

    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "f71b4f7224fbeeaf4ebaee4e980676f4"
    
    let locationManager = CLLocationManager()
    var updateWeather = WeatherData()
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Location Manager Setup
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // Location Manager Delegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            
            print("Longitude: \(location.coordinate.longitude) & Latitude: \(location.coordinate.latitude)")
            
            let longitude = String(location.coordinate.longitude)
            let latitude = String(location.coordinate.latitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
        cityLabel.text = "Location Unavailable"
    }
    
    func getWeatherData(url : String, parameters : [String : String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {response in
            if response.result.isSuccess {
                print("Success! Got Weather Data")
                let weatherJSON : JSON = JSON(response.result.value!)
                print(weatherJSON)
                self.updateWeatherData(json: weatherJSON)
            } else {
                print("Error: \(Error.self)")
                self.cityLabel.text = "Connection Issue"
            }
        }
    }
    
    func updateWeatherData(json: JSON){
        if let tempResult = json["main"]["temp"].double {
            updateWeather.temperature = Int(tempResult - 273.15)
            updateWeather.city = json["name"].stringValue
            updateWeather.condition = json["weather"][0]["id"].intValue
            updateWeather.weatherIconName = updateWeather.updateWeatherIcon(condition: updateWeather.condition)
            
            updateUI()
            
        } else {
            cityLabel.text = "Weather Not Available"
        }
    }
    
    func updateUI() {
        
        cityLabel.text = updateWeather.city
        temperatureLabel.text = String(updateWeather.temperature) + "°"
        weatherIcon.image = UIImage(named: updateWeather.weatherIconName)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "selectCity" {
            
            let destinationVC = segue.destination as! ChangeCityViewController
            
            destinationVC.delegate = self
            
        }
    }
    
    func userSelectCity(city: String) {
        
        if city != "" {
            
            let params : [String : String] = ["q" : city, "appid" : APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
            
        } else {
            
            let params : [String : String] = ["q" : "Manila", "appid" : APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
        
        
    }
    
    
    
    
    


}

