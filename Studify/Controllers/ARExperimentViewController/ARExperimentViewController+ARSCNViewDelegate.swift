//
//  ARViewController+ARSCNViewDelegate.swift
//  Studify
//
//  Created by Jakub Nadolny on 31/10/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import Foundation
import ARKit

extension ARExperimentViewController: ARSCNViewDelegate, ARSessionDelegate{
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        self.updateFocusSquare()
        
        if let object = self.object, let pendulum = object.node as? PendulumNode{
            pendulum.tickOnZero()
            
            guard let frame = sceneView.session.currentFrame else { return }
            let camera = frame.camera
            let lengthFromNode = (object.position - focusSquare.position).length()
            let lengthFromCamera = (focusSquare.position - SCNVector3(camera.transform.translation)).length()
            
            if lengthFromNode < 0.2 || lengthFromCamera > 2 {
                focusSquare.hide()
            }else{
                focusSquare.show()
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        object?.fitToAnchor(requestAnchor: anchor)
    }
}
