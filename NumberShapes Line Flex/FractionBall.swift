

import UIKit
import Foundation



class fractionball: UIView
{
    
    var img = UIImage(named: "Sphere")
    var Pie = ProgressPieIcon()
    var Cutter = slicingClass()
    var Cut = true
    var WhatToCut = UIImageView()
    
    func writefrac(n: Int, d: Int)
    {
        
        let fn = Double(n)
        let fd = Double(d)
        
        Pie.progress = 1 - fn/fd
        WhatToCut.image = img
        Cutter.pieces = d
        Cutter.setNeedsDisplay()

    }
    
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder:aDecoder)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.addSubview(WhatToCut)
        self.addSubview(Cutter)
        self.addSubview(Pie)
        self.frame = frame
        
        let incomingframe = self.bounds
        
        Pie.frame = incomingframe
        Cutter.frame = incomingframe
        WhatToCut.frame = incomingframe
        WhatToCut.image = img
        Pie.progress = 0.5
        Cutter.setNeedsDisplay()
        
    }
    
}


class ProgressPieIcon: UIView
{
    var progress : Double =  0.0
    {
        didSet
        {
            self.setNeedsDisplay()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    override func drawRect(rect: CGRect)
    {
        
        self.backgroundColor = UIColor.clearColor()
        let color = UIColor.whiteColor().CGColor
        let lineWidth : CGFloat = 0
        
        // Calculate box with insets
        let margin: CGFloat = lineWidth
        let box0 = CGRectInset(self.bounds, margin, margin)
        let side : CGFloat = min(box0.width, box0.height)
        let box = CGRectMake((self.bounds.width-side)/2, (self.bounds.height-side)/2,side,side)
        
        
        let ctx = UIGraphicsGetCurrentContext()
        
        // Draw outline
        CGContextBeginPath(ctx)
        CGContextSetStrokeColorWithColor(ctx, color)
        CGContextSetLineWidth(ctx, lineWidth)
        CGContextAddEllipseInRect(ctx, box)
        CGContextClosePath(ctx)
        CGContextStrokePath(ctx)
        
        // Draw arc
        let delta : CGFloat = -CGFloat(M_PI_2)
        let radius : CGFloat = min(box.width, box.height)/2.0
        
        func prog_to_rad(p: Double) -> CGFloat
        {
            let rad = CGFloat(p * 2 * M_PI)
            return rad + delta
        }
        
        func draw_arc(s: CGFloat, e: CGFloat, color: CGColor) {
            CGContextBeginPath(ctx)
            CGContextMoveToPoint(ctx, box.midX, box.midY)
            CGContextSetFillColorWithColor(ctx, color)
            
            CGContextAddArc(
                ctx,
                box.midX,
                box.midY,
                radius-lineWidth/2,
                s,
                e,
                0)
            
            CGContextClosePath(ctx)
            CGContextFillPath(ctx)
        }
        
        if progress > 0 {
            let s = prog_to_rad(0)
            let e = prog_to_rad(min(1.0, progress))
            draw_arc(s, e: e, color: UIColor.whiteColor().CGColor)
        }
    }
}


class slicingClass: UIView
{
    
    let π = M_PI
    var pieces = 1
    
    var Radius: CGFloat
    {
        return self.frame.height/2
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
    }
    
    
    override func drawRect(rect: CGRect)
    {
        
        
        if pieces != 1
        {
            let context = UIGraphicsGetCurrentContext()
            
            for index in 0...pieces-1
            {
                let DoubleIndex = Double(index)
                
                let Angle = -π/2.0 + 2.0*π/Double(pieces)*DoubleIndex
                
                
                let x = Double(Radius)+Double(Radius)*Double(cos(Angle))
                let y = Double(Radius)+Double(Radius)*Double(sin(Angle))
                
                CGContextMoveToPoint(context, Radius, Radius)
                
                let End = CGPointMake(CGFloat(x),CGFloat(y))
                
                CGContextAddLineToPoint(context, End.x, End.y)
                
                CGContextSetLineCap(context, CGLineCap.Round)
                
                CGContextSetRGBStrokeColor(context,1,1,1,1)
                
                CGContextSetLineWidth(context, 10/sqrt(CGFloat(pieces)))
                
                CGContextStrokePath(context)
                
                
            }
        }
        
    }
    
}



