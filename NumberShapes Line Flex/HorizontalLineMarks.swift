//
//  NumberLine.swift
//  2D NumberLine
//
//  Created by Andrew Fenner on 1/4/16.
//  Copyright © 2016 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit


class ghnumberline: UIView
{
    var n = 1
    var smallevery = 1
    var tinyevery = 1

    override func drawRect(rect: CGRect)
    {
        
        // Parameters
        let dx = self.frame.width/CGFloat(n)
        let h = self.frame.height
        let linewidth = h/15
        let r = linewidth/2
        
        
        // Getting context and set it up
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, linewidth)
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextSetLineCap(context, CGLineCap.Round)
        
        let every = labelsevery(n)
        print(every)

        
        for index in 0...n
        {

            
            // New context start
            
            let conty = r + h/2
            let contx = CGFloat(index)*dx
            
            // Setup endpoint
            let endx = contx
            var endy = h - r
            
    
            
            if index%every != 0
            {
                endy = h - 4*r
                
            }
      
            
            if index == 0
            {
                
                // Draw the first at half length because it's at the origin
                CGContextMoveToPoint(context, r, h/2)
                CGContextAddLineToPoint(context, r, endy)
                
            }
            else if index == n
            {
                CGContextMoveToPoint(context, contx-r, conty)
                CGContextAddLineToPoint(context, endx-r, endy)
            }
            else
            {
                CGContextMoveToPoint(context, contx, conty)
                CGContextAddLineToPoint(context, endx, endy)
            }
        }
        
        // Draw the line straight through
        CGContextMoveToPoint(context, 0, h/2)
        CGContextAddLineToPoint(context, dx*CGFloat(n), h/2)
        
        CGContextStrokePath(context)
        
    }
    
    
    // A little basic setting up.
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        self.backgroundColor = UIColor.clearColor()
        self.clearsContextBeforeDrawing = true
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.clearsContextBeforeDrawing = true
        
        
    }
    
    
    
    
}