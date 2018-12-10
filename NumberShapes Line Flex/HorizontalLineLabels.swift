//
//  Marks.swift
//  2D NumberLine
//
//  Created by Andrew Fenner on 1/5/16.
//  Copyright © 2016 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit


class labeler: UIView
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
        let w = h // width equals height
        
        let numberoflabels = Int(CGFloat(n)/CGFloat(every))
        
        // Loop to draw the labels
        for index in 0...numberoflabels
        {
            
            let lbl = UILabel()
            
            // Label starts at half its width so it's centered with marker above
            let startx  = h/2
            
            // Layout the label
            lbl.frame = CGRect(x: -startx + CGFloat(index)*dx, y: 0, width: w, height: h)
            lbl.text = "\(index*every)"
            lbl.textAlignment = NSTextAlignment.center
            lbl.adjustsFontSizeToFitWidth = true
            lbl.font = UIFont(name: "ChalkBoard SE", size: h*3/5)
            
            // Add to self
            self.addSubview(lbl)
            
        }
    
    
    }
    
    
}
