

import UIKit
import Foundation



class decimalblock: UIView
{
    
    var img = UIImage(named: "BlueBlock")
    var Mesh = mesh!(nil)
    var Cut = true
    var WhatToCut = UIImageView()
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder:aDecoder)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
        WhatToCut.frame = self.bounds
        WhatToCut.image = img
        self.addSubview(WhatToCut)
        
        Mesh = mesh(frame: self.bounds)
        self.addSubview(Mesh)
        
    }
}



class mesh: UIView
{
    
    var dim = 10
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.setNeedsDisplay()
        self.setvisibleregion(40, den: 100)
  
    }
    
    func setvisibleregion(num: Int, den: Int)
    {
        
        let dx = self.frame.width/CGFloat(dim)
        let layertop = CAShapeLayer()
        let layerright = CAShapeLayer()
        
        var toprect: CGRect
        {
            let y = CGFloat(0)
            let h = self.frame.width - dx*CGFloat(num%dim)
            let x = dx*CGFloat((num - num%10)/10)
            let w = self.frame.width - x
            
            return CGRect(x: x, y: y, width: w, height: h)
        }
        
        var rightrect: CGRect
        {
            let y = CGFloat(0)
            let x = toprect.origin.x + dx
            let h = self.frame.height
            let w = self.frame.width - x
            
            return CGRect(x: x, y: y, width: w, height: h)
        }
        
        layerright.path = UIBezierPath(roundedRect: rightrect, cornerRadius: 0).CGPath
        layerright.fillColor = UIColor.whiteColor().CGColor
        self.layer.addSublayer(layerright)
        
        layertop.path = UIBezierPath(roundedRect: toprect, cornerRadius: 0).CGPath
        layertop.fillColor = UIColor.whiteColor().CGColor
        self.layer.addSublayer(layertop)

    }

    
    override func drawRect(rect: CGRect)
    {
        
            let context = UIGraphicsGetCurrentContext()
            
            for index in 0...2*dim + 1
            {
                
                let DoubleIndex = CGFloat(index)
                let dx = self.frame.width/CGFloat(dim)
                
                var y = CGFloat(0)
                var x = DoubleIndex%11*dx
                var End = CGPointMake(x, self.frame.width)
                
                // Flip to do the rows
                if index >= dim + 1
                {
                    y = x
                    x = 0
                    End = CGPointMake(self.frame.width, y)
                }
                
                CGContextMoveToPoint(context, x, y)
                
                CGContextAddLineToPoint(context, End.x, End.y)
                CGContextSetLineCap(context, CGLineCap.Round)
                
                UIColor.whiteColor().setStroke()
                
                CGContextSetLineWidth(context, dx/CGFloat(dim))
                CGContextStrokePath(context)
                
            }
        
    }
    
}



