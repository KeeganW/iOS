//
//  PinPadViewController.swift
//  PinPad
//
//  Created by Keegan Williams on 4/1/15.
//  Copyright (c) 2015 Keegan Williams. All rights reserved.
//

import UIKit

class PinPadViewController: UIViewController {
    
    
    var entryValue: String = "0000" // Passcode string
    // Should be a let, but error checking means is must be a var
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var entryCircles: PinPadEntryCircles!
    @IBOutlet weak var pinPadTitle: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet var pinButtons: [PinPadCircleButton]!
    
    var userEntry: String = ""
    var timer: NSTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the size of the entry, and redraw
        if(countElements(entryValue) > 7){
            // Your passcode can only be 7 numbers in length!
            entryValue = String(NSString(string: entryValue).substringWithRange(NSRange(location: 0, length: 7)))
        }
        entryCircles.numberOfCircles = Double(countElements(entryValue))
        entryCircles.setNeedsDisplay()
        
        // Add touch controls to all buttons
        for button in pinButtons{
            button.addTarget(self, action: Selector("pinButtonPressed:"), forControlEvents: UIControlEvents.TouchDown)
            button.addTarget(self, action: Selector("pinButtonPressed:"), forControlEvents: UIControlEvents.TouchUpOutside)
            button.addTarget(self, action: Selector("pinButtonReleased:"), forControlEvents: UIControlEvents.TouchUpInside)
        }
        deleteButton.addTarget(self, action: Selector("deleteOne:"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    /*
    Called when the delete button is pressed
    */
    func deleteOne(button: UIButton) {
        if(countElements(userEntry) > 0){
            userEntry.removeAtIndex(userEntry.endIndex.predecessor())
            entryCircles.enteredNumbers -= 1
            entryCircles.setNeedsDisplay()
            
            if (countElements(userEntry) == 0){
                deleteButton.enabled = false
            }
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
        
        // Enable delete button
        deleteButton.enabled = true
        
        // Check if the user has inputed the correct code, incoorect code
        // or is still inputing
        if (userEntry == entryValue) {
            entryCircles.setNeedsDisplay()
            timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("completePinPad"), userInfo: nil, repeats: false)
        }
        else if (countElements(userEntry) == countElements(entryValue)){
            animateShake()
            timer = NSTimer.scheduledTimerWithTimeInterval(0.42, target: self, selector: Selector("reset"), userInfo: nil, repeats: false)
        }
        entryCircles.setNeedsDisplay() // Redraw circles display
        button.setNeedsDisplay() // Redraw button
        
    }
    
    /*
    To continue onto the next view
    */
    func completePinPad(){
        self.performSegueWithIdentifier("correctPasscode", sender: nil)
    }
    
    /*
    Reset values for various things
    */
    func reset (){
        entryCircles.enteredNumbers = 0
        entryCircles.setNeedsDisplay()
        userEntry = ""
        deleteButton.enabled = false
    }
    
    /*
    A short animation to simulate the shake that iOS preforms when you
        enter the incorrect value
    */
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

