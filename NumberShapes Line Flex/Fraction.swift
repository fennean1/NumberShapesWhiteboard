//
//  Fraction.swift
//  Fractions
//
//  Created by Barbara L Fenner on 11/12/15.
//  Copyright © 2015 NumberShapes. All rights reserved.
//

import Foundation
import UIKit


class fractionofathingdescriptor: UIView
{
    var FractionDescriptor = fractiondescriptor()
    let ThingThatFractionIsOf = UILabel()
    
    func write(_ N: Int, D: Int,Img: String)
    {
        
        let length = CGFloat(Img.getstringprefix(false).characters.count + 3)
        print(Img.characters.count)
        
        // How much an additional character extends the length of the label
        let dl = 3/16*self.frame.height
        
        var fractiondescriptorframe: CGRect
        {
            let h = frame.height
            let w = h/2
            let y = CGFloat(0)
            let x = self.frame.width/2 - (w + length*dl)/2
            
            return CGRect(x: x, y: y, width: w, height: h)
        }
        
        var fractionofdescriptorframe: CGRect
        {
            
            let h = self.frame.height
            let w = length*dl
            
            var x = fractiondescriptorframe.origin.x + h/2
            if N == 1 && D == 1
            {
                x = self.frame.width/2 - w/2
            }     
            
            let y = CGFloat(0)
            
            return CGRect(x: x, y: y, width: w, height: h)
            
        }
        
        FractionDescriptor.frame = fractiondescriptorframe
        ThingThatFractionIsOf.frame = fractionofdescriptorframe
    
        var _text: String!
        
        if N == 1 && D == 1
        {
            _text = "1 " + Img
            FractionDescriptor.isHidden = true
        }
        else
        {
            FractionDescriptor.isHidden = false
            _text =  "of " + Img.getstringprefix(false)
        }

        FractionDescriptor.printFrac(N, den: D)
        
        ThingThatFractionIsOf.text = _text
        
    }
    
    // A little basic setting up.
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        var fractiondescriptorframe: CGRect
        {
            let h = frame.height
            let w = h/2
            let y = CGFloat(0)
            let x = CGFloat(0)
            
            return CGRect(x: x, y: y, width: w, height: h)
        }
        
        var fractionofdescriptorframe: CGRect
        {
            let h = self.frame.height
            let w = self.frame.width - h/2
            let x = h/2
            let y = CGFloat(0)
            
            return CGRect(x: x, y: y, width: w, height: h)
            
        }
        
        FractionDescriptor = fractiondescriptor(frame: fractiondescriptorframe)
        ThingThatFractionIsOf.frame = fractionofdescriptorframe
        
        
        ThingThatFractionIsOf.font = UIFont(name: "Chalkboard SE", size: frame.height/3)
        ThingThatFractionIsOf.textAlignment = .center
        //ThingThatFractionIsOf.backgroundColor = UIColor.redColor()
        //FractionDescriptor.backgroundColor = UIColor.blueColor()
        
        
        self.addSubview(FractionDescriptor)
        self.addSubview(ThingThatFractionIsOf)
        
        //FractionDescriptor.backgroundColor = UIColor.blueColor()
        //ThingThatFractionIsOf.backgroundColor = UIColor.yellowColor()
        
        //self.backgroundColor = UIColor.grayColor()
        
    }
    
    
    
    
}

// This is a custom view that shows fractions.  I actually need one of these to make mixed numbers for my percents app.
class fractiondescriptor: UIView
{
    
    var reduced: Bool!
    var numerator = UILabel()
    var denominator = UILabel()
    var divider = UIImageView()
    
    func printFrac(_ num: Int, den: Int)
    {
        // _width just to have a different name.
        let _width = self.frame.width
        
        // Default setup
        numerator.textAlignment = NSTextAlignment.center
        numerator.font = UIFont(name: "ChalkBoard SE", size: 1/2*_width)
        denominator.textAlignment = NSTextAlignment.center
        denominator.font = UIFont(name: "ChalkBoard SE", size: 1/2*_width)
        numerator.frame = CGRect(x: 0, y: 0, width: _width, height: _width)
        denominator.frame = CGRect(x: 0, y: _width, width: _width, height: _width)
        divider.frame = CGRect(x: 0, y: 29/30*_width, width: _width, height: 1/15*_width)
        divider.image = UIImage(named: "Divider")
        
        // If it's one it's just one
        if den == 1 && num == 1
        {
            numerator.frame = CGRect(x: 0, y: _width/2, width: _width, height: _width)
            numerator.text = "\(num)"
            denominator.text = nil
            divider.isHidden = true
        }
            // Otherwise inheret from defaults
        else
        {
            divider.isHidden = false
            numerator.text = "\(num)"
            denominator.text = "\(den)"
        }
        
    }
    
    
    // A little basic setting up.
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.addSubview(numerator)
        self.addSubview(denominator)
        self.addSubview(divider)
        
    }
    
    
}
