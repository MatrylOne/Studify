//
//  LessonsViewController.swift
//  Studify
//
//  Created by Jakub Nadolny on 12/10/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import UIKit

class LessonsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Consts
    private let reuseIdentifier = "cell"
    
    // MARK: - Class properties
    var selectedLessonId = 0

    // MARK: - Class main methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    // MARK: - Navigation methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? LessonDetailViewController
        controller?.model = ExperimentModel(lesson: DataStorage.LessonsData.lessons[selectedLessonId])
        controller?.model?.pendulumModel = PendulumModel()
    }
    
    @IBAction func unwindToMain(_ sender:UIStoryboardSegue){}
    
    // MARK: - Collection View methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32
        return CGSize(width: width, height: width/4)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LessonsViewCell
        
        let lesson = DataStorage.LessonsData.lessons[indexPath.row]
        cell.label.text = lesson.name
        cell.image.image = UIImage(named: lesson.image)
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedLessonId = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return DataStorage.LessonsData.lessons.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return true
    }

}
