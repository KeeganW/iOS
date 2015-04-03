//
//  PinPadViewController.swift
//  PinPad
//
//  Created by Keegan Williams on 4/1/15.
//  Copyright (c) 2015 Keegan Williams. All rights reserved.
//

import UIKit

class PinPadViewController: UIViewController {
    
    var userEntry: String = ""
    let entryValue: String = "0000"
    
    @IBOutlet weak var entryCircles: PinPadEntryCircles!
    @IBOutlet weak var PinPadTitle: UILabel!
    
    @IBOutlet var pinButtons: [PinPadCircleButton]!
    
    var timer: NSTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add touch controls to all buttons
        for button in pinButtons{
            button.addTarget(self, action: Selector("pinButtonPressed:"), forControlEvents: UIControlEvents.TouchDown)
            button.addTarget(self, action: Selector("pinButtonPressed:"), forControlEvents: UIControlEvents.TouchUpOutside)
            button.addTarget(self, action: Selector("pinButtonReleased:"), forControlEvents: UIControlEvents.TouchUpInside)
        }
        
    }
    
    /*
    Called when the button needs to be redrawn
    */
    func pinButtonPressed(button: PinPadCircleButton) {
        button.setNeedsDisplay()
    }
    
    /*
    Called on touchupinside of button. Preforms opperations based on which
        button was pressed
    */
    func pinButtonReleased(button: PinPadCircleButton) {
        // Get button value and add it to the users guess
        let buttonValue: String = button.titleLabel!.text!
        userEntry = userEntry + buttonValue
        entryCircles.enteredNumbers += 1
        
        // Check if the user has inputed the correct code, incoorect code
        // or is still inputing
        if (userEntry == entryValue) {
            validEntry()
        }
        else if (countElements(userEntry) == countElements(entryValue)){
            invalidEntry()
        }
        entryCircles.setNeedsDisplay() // Redraw button display
        button.setNeedsDisplay() // Redraw button 
        
    }
    
    func validEntry(){
        entryCircles.setNeedsDisplay()
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector(), userInfo: nil, repeats: false)
        
        self.performSegueWithIdentifier("correctPasscode", sender: nil)
    }
    
    func reset (){
        entryCircles.enteredNumbers = 0
        entryCircles.setNeedsDisplay()
        userEntry = ""
    }
    
    func invalidEntry(){
        //
        animateShake()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.42, target: self, selector: Selector("reset"), userInfo: nil, repeats: false)
    }
    
    func animateShake(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(entryCircles.center.x - 20, entryCircles.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(entryCircles.center.x + 20, entryCircles.center.y))
        entryCircles.layer.addAnimation(animation, forKey: "position")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        println("Passcode entered correctly")
    }
}

