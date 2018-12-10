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
    
    override func draw(_ rect: CGRect)
    {
        
        // Parameters
        let dx = self.frame.height/CGFloat(n)
        let w = self.frame.width
        let linewidth = w/15
        let r = linewidth/2
        
        // Getting context and set it up
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(linewidth)
        context?.setStrokeColor(UIColor.black.cgColor)
        context?.setLineCap(CGLineCap.round)
        
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
                context?.move(to: CGPoint(x: r, y: r))
                context?.addLine(to: CGPoint(x: endx, y: r))
                
            }
            else if index == n
            {
                // draw the last at half width cause it's at the origin
                context?.move(to: CGPoint(x: r, y: conty-r))
                context?.addLine(to: CGPoint(x: w/2, y: endy-r))
            }
            else
            {
                context?.move(to: CGPoint(x: contx, y: conty))
                context?.addLine(to: CGPoint(x: endx, y: endy))
            }
        }
        
        // Draw the line straight through
        context?.move(to: CGPoint(x: w/2, y: 0))
        context?.addLine(to: CGPoint(x: w/2, y: dx*CGFloat(n)))
        
        context?.strokePath()
        
        
    }
    
    // A little basic setting up.
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        self.backgroundColor = UIColor.clear
        self.clearsContextBeforeDrawing = true
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.clearsContextBeforeDrawing = true
        
        
    }
    
}
