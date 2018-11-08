//
//  FocusSquare.swift
//  Studify
//
//  Created by Jakub Nadolny on 31/10/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import Foundation
import ARKit

class FocusSquare: SCNNode{
    
    let handle = SCNNode()
    var anchor: ARAnchor?
    
    let plane: SCNNode = {
        let plane = SCNPlane(width: 0.1, height: 0.1)
        let node = SCNNode(geometry: plane)
        node.opacity = 0.05
        let material = plane.firstMaterial!
        
        material.diffuse.contents = UIColor.white
        material.emission.contents = UIColor.white
        material.ambient.contents = UIColor.black
        material.isDoubleSided = true
        
        return node
    }()
    
    override init() {
        super.init()
        handle.eulerAngles.x = .pi / 2
        handle.addChildNode(plane)
        addChildNode(handle)
    }
    
    func updateOrientatnion(to position:SCNVector3, camera:ARCamera){
        handle.position = position
        handle.eulerAngles.y = camera.eulerAngles.y
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
