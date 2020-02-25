//
//  PT1Glied.swift
//  KlimaanlageRiemer_ZeroMotivationRun
//
//  Created by Cedric Zwahlen on 25.02.20.
//  Copyright © 2020 Cedric Zwahlen. All rights reserved.
//

import Foundation

/// This structure simulates the latency of the heating or cooling process applied to a sink that occurs naturally when changing the temperature of a temperature medium applied to said sink. This sentence has been brought to you by: absolutely unintelligible. Basically, it represents the room y'all.
struct PT1Glied {
    
    /// time component which determines the speed of integration
    private var dF_tau: Double
    /// the previous value
    private var dLastFV: Double
    /// an internal value, which is immutable after initialisation
    private let dExpRate: Double

    
    /**
     
     The initialiser sets up the speed of the integration. For the example of a large room, tau would be large. For a small one, tau would be small.
     
    - Parameter tau: specifies the speed at which a value is integrated.
     
*/
    init(tau: Double = 120) {
        dF_tau = tau
        dLastFV = 0
        
        dExpRate = pow(2.718282, -0.1 / dF_tau)
    }
    
    mutating func integrate(currentTemperature: Double) -> Double {
       
        let dFiltOut = dLastFV * dExpRate + (currentTemperature * (1 - dExpRate))
        
        dLastFV = dFiltOut
        
        return dFiltOut
    }
}
