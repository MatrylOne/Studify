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
    var isRotationPositive = true
    
    func rotateY(by rotation: Float, animated:Bool, final:Bool) {
        
        self.eulerAngles.y = lastRotation + rotation
        if final{
            lastRotation = self.eulerAngles.y
        }
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
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.1
                self.position.y = newY
                SCNTransaction.commit()
            }
        }
    }
}
