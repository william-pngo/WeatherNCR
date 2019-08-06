//
//  WeatherData.swift
//  WeatherNCR
//
//  Created by William Ngo on 20/07/2019.
//  Copyright © 2019 William Ngo. All rights reserved.
//

import UIKit

class WeatherData {
    
    //Model Variables
    var temperature : Int = 0
    var condition : Int = 0
    var city = ""
    var weatherIconName = ""
    
    //This method turns a condition code into the name of the weather condition image
    
    func updateWeatherIcon(condition: Int) -> String {
        
        switch (condition) {
            
        case 0...300 :
            return "tstorm1"
            
        case 301...500 :
            return "light_rain"
            
        case 501...600 :
            return "shower3"
            
        case 701...771 :
            return "fog"
            
        case 772...799 :
            return "tstorm3"
            
        case 800 :
            return "sunny"
            
        case 801...804 :
            return "cloudy3"
            
        case 900...903, 905...1000  :
            return "tstorm3"
            
        case 904 :
            return "sunny"
            
        default :
            return "dunno"
        }
        
    }
}
