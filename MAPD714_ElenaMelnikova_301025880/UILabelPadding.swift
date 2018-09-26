//
//  UILabelPadding.swift
//  MAPD714_ElenaMelnikova_301025880
//
//  Created by Elena Melnikova on 2018-09-26.
//  Copyright © 2018 Centennial College. All rights reserved.
//
import UIKit
import Foundation

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
