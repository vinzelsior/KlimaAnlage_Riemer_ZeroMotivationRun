//
//  Extension.swift
//  KlimaanlageRiemer_ZeroMotivationRun
//
//  Created by Cedric Zwahlen on 26.02.20.
//  Copyright © 2020 Cedric Zwahlen. All rights reserved.
//

import Foundation

extension Double
{
    func truncate(places : Int)-> Double
    {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

extension Float
{
    func truncate(places : Int)-> Float
    {
        return Float(floor(pow(10.0, Float(places)) * self)/pow(10.0, Float(places)))
    }
}
