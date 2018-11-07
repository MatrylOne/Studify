//
//  PhysicalScene.swift
//  Studify
//
//  Created by Jakub Nadolny on 07/11/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import SceneKit

public class PhysicsScene: SCNScene {
    public init(length: CGFloat) {
        super.init()
        initScene(length: length)
    }
    
    public override init() {
        super.init()
        initScene(length: 0.3)
    }
    
    private func initScene(length: CGFloat){
        
        let time = countTime(length: Float(length))
        let object = createPhisical(length: length)
        
        createCamera()
        rootNode.addChildNode(object)
        
        if let handle = object.childNode(withName: "handle", recursively: true){
            handle.runAction(createAnimation(time: time, angle: .pi/30))
        }
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func createCamera(){
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        camera.focalLength = 300
        self.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(0, 0, 3)
    }
    
    private func countTime(length: Float) -> Float{
        return 2 * Float.pi * sqrtf(length/9.8)
    }
    
    public func createPhisical(length: CGFloat) -> SCNNode{
        
        // Properties
        let ballSize = CGFloat(0.02)
        let checkerHeight = 0.002
        let basePlateHeight = 0.01
        let frameThickness = CGFloat(0.005)
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
        
        let ball = SCNSphere(radius: CGFloat(ballSize))
        let ballNode = SCNNode(geometry: ball)
        
        let line = SCNCylinder(radius: 0.001, height: length)
        let lineNode = SCNNode(geometry: line)
        
        // Names
        
        handle.name = "handle"
        holderNode.name = "holder"
        
        // Positioning
        
        leftLegNode.position.z = Float(-frameWidth/2)
        leftLegNode.position.y = Float(height/2) + 1.5 * Float(basePlateHeight)
        
        rightLegNode.position.z = Float(frameWidth/2)
        rightLegNode.position.y = Float(height/2) + 1.5 * Float(basePlateHeight)
        
        basePlateNode.position.y = Float(basePlateHeight)
        
        lineNode.position.y = -1 * Float(length)/2
        
        ballNode.position.y = -1 * Float(length)
        
        handle.position.y = Float(height) + 1.5 * Float(basePlateHeight)
        
        holderNode.position.y = Float(height) + Float(frameThickness/2) + 1.5 * Float(basePlateHeight)
        
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
        
        return node
    }
    
    public func createAnimation(time:Float, angle:Float) -> SCNAction{
        let leftAction = SCNAction.rotateTo(x: 0, y: 0, z: CGFloat(angle), duration: Double(time/2))
        leftAction.timingMode = .easeInEaseOut
        let rightAction = SCNAction.rotateTo(x: 0, y: 0, z: CGFloat(angle * -1), duration: Double(time/2))
        rightAction.timingMode = .easeInEaseOut
        let sequence = SCNAction.sequence([leftAction, rightAction])
        let action = SCNAction.repeatForever(sequence)
        
        return action
    }
    
    
}
