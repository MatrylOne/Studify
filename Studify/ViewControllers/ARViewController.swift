//
//  ARViewController.swift
//  Studify
//
//  Created by Jakub Nadolny on 15/10/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ARViewController: UIViewController{

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var returnButton: UIButton!
    
    var screenCenter = CGPoint(x: 0, y: 0)
    
    var object:VirtualObject?
    
    let focusSquare = FocusSquare()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        configuration.environmentTexturing = .automatic
        
        setupCamera()
        
        sceneView.session.run(configuration)
        sceneView.delegate = self
        sceneView.session.delegate = self
        
        sceneView.scene.rootNode.addChildNode(focusSquare)
        screenCenter = CGPoint(x: sceneView.bounds.midX, y: sceneView.bounds.midY)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureToSceneView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func addGestureToSceneView(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(ARViewController.addNode(widhGestureRecognizer:)))
        sceneView.addGestureRecognizer(tap)
        tap.numberOfTapsRequired = 1
        
        let rotate = UIPanGestureRecognizer(target: self, action: #selector(ARViewController.rotateNode(withGestureRecognizer:)))
        rotate.minimumNumberOfTouches = 2
        rotate.maximumNumberOfTouches = 3
        
        sceneView.addGestureRecognizer(rotate)
    }
    
    func setupCamera() {
        guard let camera = sceneView.pointOfView?.camera else {
            fatalError("Expected a valid `pointOfView` from the scene.")
        }
        
        camera.wantsHDR = true
        camera.exposureOffset = -1
        camera.minimumExposure = -1
        camera.maximumExposure = 3
    }
    
    func updateFocusSquare(){
        let hitTests = sceneView.hitTest(screenCenter, types: .existingPlaneUsingExtent)
        guard let result = hitTests.first,
        let frame = sceneView.session.currentFrame else { return }
        
        let position = result.worldTransform.translation
        let vector = SCNVector3(position.x, position.y, position.z)
        let camera = frame.camera
        
        focusSquare.updateOrientatnion(to: vector, camera: camera)
        focusSquare.anchor = result.anchor
    }
}
