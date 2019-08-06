//
//  ChangeCityViewController.swift
//  WeatherNCR
//
//  Created by William Ngo on 21/07/2019.
//  Copyright © 2019 William Ngo. All rights reserved.
//

import UIKit

protocol ChangeCityDelegate {
    func userSelectCity(city: String)
}

class ChangeCityViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityPicker.delegate = self
        cityPicker.dataSource = self
    }
    
    @IBOutlet weak var cityPicker: UIPickerView!
    
    var delegate : ChangeCityDelegate?
    
    var cityArray = ["Manila", "Makati", "Pasig"]
    
    var citySelect : String = ""

    // MARK: - Table view data source

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        citySelect = cityArray[row]
    }
        
    
    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        
        delegate?.userSelectCity(city: citySelect)
        
        self.dismiss(animated: true, completion: nil)
    }
    
        
}



