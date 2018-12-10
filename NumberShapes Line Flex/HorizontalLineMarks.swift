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

    override func draw(_ rect: CGRect)
    {
        
        // Parameters
        let dx = self.frame.width/CGFloat(n)
        let h = self.frame.height
        let linewidth = h/15
        let r = linewidth/2
        
        
        // Getting context and set it up
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(linewidth)
        context?.setStrokeColor(UIColor.black.cgColor)
        context?.setLineCap(CGLineCap.round)
        
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
                context?.move(to: CGPoint(x: r, y: h/2))
                context?.addLine(to: CGPoint(x: r, y: endy))
                
            }
            else if index == n
            {
                context?.move(to: CGPoint(x: contx-r, y: conty))
                context?.addLine(to: CGPoint(x: endx-r, y: endy))
            }
            else
            {
                context?.move(to: CGPoint(x: contx, y: conty))
                context?.addLine(to: CGPoint(x: endx, y: endy))
            }
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
