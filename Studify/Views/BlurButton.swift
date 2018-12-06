//
//  BlurButton.swift
//  Studify
//
//  Created by Jakub Nadolny on 16/10/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import UIKit

class BlurButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor(white: 1, alpha: 0.4)
        self.imageView?.bringSubviewToFront(self)
    }
    
}
