//
//  SnapView.swift
//  2D NumberLine
//
//  Created by Andrew Fenner on 1/13/16.
//  Copyright © 2016 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit


class snapview: UIImageView
{
 
    
    func sizeme(n: Int, oldn: Int, wh: CGFloat, vx: Int, vy: Int)
    {
        let fn = CGFloat(n)
        let foldn = CGFloat(oldn)
        let h = wh/fn*foldn
        let y = wh - h
        
        self.frame = CGRect(x: 0, y: y, width: h, height: h)
    
    }	
    
}