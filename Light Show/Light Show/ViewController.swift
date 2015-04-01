//
//  ViewController.swift
//  Light Show
//
//  Created by Keegan Williams on 2/4/15.
//  Copyright (c) 2015 Keegan Williams. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    let divisionSize = 10 // This is how many sections the screen is split into
    var theBoxes: Array<Array<UIView>>!
    let changeNumber = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        // Create double array of boxes (UIViews)
        theBoxes = createBoxes()
        
        // Start counter loop
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    func update() {
        var randX = 0
        var randY = 0
//        changeAllToBlack()
        for curChange in 1...changeNumber {
            randX = Int(arc4random_uniform(UInt32(divisionSize)))
            randY = Int(arc4random_uniform(UInt32(divisionSize)))
            if (theBoxes[randX][randY].backgroundColor == UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)){
                changeColor(randX, yLoc: randY)
            }
            else {
                changeToBlack(randX, yLoc: randY)
            }
        }
    }
    
    func changeAllToBlack() {
        for height in 0...divisionSize-1 {
            for width in 0...divisionSize-1 {
                theBoxes[height][width].backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
            }
        }
    }
    
    func changeToBlack(xLoc: Int, yLoc: Int) {
        theBoxes[xLoc][yLoc].backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
    }
    
    func changeColor(xLoc: Int, yLoc: Int) {
        // Generate Randoms for clor
        let randRed: CGFloat = CGFloat(arc4random_uniform(1000)) * 0.001
//        println(randRed)
        let randGreen: CGFloat = CGFloat(arc4random_uniform(1000)) * 0.001
        let randBlue: CGFloat = CGFloat(arc4random_uniform(1000)) * 0.001
        
        // Set box properties
        theBoxes[xLoc][yLoc].backgroundColor = UIColor(red: randRed, green: randGreen, blue: randBlue, alpha: 1.0)
    }
    
    func createBoxes() -> Array<Array<UIView>> {
        // Get the screen properties
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        // This is how many sections the screen is split into
        let divisionSizeF: CGFloat = 1.0 / CGFloat(divisionSize)
        
        // Portions are a percentage of the screen width
        let portionWidth = screenWidth * divisionSizeF
        let portionHeight = screenHeight * divisionSizeF
        
        // Create arrays
        var theBoxes = Array<Array<UIView>>()
        var singleRow = Array<UIView>()
        
        // Loop through and generate arrays
        for height in 0...divisionSize-1 {
            for width in 0...divisionSize-1 {
                singleRow.append(createSingleBox(width, height: height, pWidth: portionWidth, pHeight: portionHeight))
            }
            theBoxes.append(singleRow)
            singleRow = Array<UIView>()
        }
        
        return theBoxes

    }
    
    func createSingleBox(width: Int, height: Int, pWidth: CGFloat, pHeight: CGFloat) -> UIView {
        let box = UIView()
        
        /*// Generate Randoms for clor
        let randRed: CGFloat = CGFloat(arc4random_uniform(1000)) * 0.001
//        println(randRed)
        let randGreen: CGFloat = CGFloat(arc4random_uniform(1000)) * 0.001
        let randBlue: CGFloat = CGFloat(arc4random_uniform(1000)) * 0.001
        
        // Set box properties
        box.backgroundColor = UIColor(red: randRed, green: randGreen, blue: randBlue, alpha: 1.0)
        */
        box.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        box.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(box)
        
        // Generate the width and height of the boxes
        var fwidth = CGFloat(width) * pWidth
        var fheight = CGFloat(height) * pHeight
        
        // The box view always has height will be pHeight
        let boxHeight = NSLayoutConstraint(item: box, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: pHeight)
        box.addConstraint(boxHeight)
        
        // The box view always has width will be pWidth
        let boxWidth = NSLayoutConstraint(item: box, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: pWidth)
        box.addConstraint(boxWidth)
        
        // The box view is at a certain point on the screen, calculated by fHeight
        let boxTop = NSLayoutConstraint(item: box, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: fheight)
        view.addConstraint(boxTop)
        
        // The box view is at a certain point on the screen, calculated by fWidth
        let boxLeft = NSLayoutConstraint(item: box, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: fwidth)
        view.addConstraint(boxLeft)
        
        return box
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

