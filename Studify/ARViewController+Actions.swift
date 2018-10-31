//
//  ARViewController+Actions.swift
//  Studify
//
//  Created by Jakub Nadolny on 31/10/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import Foundation
import ARKit

extension ARViewController{
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @objc func addAircraft(widhGestureRecognizer recognizer:UIGestureRecognizer){
        let taplocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(taplocation, types: .existingPlaneUsingExtent)
        
        guard let hitTestResult = hitTestResults.first else { return }
        
        let transform = hitTestResult.worldTransform.translation
        let x = transform.x
        let y = transform.y
        let z = transform.z
        
        if object == nil{
            DispatchQueue.main.async {
                guard let aircraftScene = SCNScene(named: "art.scnassets/physical.scn"),
                    let aircraftNode = aircraftScene.rootNode.childNodes.first
                    else {return}
                
                aircraftNode.position = SCNVector3(x, y, z)
                self.sceneView.scene.rootNode.addChildNode(aircraftNode)
                self.object = aircraftNode
                let handle = aircraftNode.childNode(withName: "handle", recursively: false)
                guard let h = handle else { return }
                print("handle found")
                h.runAction(self.animate(duration: self.calculateTime(lenght: 30), angle: CGFloat.pi/18))
            }
        }else{
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            self.object!.position = SCNVector3(x, y ,z)
            SCNTransaction.commit()
        }
    }
    
    @objc func rotateAirCraft(withGestureRecognizer recognizer:UIPanGestureRecognizer){
        guard let node = object else { return }
        let translation = recognizer.translation(in: sceneView)
        let angleY = (Float)(translation.x) * (Float)(Double.pi) / 180.0 + currentRotation
        SCNTransaction.begin()
        if recognizer.state == .changed{
            SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: .linear)
            SCNTransaction.animationDuration = 0.1
            node.eulerAngles.y = angleY
        }else if recognizer.state == .ended{
            SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: .easeOut)
            SCNTransaction.animationDuration = 0.5
            node.eulerAngles.y = angleY
            currentRotation = node.eulerAngles.y
        }
        SCNTransaction.commit()
    }
    
    func animate(duration:Double, angle:CGFloat) -> SCNAction{
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
}
