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
        let position = focusSquare.handle.position
        
        if object == nil{
            DispatchQueue.main.async {
                guard let loadedScene = SCNScene(named: "art.scnassets/physical.scn"),
                    let loadedNode = loadedScene.rootNode.childNodes.first
                    else {return}
                
                let object = VirtualObject()
                object.addChildNode(loadedNode)
                object.move(to: position, animated: false)
                object.animateHandle()
                object.anchor = self.focusSquare.anchor
                self.object = object
                self.sceneView.scene.rootNode.addChildNode(object)
            }
        }else{
            object?.move(to: position, animated: true)
            object?.anchor = focusSquare.anchor
        }
    }
    
    @objc func rotateAirCraft(withGestureRecognizer recognizer:UIPanGestureRecognizer){
        guard let node = object else { return }
        let translation = recognizer.translation(in: sceneView)
        let angleY = (Float)(translation.x) * (Float)(Double.pi) / 180.0
        
        if recognizer.state == .changed{
            node.rotateY(by: angleY, animated: true, final: false)
        }else if recognizer.state == .ended{
            node.rotateY(by: angleY, animated: true, final: true)
        }
    }
}
