//
//  BigCoverButton.swift
//  Studify
//
//  Created by Jakub Nadolny on 16/10/2018.
//  Copyright © 2018 Jakub Nadolny. All rights reserved.
//

import UIKit

class BigCoverButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        imageView?.contentMode = .scaleAspectFill
    }

}
