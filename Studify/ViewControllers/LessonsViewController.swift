//
//  LessonsViewController.swift
//  Studify
//
//  Created by Jakub Nadolny on 12/10/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

private let lessons = [
    Lesson(name: "Grawitacja", description: "Lekcja o grawitacji", instruction: "Rzuć kulką"),
    Lesson(name: "Ruch harmoniczny", description: "Lekcja o ruchu harmonicznym", instruction: "Rusz wahadłem")
]

class LessonsViewController: UICollectionViewController {
    
    var selectedModel = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? LessonDetailViewController
        controller?.model = lessons[selectedModel]
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return lessons.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LessonsViewCell
        // Configure the cell
        
        let lesson = lessons[indexPath.row]
        
        cell.label.text = lesson.name
        cell.label.textColor = .black
        cell.color.backgroundColor = UIColor(white: 0.95, alpha: 1)
        cell.layer.cornerRadius = 10
    
        return cell
    }

    // MARK: UICollectionViewDelegate
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

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedModel = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }

}
