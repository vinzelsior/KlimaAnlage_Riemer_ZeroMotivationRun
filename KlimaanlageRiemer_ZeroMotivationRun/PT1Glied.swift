//
//  PT1Glied.swift
//  KlimaanlageRiemer_ZeroMotivationRun
//
//  Created by Cedric Zwahlen on 25.02.20.
//  Copyright © 2020 Cedric Zwahlen. All rights reserved.
//

import Foundation

/// This structure simulates the latency of the heating or cooling process applied to a sink that occurs naturally when changing it's temperature. This sentence has been brought to you by: absolutely unintelligible. Basically, it represents the room y'all.
struct PT1Glied {
    
    /// Time component which determines the speed of integration
    private var dF_tau: Double
    /// The previous value
    private var dLastFV: Double
    /// An internal value, which is immutable after initialisation.
    private let dExpRate: Double

    
    /**
     
     The initialiser sets up the speed of the integration. For the example of a large room, tau would be large. For a small one, tau would be small.
     
    - Parameter tau: specifies the speed at which a value is integrated.
     
*/
    init(tau: Double, initialVal: Double) {
        dF_tau = tau
        dLastFV = initialVal
        
        dExpRate = pow(2.718282, -0.1 / dF_tau)
    }
    
    /**
         
            This function takes the new value, integrates it, and returns the altered value.
         
     - Parameter currentTemperature: the new value to integrate
         
*/
    mutating func integrate(currentTemperature: Double) -> Double {
       
        let dFiltOut = dLastFV * dExpRate + (currentTemperature * (1 - dExpRate))
        
        dLastFV = dFiltOut
        
        return dFiltOut
    }
}
