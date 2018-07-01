//
//  Weather.swift
//  CropBook
//
//  Created by jon on 2018-07-01.
//  Copyright © 2018 CMPT276-Group15. All rights reserved.
//

import UIKit
import AerisWeatherKit

class Weather: NSObject {
    
    
    func CheckWeather() {
        print("Checking Weather")
        
        let place = AWFPlace(city: "vancouver", state: "bc", country: "ca")
        AWFObservations.sharedService().get(forPlace: place, options: nil){ (result) in
            guard let results = result?.results else { print("Data failed to load - \(String(describing: result?.error))"); return }
            guard let obs = results.first as? AWFObservation else { return }
            
            print("The current weather in \(String(describing: place.name)) is \(String(describing: obs.weather)) with a temperature of \(obs.tempF).")
            
        }
    }
    
}
