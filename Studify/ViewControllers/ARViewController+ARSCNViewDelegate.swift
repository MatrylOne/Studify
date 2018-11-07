//
//  ARViewController+ARSCNViewDelegate.swift
//  Studify
//
//  Created by Jakub Nadolny on 31/10/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import Foundation
import ARKit

extension ARViewController: ARSCNViewDelegate, ARSessionDelegate{
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        self.updateFocusSquare()
        if let node = self.object{
            if let handle = node.childNode(withName: "handle", recursively: true){
                let currentRotation = handle.eulerAngles.z
                if node.lastRotation > 0 && currentRotation < 0{
                    let audio = SCNAudioSource(fileNamed: "tick.mp3")!
                    let play = SCNAction.playAudio(audio, waitForCompletion: false)
                    node.runAction(play)
                    
                }
                node.lastRotation = currentRotation
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        object?.fitToAnchor(requestAnchor: anchor)
    }
}
