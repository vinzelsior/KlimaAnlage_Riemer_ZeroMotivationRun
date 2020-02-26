//
//  RoomRepresentationCell.swift
//  KlimaanlageRiemer_ZeroMotivationRun
//
//  Created by Cedric Zwahlen on 26.02.20.
//  Copyright © 2020 Cedric Zwahlen. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class RoomRepresentationCell: UICollectionViewCell, SKViewDelegate, SKSceneDelegate {
    
    var thermostat: Thermostat?
    
    @IBOutlet weak var visualisation: SKView!
    
    @IBOutlet weak var currentTempLabel: UILabel!
     
    @IBOutlet weak var targetTempSlider: UISlider!
    @IBOutlet weak var hysteresisSlider: UISlider!
     
    @IBOutlet weak var targetTempLabel: UILabel!
    @IBOutlet weak var hysteresisLabel: UILabel!
    
    
    override func awakeFromNib() {
        
        thermostat = Thermostat(initialTemp: 19, targetTemp: Double(targetTempSlider!.value), hysteresis: Double(hysteresisSlider!.value), outsideTemp: 15, heaterTemp: Double(targetTempSlider!.maximumValue), coolerTemp: Double(targetTempSlider!.minimumValue), tau: 120)
        
        let scene = SKScene(size: CGSize(width: visualisation.frame.width, height: visualisation.frame.height))

        visualisation.presentScene(scene)
        visualisation.delegate = self
        visualisation.scene?.delegate = self
    }
    
    func update(_ currentTime: TimeInterval, for scene: SKScene) {
        
        thermostat!.targetTemp = Double(targetTempSlider.value)
        thermostat!.hysteresis = Double(hysteresisSlider.value)
        
        thermostat!.updateTemperature()
        
//        technically, i wouldn't need this function to update these values... but I might as well.
        currentTempLabel.text = String(thermostat!.currentTemp.truncate(places: 2))
        targetTempLabel.text = String(targetTempSlider.value.truncate(places: 2))
        hysteresisLabel.text = String(hysteresisSlider.value.truncate(places: 2))
        
    }
}
