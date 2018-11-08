//
//  PendulumNode.swift
//  Studify
//
//  Created by Jakub Nadolny on 08/11/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import UIKit
import SceneKit

class PendulumNode: SCNNode {
    
    let length:CGFloat
    var lastRotation:Float = 0
    
    let playTick = SCNAction.playAudio(SCNAudioSource(fileNamed: "tick.mp3")!, waitForCompletion: false)
    
    init(length: CGFloat){
        self.length = length
        super.init()
        addChildNode(build(length: self.length))
    }
    
    override init() {
        self.length = 0.2
        super.init()
        addChildNode(build(length: self.length))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func build(length: CGFloat) -> SCNNode{
        // Properties
        let ballSize = Settings.Pendulum.ballSize
        let checkerHeight = Settings.Pendulum.checkerHeight
        let basePlateHeight = Settings.Pendulum.basePlateHeight
        let frameThickness = Settings.Pendulum.frameThickness
        
        let height = length + ballSize + CGFloat(checkerHeight)
        let frameWidth = ballSize * 4
        
        // Nodes
        let node = SCNNode()
        let handle = SCNNode()
        
        let leftLeg = SCNBox(width: frameThickness, height: height, length: frameThickness, chamferRadius: frameThickness/8)
        let leftLegNode = SCNNode(geometry: leftLeg)
        
        let rightLeg = SCNBox(width: frameThickness, height: height, length: frameThickness, chamferRadius: frameThickness/8)
        let rightLegNode = SCNNode(geometry: rightLeg)
        
        let basePlate = SCNBox(width: frameWidth, height: CGFloat(basePlateHeight), length: frameWidth + frameThickness, chamferRadius: frameThickness/8)
        let basePlateNode = SCNNode(geometry: basePlate)
        
        let checker = SCNBox(width: CGFloat(checkerHeight), height: CGFloat(checkerHeight), length: frameWidth, chamferRadius: frameThickness/8)
        let checkerNode = SCNNode(geometry: checker)
        
        let holder = SCNBox(width: frameThickness, height: frameThickness, length: frameWidth + frameThickness, chamferRadius: frameThickness/8)
        let holderNode = SCNNode(geometry: holder)
        
        let ball = SCNSphere(radius: ballSize)
        let ballNode = SCNNode(geometry: ball)
        
        let line = SCNCylinder(radius: 0.001, height: length)
        let lineNode = SCNNode(geometry: line)
        
        // Names
        handle.name = "handle"
        
        // Positioning
        leftLegNode.position.z = Float(-frameWidth/2)
        leftLegNode.position.y = Float(height/2) + Float(basePlateHeight)
        
        rightLegNode.position.z = Float(frameWidth/2)
        rightLegNode.position.y = Float(height/2) + Float(basePlateHeight)
        
        basePlateNode.position.y = Float(basePlateHeight/2)
        
        lineNode.position.y = -1 * Float(length)/2
        
        ballNode.position.y = -1 * Float(length)
        
        handle.position.y = Float(height) + Float(basePlateHeight)
        
        holderNode.position.y = Float(height) + Float(frameThickness/2) +  Float(basePlateHeight)
        
        checkerNode.position.y = Float(basePlateHeight/2) + Float(checkerHeight/2)
        
        // Materials
        checker.firstMaterial?.diffuse.contents = UIColor.red
        basePlate.firstMaterial?.diffuse.contents = UIColor(white: 0.3, alpha: 1)
        line.firstMaterial?.diffuse.contents = UIColor(white: 0.3, alpha: 1)
        
        ball.firstMaterial?.diffuse.contents = UIColor(white: 0.8, alpha: 1)
        
        // Connecting
        node.addChildNode(leftLegNode)
        node.addChildNode(rightLegNode)
        basePlateNode.addChildNode(checkerNode)
        handle.addChildNode(lineNode)
        handle.addChildNode(ballNode)
        node.addChildNode(handle)
        node.addChildNode(holderNode)
        node.addChildNode(basePlateNode)
        node.name = "pendulum"
        
        return node
    }
    
    public func tickOnZero(){
        guard let pendulum = childNode(withName: "pendulum", recursively: false),
            let handle = pendulum.childNode(withName: "handle", recursively: false)
            else { return }
        
        let currentRotation = handle.eulerAngles.z
        if self.lastRotation > 0 && currentRotation < 0{
            DispatchQueue.main.async {
                self.runAction(self.playTick)
            }
        }
        self.lastRotation = currentRotation
    }
    
    public func animate(){
        guard let pendulum = childNode(withName: "pendulum", recursively: false),
            let handle = pendulum.childNode(withName: "handle", recursively: false)
            else { return }
        
        let time = calculateTime(length: self.length)
        let angle = Settings.Pendulum.angle
        
        handle.runAction(createAnimation(time: time, angle: angle))
    }
    
    private func createAnimation(time:CGFloat, angle:CGFloat) -> SCNAction{
        let leftAction = SCNAction.rotateTo(x: 0, y: 0, z: CGFloat(angle), duration: Double(time/2))
        leftAction.timingMode = .easeInEaseOut
        let rightAction = SCNAction.rotateTo(x: 0, y: 0, z: CGFloat(angle * -1), duration: Double(time/2))
        rightAction.timingMode = .easeInEaseOut
        let sequence = SCNAction.sequence([leftAction, rightAction])
        let action = SCNAction.repeatForever(sequence)
        
        return action
    }
    
    private func calculateTime(length: CGFloat) -> CGFloat{
        return 2 * CGFloat.pi * sqrt(length/9.8)
    }
}
