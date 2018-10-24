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

class ARViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var returnButton: UIButton!
    
    var object:SCNNode?
    
    var screenCenter: CGPoint {
        let bounds = sceneView.bounds
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
        sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
        sceneView.delegate = self
        sceneView.session.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureToSceneView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
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
                guard let aircraftScene = SCNScene(named: "art.scnassets/ship.scn"),
                    let aircraftNode = aircraftScene.rootNode.childNodes.first
                    else {return}
                
                aircraftNode.position = SCNVector3(x, y, z)
                aircraftNode.scale = SCNVector3(0.4, 0.4, 0.4)
                self.object = aircraftNode
                self.sceneView.scene.rootNode.addChildNode(aircraftNode)
            }
        }else{
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            object!.position = SCNVector3(x, y ,z)
            SCNTransaction.commit()
        }
    }
    
    func addGestureToSceneView(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ARViewController.addAircraft(widhGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupCamera() {
        guard let camera = sceneView.pointOfView?.camera else {
            fatalError("Expected a valid `pointOfView` from the scene.")
        }
        
        /*
         Enable HDR camera settings for the most realistic appearance
         with environmental lighting and physically based materials.
         */
        camera.wantsHDR = true
        camera.exposureOffset = -1
        camera.minimumExposure = -1
        camera.maximumExposure = 3
    }

}
