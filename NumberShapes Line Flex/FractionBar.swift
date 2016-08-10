

import UIKit
import Foundation



class fractionbar: UIView
{
    
    var img = Dollar
    var Lattice = lattice!(nil)
    var Cut = true
    var WhatToCut = UIImageView()
    
    func write(N: Int, D: Int, Img: String)
    {
        Lattice.setvisibleregion(N, den: D)
        Lattice.setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder:aDecoder)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.frame = frame
        WhatToCut.frame = self.bounds
        WhatToCut.image = img
        self.addSubview(WhatToCut)
        
        Lattice = lattice(frame: self.bounds)
        self.addSubview(Lattice)
    }
}


class lattice: UIView
{
    var D: Int = 2
    var overlay = CAShapeLayer()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.clearsContextBeforeDrawing = true
        self.setNeedsDisplay()
        
    }
    
    func setvisibleregion(num: Int, den: Int)
    {
        
        D = den
        
        let dx = self.frame.width/CGFloat(D)
        
        var overlayrect: CGRect
        {
            let y = CGFloat(0)
            let h = self.frame.height
            let x = dx*CGFloat(num)
            let w = self.frame.width - x
            
            return CGRect(x: x, y: y, width: w, height: h)
        }
        
        overlay.path = UIBezierPath(roundedRect: overlayrect, cornerRadius: 0).CGPath
        overlay.fillColor = UIColor.whiteColor().CGColor
        self.layer.addSublayer(overlay)
        self.setNeedsDisplay()
        
    }
    
    
    override func drawRect(rect: CGRect)
    {
        
        let context = UIGraphicsGetCurrentContext()

        for index in 0...D
        {
            
            let DoubleIndex = CGFloat(index)
            let dx = self.frame.width/CGFloat(D)
            
            let y = CGFloat(0)
            let x = DoubleIndex*dx
            let End = CGPointMake(x, self.frame.width)
            
            CGContextMoveToPoint(context, x, y)
            
            CGContextAddLineToPoint(context, End.x, End.y)
            CGContextSetLineCap(context, CGLineCap.Round)
            
            UIColor.whiteColor().setStroke()
            
            CGContextSetLineWidth(context, sqrt(dx/CGFloat(3*D)))
            CGContextStrokePath(context)
            
        }
    }
}



