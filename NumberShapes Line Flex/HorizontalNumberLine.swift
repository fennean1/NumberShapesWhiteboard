//
//  HorizontalNumberLine.swift
//  NumberShapes Whiteboard
//
//  Created by Andrew Fenner on 6/4/16.
//  Copyright © 2016 NumberShapes. All rights reserved.
//

import Foundation
import UIKit


class horizontalnumberline: UIView
{
    
    var hticks = horizontalnumberlinetickmarks()
    var hlbls = horizontalnumberlinelabels()
    
    func drawme(_ n: Int)
    {
        // Align to incoming frame
        let w = self.frame.width
        
        // Add to view
        self.addSubview(hticks)
        self.addSubview(hlbls)
        
        let axislabelwidth = self.frame.height/2
        let labelviewwidth = self.frame.height/2
        
        let hticksFrame = CGRect(x: 0, y: 0, width: w, height: axislabelwidth)
        hticks.frame = hticksFrame
        hticks.n = n

        let hlblsFrame =  CGRect(x: 0, y: axislabelwidth, width: w, height: labelviewwidth)
        
        hlbls.drawme(hlblsFrame, n: n)
        hticks.setNeedsDisplay()
        
    }
    
    
    // A little basic setting up.
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.clearsContextBeforeDrawing = true
        self.frame = frame
    }

}


class horizontalnumberlinelabels: UIView
{
    
    // This draws the labels on the view.
    func drawme(_ rect: CGRect, n: Int)
    {
        
        // Add this to the arguement.  We want to be able to control how often the lables occur
        let every = labelsevery(n)
        
        // Clear current views
        for view in self.subviews
        {
            view.removeFromSuperview()
        }
        
        // Set self to incoming rect
        self.frame = rect
        
        let dx = self.frame.width/CGFloat(n)*CGFloat(every) //distance between markers
        let h = self.frame.height // label heigth is height of the view
        let w = dx // Is the width of the number line divided by how often the lables occur
        
        let numberoflabels = Int(CGFloat(n)/CGFloat(every))
        
        // Loop to draw the labels
        for index in 0...numberoflabels
        {
            
            let lbl = UILabel()
            
            // Label starts at half its width so it's centered with marker above
            let startx  = dx/2
            
            // Layout the label
            lbl.frame = CGRect(x: -startx + CGFloat(index)*dx, y: 0, width: w, height: h)
            lbl.text = "\(index*every)"
            print(lbl.text)
            lbl.textAlignment = NSTextAlignment.center
            lbl.adjustsFontSizeToFitWidth = true
            lbl.font = UIFont(name: "ChalkBoard SE", size: h*3/5)
            //lbl.backgroundColor = UIColor.redColor()
            print(lbl.frame)
            // Add to self
            self.addSubview(lbl)
            
        }
    }
}



class horizontalnumberlinetickmarks: UIView
{
    // Length of numberline
    var n = 1
    
    // How often the ticks are small
    var smallevery = 1
    
    // How often the ticks are tiny
    var tinyevery = 1
    
    // Called by "SetNeedsDisplay"
    override func draw(_ rect: CGRect)
    {
        // Find out how often to place labels as a function of n
        let lblevery = labelsevery(n)
        
        // find how often to place a tick mark
        let tickstep = ticksevery(n)
        
        // Find out that the raw value when the final tick is placed
        let valueatfinaltick = n-n%tickstep
        
  
        // calculate the total number of tick marks that there will be
        let numberofticks = valueatfinaltick/tickstep
    
        
        // Distance to final tick
        let distancetotick = CGFloat(valueatfinaltick)/CGFloat(n)*self.frame.width
        
        // How far apart each tick will be
        let dx = distancetotick/CGFloat(numberofticks)
        
        // A few convenience parameters for calculations later
        let h = self.frame.height
        let linewidth = h/20
        let r = linewidth/2
        
        
        // Getting context and set it up
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(linewidth)
        context?.setStrokeColor(UIColor.black.cgColor)
        context?.setLineCap(CGLineCap.round)
        
        
        for index in 0...numberofticks
        {
            
            // New context start
            var conty = r
            let contx = CGFloat(index)*dx
            
            // Setup endpoint
            let endx = contx
            var endy = h - r
            
            
            if (index*tickstep)%lblevery != 0
            {
                endy = h - 4*r
                conty = 4*r
                
            }

                context?.move(to: CGPoint(x: contx, y: conty))
                context?.addLine(to: CGPoint(x: endx, y: endy))

        }
        
        // Draw the line straight through
        context?.move(to: CGPoint(x: 0, y: h/2))
        context?.addLine(to: CGPoint(x: dx*CGFloat(n), y: h/2))
        context?.strokePath()
        
    }
    
    
    // A little basic setting up.
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
       
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.clearsContextBeforeDrawing = true
    }
    
}


// Counts how often a label should be drawn as a function of it's length
func labelsevery(_ n: Int) -> Int
{
    
    if 20 < n && n <= 40
    {
        return 2
    }
    else if 40 < n && n <= 100
    {
        return 5
    }
    else if 100 < n && n <= 200
    {
        return 10
    }
    else if 200 < n && n <= 500
    {
        return 25
    }
    else if 500 < n && n <= 1000
    {
        return 50
    }
    else
    {
        return 1
    }
    
}


func ticksevery(_ n: Int) -> Int
{
    
    if 20 < n && n <= 40
    {
        return 1
    }
    else if 40 < n && n <= 100
    {
        return 1
    }
    else if 100 < n && n <= 200
    {
        return 5
    }
    else if 200 < n && n <= 500
    {
        return 5
    }
    else if 500 < n && n <= 1000
    {
        return 25
    }
    else
    {
        return 1
    }
}

class pinch: UIPinchGestureRecognizer
{
    func getnewtop(_ scale: Float,floor: Float,currentmax: Int) -> Int
    {
        if scale*Float(currentmax) > floor
        {
            return Int(scale*Float(currentmax))
        }
        else
        {
            return currentmax
        }
    }
}
