//
//  VirtualObject.swift
//  Studify
//
//  Created by Jakub Nadolny on 31/10/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

class VirtualObject: SCNReferenceNode{
    var anchor: ARAnchor?
    var lastRotation:Float = 0
    
    func rotateY(by rotation: Float, animated:Bool, final:Bool) {
        
        self.eulerAngles.y = lastRotation + rotation
        if final{
            lastRotation = self.eulerAngles.y
        }
    }
    
    func animateHandle(){
        let time = calculateTime(lenght: 30)
        let angle = 0.05 * CGFloat.pi
        guard let object = self.childNodes.first, let handle = object.childNode(withName: "handle", recursively: false) else { return }
        handle.runAction(getAnimation(duration: time, angle: angle))
    }
    
    func getAnimation(duration:Double, angle:CGFloat) -> SCNAction{
        let resetRotation = SCNAction.rotateTo(x: 0, y: 0, z: angle * -1.0, duration: 0)
        let moveRight = SCNAction.rotateTo(x: 0, y: 0, z: angle, duration: duration/2)
        moveRight.timingMode = .easeInEaseOut
        let moveLeft = SCNAction.rotateTo(x: 0, y: 0, z: angle * -1.0, duration: duration/2)
        moveLeft.timingMode = .easeInEaseOut
        let moveSequence = SCNAction.sequence([resetRotation, moveRight, moveLeft])
        let moveLoop = SCNAction.repeatForever(moveSequence)
        
        return moveLoop
    }
    
    func calculateTime(lenght:Double) -> Double{
        let g = Double(9.80665)
        return 2*Double.pi * sqrt(lenght / g)
    }
    
    func move(to position:SCNVector3, animated:Bool){
        if animated{
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            self.position = position
            SCNTransaction.commit()
        }else{
            self.position = position
        }
    }
    
    func fitToAnchor(requestAnchor:ARAnchor){
        guard let anchor = self.anchor else {return}
        if anchor == requestAnchor{
            let newY = requestAnchor.transform.translation.y
            let difference = abs(self.position.y - newY)
            if difference > 0.001 && difference < 0.02{
                self.anchor = requestAnchor
                print("updated from \(self.position.y) to \(newY)")
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.1
                self.position.y = newY
                SCNTransaction.commit()
            }
        }
    }
}
