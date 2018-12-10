//
//  Marks.swift
//  2D NumberLine
//
//  Created by Andrew Fenner on 1/5/16.
//  Copyright © 2016 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit


class labelerup: UIView
{
    
    
    // This draws the labels on the view.
    func drawme(_ rect: CGRect, n: Int)
    {
        // Clear current views
        for view in self.subviews
        {
            view.removeFromSuperview()
        }
        
        let lblsevery = labelsevery(n)
        
        // Set self to incoming rect
        self.frame = rect
        
        let dx = self.frame.height/CGFloat(n)*CGFloat(lblsevery) //distance between markers
        let h = self.frame.width // label heigth is width of the view
        let w = h // width equals height
        
        let numberoflabels = Int(CGFloat(n)/CGFloat(lblsevery))
        
        // Loop to draw the labels
        for index in 0...numberoflabels
        {
            
            let lbl = UILabel()
            
            // Label starts at half its width so it's centered with marker above
            let starty = rect.height - h/2 - CGFloat(index)*dx
            
            // Layout the label
            lbl.frame = CGRect(x: 0, y: starty, width: w, height: h)
            lbl.text = "\(index*lblsevery)"
            lbl.textAlignment = NSTextAlignment.center
            lbl.adjustsFontSizeToFitWidth = true
            lbl.font = UIFont(name: "ChalkBoard SE", size: h*3/5)
            
            // Add to self
            self.addSubview(lbl)
        
            
        }
        
        
    }
    
    
}
