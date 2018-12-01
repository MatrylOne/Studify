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

class ARExperimentViewController: UIViewController{

    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var returnButton: UIButton!
    
    var screenCenter = CGPoint.zero
    var object:VirtualObjectNode?
    
    let focusSquare = FocusSquareNode()
    var model:ExperimentModel?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupCamera()
        setupAR()
        
        screenCenter = CGPoint(x: sceneView.bounds.midX, y: sceneView.bounds.midY)
        sceneView.scene.rootNode.addChildNode(focusSquare)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureToSceneView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
        object = nil
    }
    
    func setupAR(){
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        configuration.environmentTexturing = .automatic
        sceneView.delegate = self
        sceneView.session.delegate = self
        sceneView.session.run(configuration)
    }
    
    func addGestureToSceneView(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(ARExperimentViewController.addNode(widhGestureRecognizer:)))
        sceneView.addGestureRecognizer(tap)
        tap.numberOfTapsRequired = 1
        
        let rotate = UIPanGestureRecognizer(target: self, action: #selector(ARExperimentViewController.rotateNode(withGestureRecognizer:)))
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMeasures"{
            guard let navigation = segue.destination as? UINavigationController,
                let controller = navigation.topViewController as? ExperimentSummaryViewController
                else { return }
            controller.model = self.model
        }
    }
}
