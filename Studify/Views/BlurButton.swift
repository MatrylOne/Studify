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
        
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blur.frame = self.bounds
        blur.isUserInteractionEnabled = false
        
        self.insertSubview(blur, at: 0)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
}
