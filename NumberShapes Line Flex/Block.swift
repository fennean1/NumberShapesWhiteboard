//
//  Block.swift
//  NumberShapes Whiteboard
//
//  Created by Andrew Fenner on 12/29/15.
//  Copyright © 2015 NumberShapes. All rights reserved.
//

import Foundation
import UIKit


class block: UIImageView
{
    
    var imagearr = ["BlueBlock","BlueRect","OrangeBlock"]
    
    func makeme(mark: Float, slider: Float, me: Float)
    {
        
        let name = whosethisblock(mark, slider: slider, me: me)
        
        if name == "NILL"
        {
            self.image = nil
        }
        else
        {
            self.image = UIImage(named: name)
        }
    }
    
}


func whosethisblock(mark: Float,slider: Float, me: Float) -> String
{
    
    let Img1 = "BlueBlock"
    let Img2 = "BlueRect"
    let Img3 = "OrangeBlock"
    let Nill = "NILL"
    
    
    var Iam = ""
    
    if mark == -1
    {
        if me <= slider
        {
            Iam = Img1
        }
        else
        {
            Iam = Nill
        }
    }
    else if mark == 0 && slider == 0
    {
        Iam = Nill
    }
    else if mark == 0 && slider > 0
    {
        if me <= slider
        {
            Iam = Img3
        }
        else if me > slider
        {
            Iam = Nill
        }
    }
    else if mark == slider
    {
        if me <= mark
        {
            Iam = Img1
        }
        else if me > mark
        {
            Iam = Nill
        }
    }
    else if mark < slider
    {
        if me > slider
        {
            Iam = Nill
        }
        else if mark < me && me <= slider
        {
            Iam = Img3
        }
        else if me <= mark
        {
            Iam = Img1
        }
    }
    else if slider < mark
    {
        if me > mark
        {
            Iam = Nill
        }
        else if slider < me && me <= mark
        {
            Iam = Img2
        }
        else if me <= slider
        {
            Iam = Img1
        }
    }
    
    
    return Iam
    
    
}
