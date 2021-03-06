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


/// This class displays all information generated by the thermostat in the collectionview.
class RoomRepresentationCell: UICollectionViewCell, SKViewDelegate, SKSceneDelegate {
    
    private var thermostat: Thermostat?
    private var roomSimulation: Visualisation?
    
    @IBOutlet weak var visualisation: SKView!
    
    @IBOutlet weak var currentTempLabel: UILabel!
     
    @IBOutlet weak var targetTempSlider: UISlider!
    @IBOutlet weak var hysteresisSlider: UISlider!
     
    @IBOutlet weak var targetTempLabel: UILabel!
    @IBOutlet weak var hysteresisLabel: UILabel!
    
    // sets up the thermostat and visual elements
    override func awakeFromNib() {
        
        thermostat = Thermostat(initialTemp: 19, targetTemp: Double(targetTempSlider!.value), hysteresis: Double(hysteresisSlider!.value), heaterTemp: Double(targetTempSlider!.maximumValue), coolerTemp: Double(targetTempSlider!.minimumValue))
        
        let scene = SKScene(size: CGSize(width: visualisation.frame.width, height: visualisation.frame.height))
        scene.scaleMode = .aspectFill
        
        roomSimulation = Visualisation(scene: scene)

        visualisation.presentScene(scene)
        visualisation.delegate = self
        visualisation.scene?.delegate = self
        
        visualisation.scene?.backgroundColor = .systemBackground
        
        targetTempSlider.tintColor = .white
        
        targetTempLabel.text = String(targetTempSlider.value.truncate(places: 2)) + "°"
        hysteresisLabel.text = "∆" + String(hysteresisSlider.value.truncate(places: 2)) + "°"
        
    }
    
    // called for every frame, so about 60 times per second
    func update(_ currentTime: TimeInterval, for scene: SKScene) {

        // calculates new temperature
        thermostat!.updateTemperature()
        
        // displays the new value
        currentTempLabel.text = String(thermostat!.currentTemp.truncate(places: 2)) + "°"
        
        // decides whether it has to heat or cool, and displays the result
        roomSimulation?.visualise(isCooling: thermostat!.cool, isHeating: thermostat!.heat)
        
    }
    
    // called when any of the sliders value change
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        thermostat!.targetTemp = Double(targetTempSlider.value)
        thermostat!.hysteresis = Double(hysteresisSlider.value)
        
        // apply on main thread
        DispatchQueue.main.async {
            self.targetTempLabel.text = String(self.targetTempSlider.value.truncate(places: 2)) + "°"
            self.hysteresisLabel.text = "∆" + String(self.hysteresisSlider.value.truncate(places: 2)) + "°"
        }
        
        // change the color of the slider, to represent temp visually also.
        if thermostat!.average > Double(targetTempSlider.value) {
            targetTempSlider.tintColor = .white + ( .orange * ((Double(targetTempSlider.value) - thermostat!.average) / (Double(targetTempSlider.maximumValue) - thermostat!.average)) * 0.7)
        } else {
            targetTempSlider.tintColor = .white + ( .cyan * ((thermostat!.average - (Double(targetTempSlider.value))) / (thermostat!.average - Double(targetTempSlider.minimumValue))) * 0.7)
        }
    }
}
