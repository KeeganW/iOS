//
//  PinCircleLayer.swift
//  PinPad
//
//  Created by Keegan Williams on 4/1/15.
//  Copyright (c) 2015 Keegan Williams. All rights reserved.
//

import UIKit
import QuartzCore

class PinCircleLayer: CALayer {
    var highlighted = false
    weak var pinPad: PinPad?
    
    override func drawInContext(ctx: CGContext!) {
        if let slider = pinPad {
            let thumbFrame = bounds.rectByInsetting(dx: 2.0, dy: 2.0)
            let cornerRadius = thumbFrame.height * slider.curvaceousness / 2.0
            let thumbPath = UIBezierPath(roundedRect: thumbFrame, cornerRadius: cornerRadius)
            
            // Fill - with a subtle shadow
            let shadowColor = UIColor.grayColor()
            CGContextSetShadowWithColor(ctx, CGSize(width: 0.0, height: 1.0), 1.0, shadowColor.CGColor)
            CGContextSetFillColorWithColor(ctx, slider.thumbTintColor.CGColor)
            CGContextAddPath(ctx, thumbPath.CGPath)
            CGContextFillPath(ctx)
            
            // Outline
            CGContextSetStrokeColorWithColor(ctx, shadowColor.CGColor)
            CGContextSetLineWidth(ctx, 0.5)
            CGContextAddPath(ctx, thumbPath.CGPath)
            CGContextStrokePath(ctx)
            
            if highlighted {
                CGContextSetFillColorWithColor(ctx, UIColor(white: 0.0, alpha: 0.1).CGColor)
                CGContextAddPath(ctx, thumbPath.CGPath)
                CGContextFillPath(ctx)
            }
        }
    }
}
