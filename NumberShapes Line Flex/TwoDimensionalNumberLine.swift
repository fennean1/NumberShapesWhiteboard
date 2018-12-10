//
//  TwoDimensionalNumberLine.swift
//  2D NumberLine
//
//  Created by Andrew Fenner on 1/5/16.
//  Copyright © 2016 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit

class twodimensionalnumberline: UIView
{
    
    var vticks = numberlineup()
    var hticks = ghnumberline()

    var vlbls = labelerup()
    var hlbls = labeler()
    
    var BallGrid = ballgrid()

    
    func drawme(_ rect: CGRect,n: Int)
    {
        // Align to incoming frame
        self.frame = rect
        let h = rect.height
        let w = h
    
        // Add to view
        self.addSubview(vticks)
        self.addSubview(hticks)
        self.addSubview(vlbls)
        self.addSubview(hlbls)
        self.addSubview(BallGrid)
        
        
        let BallGridRect = CGRect(x: 0, y: 0, width: w, height: h)
        BallGrid.frame = BallGridRect
        
        let dx = rect.width/CGFloat(n)
        let r = dx/40
        let axislabelwidth = rect.width/20
        let labelviewwidth = rect.width/20
        
        let hticksFrame = CGRect(x: 0, y: w-axislabelwidth/2+r , width: w, height: axislabelwidth)
        hticks.frame = hticksFrame
        hticks.n = n
        
        let vticksFrame = CGRect(x: -axislabelwidth/2-r, y: 0 , width: axislabelwidth, height: w)
        vticks.frame = vticksFrame
        vticks.n = n
        
        let vlblsFrame = CGRect(x: -1.5*axislabelwidth, y: 0 , width: axislabelwidth, height: w)
        vlbls.drawme(vlblsFrame, n: n)
        
        let hlblsFrame =  CGRect(x: 0, y: h+labelviewwidth/2, width: w, height: labelviewwidth)
        hlbls.drawme(hlblsFrame, n: n)
        
        hticks.setNeedsDisplay()
        vticks.setNeedsDisplay()
        
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
