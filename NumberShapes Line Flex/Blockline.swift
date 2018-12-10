//
//  Blockline.swift
//  NumberShapes Whiteboard
//
//  Created by Andrew Fenner on 12/22/15.
//  Copyright © 2015 NumberShapes. All rights reserved.
//

import Foundation
import UIKit


class blockline: UIView
{
    var length = 10
    var step = CGFloat(10)
    var blocks = 10
    var slider = Float(0)
    var Mark = Float(-1)
    
    func refreshtheblocks()
    {
    
    // Step is always the height of the frame
    step = self.frame.height
    
    // this makes replacements up until the highest point where something needs to be drawn
    let top = max(Mark,slider)
    

    for index in 0...Int(top)
    {
        
    // So index can be multiplied to form dimensions
    let CGIndex = CGFloat(index)
    let MarkDistFromIndex = Mark - Float(index)
    let SliderDistFromIndex = slider - Float(index)
    let frame = CGRect(x: step*CGIndex, y: 0, width: step, height: step)
    
    // Find out if we need a chopping block
    if Mark != -1 && MarkDistFromIndex < 1 && MarkDistFromIndex > 0 && Mark != 0
    {
    
            let Chopper = choppingblock()
            Chopper.Mark = Mark
            Chopper.frame = frame
            Chopper.Decimal = Float(slider)
            Chopper.floor = Float(CGIndex)
            self.addSubview(Chopper)
            Chopper.setNeedsDisplay()
        
    }
    else if SliderDistFromIndex < 1 && SliderDistFromIndex > 0 && slider != 0
    {

        
        let Chopper = choppingblock()
        Chopper.Mark = Mark
        Chopper.frame = frame
        Chopper.Decimal = Float(slider)
        Chopper.floor = Float(CGIndex)
        self.addSubview(Chopper)
        Chopper.setNeedsDisplay()
        
    }
    else if index == Int(top) && Int(round(slider)) != Int(top)
    {
    // last block is always chopping block (no, it's not)
        let Chopper = choppingblock()
        Chopper.Mark = Mark
        Chopper.frame = frame
        Chopper.Decimal = slider
        
            // Top could be chopping slider or mark, must send floor accordingly
            if Mark != -1
            {
                Chopper.floor = Float(Int(Mark))
            }
            else if Mark == -1
            {
                Chopper.floor = Float(Int(slider))
            }
        
        self.addSubview(Chopper)
        Chopper.setNeedsDisplay()
    }
    else if top < 1 && top != 0 && slider < 1
    {
        // begining block is chopper (NO NOT ALWAYS!)
        let Chopper = choppingblock()
        Chopper.Mark = Mark
        Chopper.frame = CGRect(x: 0, y: 0, width: step, height: step)
        Chopper.Decimal = slider
        Chopper.floor = 0
        self.addSubview(Chopper)
        Chopper.setNeedsDisplay()
    }
    else
    {
        // Create a regular frame
        let frame = frame
        let Block = block()
        self.addSubview(Block)
        Block.frame = frame
        let me = Float(index+1)
        Block.makeme(Mark, slider: slider, me: me)
    }
    
}
}


    override func draw(_ rect: CGRect)
    {
        
        self.layer.sublayers?.removeAll()
        self.backgroundColor = UIColor.clear
        
        refreshtheblocks()

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
