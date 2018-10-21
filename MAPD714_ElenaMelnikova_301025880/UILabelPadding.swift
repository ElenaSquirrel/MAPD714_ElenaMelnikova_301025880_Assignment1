
//  UILabelPadding.swift
//  MAPD714_ElenaMelnikova_301025880

//  Basic Calculator version 1.0
//  Created by Elena Melnikova on 2018-09-26.
//  Student ID: 301025880
//  Last modification date: 2018-10-21
//  Copyright © 2018 Centennial College. All rights reserved.

import UIKit
import Foundation

// UILabel padding https://stackoverflow.com/questions/40405711/uilabel-border-and-padding

// Used for setting constrains for buttons and label (Storyboard Equal Height Equal Width Horizontal Vertical Spacing) https://www.youtube.com/watch?v=LSV6VcGdXPc

class UILabelPadding: UILabel {
    
    let padding = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, padding))
    }
    
    override var intrinsicContentSize : CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
}
