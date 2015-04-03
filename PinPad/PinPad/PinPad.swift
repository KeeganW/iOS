//
//  PinPad.swift
//  PinPad
//
//  Created by Keegan Williams on 4/1/15.
//  Copyright (c) 2015 Keegan Williams. All rights reserved.
//

import UIKit
import QuartzCore

class PinPad: UIControl {
    var minimumValue = 0.0
    var maximumValue = 1.0
    var lowerValue = 0.2
    var upperValue = 0.8
    
    let maxHeight = 200
    let minHeight = 900
    
    let maxWidth = 200
    let minWidth = 200
    
    let circleSize = 50
    
    let trackLayer = CALayer()
    let lowerThumbLayer = PinCircleLayer()
    let upperThumbLayer = PinCircleLayer()
    let circle = CALayer()
    
    var curvaceousness : CGFloat = 1.0
    var trackTintColor = UIColor(white: 0.9, alpha: 1.0)
    var trackHighlightTintColor = UIColor(red: 0.0, green: 0.45, blue: 0.94, alpha: 1.0)
    var thumbTintColor = UIColor.whiteColor()
    
    var thumbWidth: CGFloat {
        return CGFloat(bounds.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        lowerThumbLayer.pinPad = self
        upperThumbLayer.pinPad = self
        
        trackLayer.backgroundColor = UIColor.blueColor().CGColor
        layer.addSublayer(trackLayer)
        
        lowerThumbLayer.backgroundColor = UIColor.greenColor().CGColor
        layer.addSublayer(lowerThumbLayer)
        
        upperThumbLayer.backgroundColor = UIColor.greenColor().CGColor
        layer.addSublayer(upperThumbLayer)
        
        circle.backgroundColor = UIColor.orangeColor().CGColor
        layer.addSublayer(circle)
        
        updateLayerFrames()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateLayerFrames() {
        trackLayer.frame = bounds.rectByInsetting(dx: 0.0, dy: bounds.height / 3)
        trackLayer.setNeedsDisplay()
        
        let lowerThumbCenter = CGFloat(positionForValue(lowerValue))
        lowerThumbLayer.frame = CGRect(x: lowerThumbCenter - thumbWidth / 2.0, y: 0.0,
            width: thumbWidth, height: thumbWidth)
        lowerThumbLayer.setNeedsDisplay()
        
        let upperThumbCenter = CGFloat(positionForValue(upperValue))
        upperThumbLayer.frame = CGRect(x: upperThumbCenter - thumbWidth / 2.0, y: 0.0,
            width: thumbWidth, height: thumbWidth)
        upperThumbLayer.setNeedsDisplay()
        
        circle.frame = CGRect(x: 50, y: 50, width: circleSize, height: circleSize)
        circle.setNeedsDisplay()
    }
    
    func positionForValue(value: Double) -> Double {
        return Double(bounds.width - thumbWidth) * (value - minimumValue) /
            (maximumValue - minimumValue) + Double(thumbWidth / 2.0)
    }
    
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
}