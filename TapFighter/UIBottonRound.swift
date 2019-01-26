//
//  UIBottonRound.swift
//  TapFighter
//
//  Created by Thobio Joseph on 05/10/17.
//  Copyright © 2017 Love2Code. All rights reserved.
//

import UIKit

class UIButtonRound:UIButton{
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10.0
        layer.borderWidth = 1/UIScreen.main.nativeScale
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
}
