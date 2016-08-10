//
//  NumberLine.swift
//  2D NumberLine
//
//  Created by Andrew Fenner on 1/4/16.
//  Copyright © 2016 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit


class numberlineup: UIView
{
    var n = 1
    var smallevery = 1
    var tinyevery = 1
    
    override func drawRect(rect: CGRect)
    {
        
        // Parameters
        let dx = self.frame.height/CGFloat(n)
        let w = self.frame.width
        let linewidth = w/15
        let r = linewidth/2
        
        // Getting context and set it up
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, linewidth)
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextSetLineCap(context, CGLineCap.Round)
        
        let lblsevery = labelsevery(n)
        
        for index in 0...n
        {
            // New context start
            var contx = CGFloat(0) + r
            let conty = CGFloat(index)*dx
            
            // Setup endpoint
            let endy = conty
            let endx = w/2 - r
            
            // Punish the mark for not being that of label
            if index%lblsevery != 0
            {
                contx = 4*r
            }
            
            if index == 0
            {
                CGContextMoveToPoint(context, r, r)
                CGContextAddLineToPoint(context, endx, r)
                
            }
            else if index == n
            {
                // draw the last at half width cause it's at the origin
                CGContextMoveToPoint(context, r, conty-r)
                CGContextAddLineToPoint(context, w/2, endy-r)
            }
            else
            {
                CGContextMoveToPoint(context, contx, conty)
                CGContextAddLineToPoint(context, endx, endy)
            }
        }
        
        // Draw the line straight through
        CGContextMoveToPoint(context, w/2, 0)
        CGContextAddLineToPoint(context, w/2, dx*CGFloat(n))
        
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