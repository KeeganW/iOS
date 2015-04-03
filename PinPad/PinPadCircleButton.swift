//
//  PinPadCircleView.swift
//  PinPad
//
//  Created by Keegan Williams on 4/1/15.
//  Copyright (c) 2015 Keegan Williams. All rights reserved.
//

import UIKit

//@IBDesignable

class PinPadCircleButton: UIButton {
    
    override func drawRect(rect: CGRect) {
        let pathWidth: CGFloat = 2.0

        var path = UIBezierPath(arcCenter: CGPoint(x: bounds.width/2, y: bounds.height/2), radius: bounds.height/2-pathWidth/2, startAngle: 0, endAngle: 360, clockwise: true)
        path.lineWidth = pathWidth

        UIColor.whiteColor().setStroke()
        path.stroke()

        if highlighted{
            UIColor.whiteColor().setFill()
            path.fill()
        }
    }

}

//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
