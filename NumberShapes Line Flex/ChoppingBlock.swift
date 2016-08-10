//
//  ChoppingBlock.swift
//  NumberShapes Whiteboard
//
//  Created by Andrew Fenner on 12/28/15.
//  Copyright © 2015 NumberShapes. All rights reserved.
//

import Foundation
import UIKit

class choppingblock: UIView
{
    var Decimal = Float(1)
    var Mark = Float(-1)
    
    // This is to keep track of the actual value while the hundreths are being drawn. It begins at the largest integer less than the actual value and increments by 0.01 as we go through the block. (i.e. "Jumping Off Point")
    var floor = Float(-1)
    

    
    func DrawHundredths(var decimal: Float)
    {
    
        decimal = precision(decimal, n: 2)
        
        let step = self.frame.width/10
        let selfsize = self.frame.width
        
    
            for row in 0...9
            {
                // Row is used to multiply CGFloat values
                let CGrow = CGFloat(row)
                
                for col in 0...9
                {
                    // col is used to multiply CGFloat values
                    let CGcol = CGFloat(col)
                    
                    //Create block and add it to the view
                    let Block = block()
                    self.addSubview(Block)
                    
                    // BEGIN FRAME
                    // x is the steps times the number of rows
                    let x = step*CGrow
                    
                    // y is the one block up from the bottom of the frame
                    let y = selfsize - (step)*(CGcol+1)
                    
                    // height and width are still step size
                    let w = step
                    let h = step
                    
                    // Set frame
                    Block.frame = CGRect(x: x, y: y, width: w, height: h)
                    // END FRAME
                    
                    floor = Float(floor+0.01)
                   
                    // Block decides who it should be
                    floor = precision(floor, n: 2)
                    Block.makeme(Mark, slider: decimal, me: floor)
                    
                    
                }
            }

    }
    
    override func drawRect(rect: CGRect)
    {
        self.layer.sublayers?.removeAll()
        DrawHundredths(Decimal)
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
        self.clearsContextBeforeDrawing = true
        self.backgroundColor = UIColor.clearColor()
        
    }
    
    
    
    
}