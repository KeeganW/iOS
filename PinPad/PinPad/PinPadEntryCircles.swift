//
//  PinPadEntryCircles.swift
//  PinPad
//
//  Created by Keegan Williams on 4/1/15.
//  Copyright (c) 2015 Keegan Williams. All rights reserved.
//

import UIKit

class PinPadEntryCircles: UIView {

    var numberOfCircles: Double = 4.0
    var spacing: Double = 40.0
    var enteredNumbers: Int = 0
    
    override func drawRect(rect: CGRect) {
        let offset = (Double(bounds.width) - spacing*(numberOfCircles-1))/2
        
        let pathWidth: CGFloat = 1.0
        
        // Loop through all the circles
        for increment in 0...Int(numberOfCircles - 1) {
            // Draw each circle
            let x = CGFloat(offset + (spacing * Double(increment)))
            var path = UIBezierPath(arcCenter: CGPoint(x: x, y: bounds.height/2), radius: bounds.height/2-pathWidth/2, startAngle: 0, endAngle: 360, clockwise: true)
            path.lineWidth = pathWidth
            
            UIColor.whiteColor().setStroke()
            path.stroke()
            
            // Fill the circles if needed
            if (enteredNumbers > increment){
                UIColor.whiteColor().setFill()
                path.fill()
            }
            
        }
        
        

    }

}
