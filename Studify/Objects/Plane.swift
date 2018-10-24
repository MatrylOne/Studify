//
//  Plane.swift
//  Studify
//
//  Created by Jakub Nadolny on 23/10/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class Plane: SCNNode {
    var anchorPlane: ARPlaneAnchor
    
    var planeGeometry: SCNPlane
    var planeNode: SCNNode
    
    init(_ anchor: ARPlaneAnchor) {
        anchorPlane = anchor
        planeGeometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        planeNode = SCNNode(geometry: planeGeometry)
        
        super.init()
        
        let grid = UIImage(named: "grid")
        let material = SCNMaterial()
        material.diffuse.contents = grid
        material.transparency = 0.5
        
        material.diffuse.wrapS = .repeat
        material.diffuse.wrapT = .repeat
        
        material.diffuse.contentsTransform = SCNMatrix4MakeScale(10, 10, 0)
        
        planeGeometry.materials = [material]
        
        planeNode.eulerAngles.x =  -1 * Float.pi / 2
        planeNode.position.x = anchorPlane.center.x
        planeNode.position.y = anchorPlane.center.y
        planeNode.position.z = anchorPlane.center.z
        
        self.addChildNode(planeNode)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(anchor:ARPlaneAnchor){
        planeGeometry.width = CGFloat(anchor.extent.x)
        planeGeometry.height = CGFloat(anchor.extent.z)
        
        planeNode.position.x = anchor.center.x
        planeNode.position.y = anchor.center.y
        planeNode.position.z = anchor.center.z
    }
    
    
}
