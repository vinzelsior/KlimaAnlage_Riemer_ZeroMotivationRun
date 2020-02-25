//
//  Thermostat.swift
//  KlimaanlageRiemer_ZeroMotivationRun
//
//  Created by Cedric Zwahlen on 25.02.20.
//  Copyright © 2020 Cedric Zwahlen. All rights reserved.
//

import Foundation

struct Thermostat {
    
    var currentTemp: Double
    var min: Double
    var max: Double
    var hysteresis: Double
    
    private var wait = false
    
    var cool: Bool {
        mutating get {
            
            wait = (max - hysteresis) > currentTemp ? true : wait
            
            if currentTemp > max && !wait {
                wait = true
                return true
            } else {
                return false
            }
        }
    }
    
    var heat: Bool {
        mutating get {
            
            wait = (min + hysteresis) < currentTemp ? true : wait
            
            if currentTemp < min && !wait {
                wait = true
                return true
            } else {
                return false
            }
        }
    }
    
    var room: PT1Glied
    
    init(initialTemp: Double, min: Double, max: Double, hysteresis: Double, tau: Double = 120) {
        
// TO-DO:  implement sanitisation, so make initialiser failable.
        
        self.currentTemp = initialTemp
        self.min = min
        self.max = max
        self.hysteresis = hysteresis
        self.room = PT1Glied(tau: tau)
    }
    
    /**
     called every update cycle.
     */
    mutating func updateTemperature() -> Double {
        currentTemp = room.integrate(currentTemperature: currentTemp)
        return currentTemp
    }
}
