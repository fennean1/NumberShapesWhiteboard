//
//  PinchRecognizer.swift
//  NumberShapes Whiteboard
//
//  Created by Barbara L Fenner on 11/6/15.
//  Copyright © 2015 NumberShapes. All rights reserved.
//

import Foundation
import UIKit


class pincher: UIPinchGestureRecognizer
{
    
    // Balls is actually the max on the numberline
    
    func handlePinch(_ topOfLine: Int, balls: Int, scalefactor: CGFloat, max: Int) -> [Int]
    {
        var topOfLine = topOfLine
        
        var MarksEvery = 1
        var TickEveryOther = 1
        
        let newlength = Int(round(CGFloat(topOfLine)*1/pow(scalefactor,1/2)))
        
        // Stop the zoom from dipping beneath the number of balls (this is measured as int which i think is okay.
        if newlength > balls
        {
        
            topOfLine = Int(CGFloat(topOfLine)*1/pow(scalefactor,1/2))
            
            // Error check it
            if topOfLine >= max
            {
                topOfLine = max
            }
            else if topOfLine <= 7
            {
                topOfLine = 7
            }
        
        }
        
        
        // Calculate parameters even if line length doesn't change.
        if Int(topOfLine) < 25
        {
            MarksEvery = 1
        }
        else if Int(topOfLine/2) < 25
        {
            MarksEvery = 2
        }
        else if Int(topOfLine/5) < 25
        {
            MarksEvery = 5
        }
        else if Int(topOfLine/10) < 25
        {
            TickEveryOther = 2
            MarksEvery = 10
        }
        else if Int(topOfLine/20) < 25
        {
            TickEveryOther = 2
            MarksEvery = 20
        }
        else if Int(topOfLine/50) < 25
        {
            TickEveryOther = 5
            MarksEvery = 50
        }
        else if Int(topOfLine/100) < 25
        {
            TickEveryOther = 5
            MarksEvery = 100
        }
    
        
        // put the parameters back in the array
        let ParameterArray = [MarksEvery, TickEveryOther, topOfLine]
    
        return ParameterArray
        
        
    }
    
    
    
    
}
