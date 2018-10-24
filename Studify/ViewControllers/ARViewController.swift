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

class ARViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var returnButton: UIButton!
    
    var planes = [ARPlaneAnchor:Plane]()
    
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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureToSceneView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        DispatchQueue.main.async {
            guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
            self.addPlane(node: node, anchor: planeAnchor)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.main.async {
            guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
            self.updatePlane(anchor: planeAnchor)
        }
    }
    
    func addPlane(node:SCNNode, anchor:ARPlaneAnchor){
//        let plane = Plane(anchor)
//        planes[anchor] = plane
//        node.addChildNode(plane)
    }
    
    func updatePlane(anchor:ARPlaneAnchor){
//        let plane = planes[anchor]
//        plane?.update(anchor: anchor)
    }
    
    @objc func addAircraft(widhGestureRecognizer recognizer:UIGestureRecognizer){
        let taplocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(taplocation, types: .existingPlaneUsingExtent)
        
        
        guard let hitTestResult = hitTestResults.first else { return }
        let transform = hitTestResult.worldTransform
        let x = transform.columns.3.x
        let y = transform.columns.3.y
        let z = transform.columns.3.z
        
        
        print(x, y ,z)
        
        guard let aircraftScene = SCNScene(named: "art.scnassets/ship.scn"),
            let aircraftNode = aircraftScene.rootNode.childNodes.first
            else {return}
        
        aircraftNode.position = SCNVector3(x, y, z)
        aircraftNode.scale = SCNVector3(0.4, 0.4, 0.4)
        sceneView.scene.rootNode.addChildNode(aircraftNode)
        
        print("added")
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
