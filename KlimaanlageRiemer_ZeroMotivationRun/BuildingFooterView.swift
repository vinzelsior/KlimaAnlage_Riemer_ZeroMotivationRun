//
//  BuildingFooterView.swift
//  KlimaanlageRiemer_ZeroMotivationRun
//
//  Created by Cedric Zwahlen on 27.02.20.
//  Copyright © 2020 Cedric Zwahlen. All rights reserved.
//

import Foundation
import UIKit

class BuildingFooterView: UICollectionReusableView {
    
    @IBOutlet weak var outsideTempLabel: UILabel!
    @IBOutlet weak var outsideTempSlider: UISlider!
    
    override func awakeFromNib() {
        outsideTempLabel.text = String(outsideTempSlider.value.truncate(places: 2)) + "°"
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        Thermostat.outsideTemp = Double(sender.value)
        outsideTempLabel.text = String(sender.value.truncate(places: 2)) + "°"
    }
}
