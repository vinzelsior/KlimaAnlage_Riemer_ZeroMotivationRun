//
//  Thermostat.swift
//  KlimaanlageRiemer_ZeroMotivationRun
//
//  Created by Cedric Zwahlen on 25.02.20.
//  Copyright © 2020 Cedric Zwahlen. All rights reserved.
//

import Foundation

struct Thermostat {
    
    static var outsideTemp: Double = 15
    
    // MARK: Public Fields
    
    var currentTemp: Double
    
///   helper variable, to reduce recalcualtion 
    var average: Double
    
    var targetTemp: Double {
        didSet {
            recalculateMinMax()
        }
    }
    var hysteresis: Double {
        didSet {
            recalculateMinMax()
        }
    }
    
    var cool: Bool {
        mutating get {
            // upper threshold
            cooling = currentTemp > max ? true : cooling
            // lower threshold
            cooling = currentTemp < min ? false : cooling
            // error mitigation
//            cooling = actionIsValid()
            
            return cooling
        }
    }
    
    var heat: Bool {
        mutating get {
            // upper threshold
            heating = currentTemp > max ? false : heating
            // lower threshold
            heating = currentTemp < min ? true : heating
            // error mitigation
//            heating = actionIsValid()
            
            return heating
        }
    }
    
    // MARK: Private Fields
    
    private var min: Double
    private var max: Double
    private var cooling = false
    private var heating = false
    
    private var heaterTemp: Double
    private var coolerTemp: Double
    
    /// represents the room, which the thermostat controls the temperature of.
    private var room: PT1Glied
    
    // MARK: Methods
    
    init(initialTemp: Double, targetTemp: Double, hysteresis: Double, outsideTemp: Double = 15, heaterTemp: Double = 30, coolerTemp: Double = 10, tau: Double = 120) {
        
        self.average = (heaterTemp + coolerTemp) / 2
        
// TO-DO:  implement sanitisation, so make initialiser failable.
        self.targetTemp = targetTemp
        self.currentTemp = initialTemp
        self.min = targetTemp - hysteresis
        self.max = targetTemp + hysteresis
        self.hysteresis = hysteresis
        self.room = PT1Glied(tau: tau, initialVal: initialTemp)
        
        Thermostat.outsideTemp = outsideTemp
        
        self.heaterTemp = heaterTemp
        self.coolerTemp = coolerTemp
    }
    
    /**
     called every update cycle.
     */
    mutating func updateTemperature() {
        
        if      cool { currentTemp = room.integrate(currentTemperature: coolerTemp) }
        else if heat { currentTemp = room.integrate(currentTemperature: heaterTemp) }
        else         { currentTemp = room.integrate(currentTemperature: Thermostat.outsideTemp) }
    }
    
    private mutating func recalculateMinMax() {
        min = (targetTemp - hysteresis) < coolerTemp ? coolerTemp + 0.1 : targetTemp - hysteresis
        max = (targetTemp + hysteresis) > heaterTemp ? heaterTemp - 0.1 : targetTemp + hysteresis
    }
    
    private func actionIsValid() -> Bool {
        if cooling && heating {
//            this condition is unacceptable, so just ignore them both, and do nothing until this situation resolves
            return false
        } else {
            return true
        }
    }
}
