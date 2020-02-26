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
    
    private var thermostat: Thermostat?
    
    @IBOutlet weak var visualisation: SKView!
    
    @IBOutlet weak var currentTempLabel: UILabel!
     
    @IBOutlet weak var targetTempSlider: UISlider!
    @IBOutlet weak var hysteresisSlider: UISlider!
     
    @IBOutlet weak var targetTempLabel: UILabel!
    @IBOutlet weak var hysteresisLabel: UILabel!
    
    
    override func awakeFromNib() {
        
        thermostat = Thermostat(initialTemp: 19, targetTemp: Double(targetTempSlider!.value), hysteresis: Double(hysteresisSlider!.value), heaterTemp: Double(targetTempSlider!.maximumValue), coolerTemp: Double(targetTempSlider!.minimumValue), tau: 900)
        
        let scene = SKScene(size: CGSize(width: visualisation.frame.width, height: visualisation.frame.height))

        visualisation.presentScene(scene)
        visualisation.delegate = self
        visualisation.scene?.delegate = self
        
        targetTempLabel.text = String(targetTempSlider.value.truncate(places: 2)) + "°"
        hysteresisLabel.text = "∆" + String(hysteresisSlider.value.truncate(places: 2)) + "°"
        
    }
    
    func update(_ currentTime: TimeInterval, for scene: SKScene) {
        
        thermostat!.updateTemperature()
        
        currentTempLabel.text = String(thermostat!.currentTemp.truncate(places: 2)) + "°"
        
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        thermostat!.targetTemp = Double(targetTempSlider.value)
        thermostat!.hysteresis = Double(hysteresisSlider.value)
        
        DispatchQueue.main.async {
            self.targetTempLabel.text = String(self.targetTempSlider.value.truncate(places: 2)) + "°"
            self.hysteresisLabel.text = "∆" + String(self.hysteresisSlider.value.truncate(places: 2)) + "°"
        }
        
        if thermostat!.average > Double(targetTempSlider.value) {
            targetTempSlider.tintColor = .white + ( .orange * ((Double(targetTempSlider.value) - thermostat!.average) / (Double(targetTempSlider.maximumValue) - thermostat!.average)) * 0.7)
        } else {
            targetTempSlider.tintColor = .white + ( .cyan * ((thermostat!.average - (Double(targetTempSlider.value))) / (thermostat!.average - Double(targetTempSlider.minimumValue))) * 0.7)
        }
    }
}
