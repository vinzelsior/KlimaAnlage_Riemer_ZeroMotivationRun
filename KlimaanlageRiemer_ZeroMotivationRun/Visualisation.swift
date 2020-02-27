//
//  Visualisation.swift
//  KlimaanlageRiemer_ZeroMotivationRun
//
//  Created by Cedric Zwahlen on 26.02.20.
//  Copyright © 2020 Cedric Zwahlen. All rights reserved.
//

import Foundation
import SpriteKit

struct Visualisation {
    
    private let heaterNode = SKSpriteNode(texture: SKTexture(image: UIImage.init(systemName: "chevron.up.square.fill")!))
    private let coolerNode = SKSpriteNode(texture: SKTexture(image: UIImage.init(systemName: "chevron.down.square.fill")!))
    
    let scene: SKScene
    
    init(scene: SKScene) {
        self.scene = scene
        
        heaterNode.isHidden = true
        coolerNode.isHidden = true
        
        heaterNode.position = CGPoint(x: scene.frame.width / 2, y: scene.frame.height / 2)
        coolerNode.position = CGPoint(x: scene.frame.width / 2, y: scene.frame.height / 2)
        
        self.scene.addChild(heaterNode)
        self.scene.addChild(coolerNode)
        
    }
    
    func visualise(isCooling: Bool, isHeating: Bool) {
        heaterNode.isHidden = !isHeating
        coolerNode.isHidden = !isCooling
    }
    
}
