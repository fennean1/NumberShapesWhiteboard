//
//  CountingView.swift
//  NumberShapes Whiteboard
//
//  Created by Andrew Fenner on 1/24/16.
//  Copyright © 2016 NumberShapes. All rights reserved.
//

import Foundation
import UIKit

struct hundredsmodel
{
    
    
}

class countingview: UIView
{
    var dx: CGFloat!
    var top: Int!
    var w: CGFloat!
    var h: CGFloat!
    var imgarr: [String]!
    var BallArray:[UIImageView] = []
    
    // A little basic setting up.
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        self.isUserInteractionEnabled = true
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        self.clearsContextBeforeDrawing = true
        self.backgroundColor = UIColor.clear
        self.setNeedsDisplay()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
        self.setNeedsDisplay()
    
        
        let touch = touches.first
        
        let touchpoint = touch?.location(in: self)
        
        // find the number of tens from the x value
        let x = Int((touchpoint!.x)/self.frame.width*CGFloat(100*n))
        let tens = x - x%10
        
        let ones = Int((self.frame.height - (touchpoint!.y))/self.frame.height*CGFloat(10))
        
        oldslider = Slider
        
        Slider = tens + ones
        
        let top = max(Slider,oldslider)
        let bot = min(Slider,oldslider)
        
        self.drawcountersfrom(n, start: top, mark: Mark, blocking: blocking, end: bot, slider: Slider)
        UpdateDescriptor()
        
    }
    
    // These are values that need only be computed once
    func presets(_ n: Int, slider: Int, mark: Int, blocking: Bool)
    {
        
        // Clear current views
        for view in self.subviews
        {
            view.removeFromSuperview()
        }
        
  
        
        var locarray: [UIImageView] = []
        
         dx = self.frame.width/(CGFloat(10*n))
         w = dx
         h = w
         self.backgroundColor = UIColor.clear
        
        for index in 0...100*n
        {
            let ones = index%10
            let tens = CGFloat((index - ones)/10)
            
            let x = tens*dx
            let w = dx
            let h = w
            let y = self.frame.height - CGFloat(ones+1)*dx
            
            let ballframe = CGRect(x: x, y: y, width: w!, height: h!)
            let ball = UIImageView()
            ball.backgroundColor = UIColor.clear
            ball.frame = ballframe
            self.addSubview(ball)
            
            locarray.append(ball)
            
        }
        
        BallArray = locarray
        
        //depending on balling or not
        let ballnamearray = ["BlueBall","BlueRing","OrangeBall","OrangeRing"]
        let blocknamearray = ["BlueBlock","BlueRect","OrangeBlock","OrangeBox"]
        
        if blocking == false
        {
            imgarr = ballnamearray
        }
        else if blocking == true
        {
            imgarr = blocknamearray
        }

    }
    
    override func draw(_ rect: CGRect)
    {
        let path = UIBezierPath(rect: self.bounds)
        UIColor.darkGray.setStroke()
        path.lineWidth = 0.5
        path.stroke()
        
    }
    
    
    func drawcountersfrom(_ n: Int, start: Int, mark: Int, blocking: Bool, end: Int, slider: Int)
    {
        
        var minimum = min(start,end)
        var maximum = max(start,end)
        
        
        if minimum != 0
        {
            minimum = minimum-1
        }
        
        if maximum != 0
        {
            maximum = maximum-1
        }
        
        if minimum <= 0
        {
            minimum = 0
        }
        
        for index in minimum...maximum
        {
            let ballname = whoami(mark, v: slider, l: index, imgarr: imgarr)
        
            if ballname == "NILL"
            {
                BallArray[index].image = nil
            }
            else
            {
                BallArray[index].image = UIImage(named: ballname)
            }
        }
    }
}

class hundredsdescriptor: UILabel
{
    
    // A little basic setting up.
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.font = UIFont(name: "Chalkboard SE", size: self.frame.height/2)
        self.textAlignment = .center
    }
    
}


// Currently have two different descriptors one as UILabel and other as UIView class.
func UpdateDescriptor()
{
    let s  = Slider
    
    var TextToDisplay = "\(s)"
    
    if operating
    {
        TextToDisplay = "\(Mark)"
        
        if s > Mark
        {
            TextToDisplay += " + \(s-Mark)"
        }
        else if s < Mark
        {
            TextToDisplay += " - \(Mark-s)"
        }
    }
   HundredsDescriptor.text = TextToDisplay
}
