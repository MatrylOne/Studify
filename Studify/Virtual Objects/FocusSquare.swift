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
    var isHiden = false
    var isInitiated = false
    
    let plane: SCNNode = {
        let plane = SCNPlane(width: 0.1, height: 0.1)
        let node = SCNNode(geometry: plane)
        node.opacity = 0
        let material = plane.firstMaterial!
        
        material.diffuse.contents = UIColor.white
        material.emission.contents = UIColor.white
        material.ambient.contents = UIColor.black
        material.isDoubleSided = true
        
        node.name = "plane"
        
        return node
    }()
    
    override init() {
        super.init()
        handle.eulerAngles.x = .pi / 2
        handle.addChildNode(plane)
        addChildNode(handle)
        
        isHiden = true
    }
    
    func updateOrientatnion(to position:SCNVector3, camera:ARCamera){
        if self.isInitiated == false{
            show()
            isInitiated = true
        }
        self.position = position
        self.eulerAngles.y = camera.eulerAngles.y
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hide(){
        if !isHiden{
            guard let plane = handle.childNode(withName: "plane", recursively: false) else { return }
            let action = SCNAction.fadeOpacity(to: 0, duration: 0.5)
            plane.runAction(action)
            isHiden = true
        }
    }
    
    func show(){
        if isHiden{
            guard let plane = handle.childNode(withName: "plane", recursively: false) else { return }
            let action = SCNAction.fadeOpacity(to: 0.1, duration: 0.5)
            plane.runAction(action)
            isHiden = false
        }
    }
}
