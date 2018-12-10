

import UIKit
import Foundation



class fractionball: UIView
{
    
    var img = UIImage(named: "Sphere")
    var Pie = ProgressPieIcon()
    var Cutter = slicingClass()
    var Cut = true
    var WhatToCut = UIImageView()
    
    func writefrac(_ n: Int, d: Int)
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
        self.backgroundColor = UIColor.clear
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
        self.backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect)
    {
        
        self.backgroundColor = UIColor.clear
        let color = UIColor.blue.cgColor
        let lineWidth : CGFloat = 0
        
        // Calculate box with insets
        let margin: CGFloat = lineWidth
        let box0 = self.bounds.insetBy(dx: margin, dy: margin)
        let side : CGFloat = min(box0.width, box0.height)
        let box = CGRect(x: (self.bounds.width-side)/2, y: (self.bounds.height-side)/2,width: side,height: side)
        
        
        let ctx = UIGraphicsGetCurrentContext()
        
        // Draw outline
        ctx?.beginPath()
        ctx?.setStrokeColor(color)
        ctx?.setLineWidth(lineWidth)
        ctx?.addEllipse(in: box)
        ctx?.closePath()
        ctx?.strokePath()
        
        // Draw arc
        let delta : CGFloat = CGFloat(-Double.pi/2)
        let radius : CGFloat = min(box.width, box.height)/2.0
        
        func prog_to_rad(_ p: Double) -> CGFloat
        {
            let rad = CGFloat(p * 2 * Double.pi)
            return rad + delta
        }
        
        func draw_arc(_ s: CGFloat, e: CGFloat, color: CGColor) {
            
            ctx?.beginPath()
            ctx?.move(to: CGPoint(x: box.midX, y: box.midY))
            ctx?.setFillColor(UIColor.white.cgColor)
            ctx?.addArc(center: center, radius: radius, startAngle: CGFloat(-Double.pi/2), endAngle: e, clockwise: false)
            ctx?.closePath()
            ctx?.fillPath()
            
        }
 
        if progress > 0 {
            let s = prog_to_rad(0)
            let e = prog_to_rad(min(1.0, progress))
            draw_arc(s, e: e, color: UIColor.white.cgColor)
        }
    }
}


class slicingClass: UIView
{
    
    let π = Double.pi
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
        self.backgroundColor = UIColor.clear
        
    }
    
    
    override func draw(_ rect: CGRect)
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
                
                context?.move(to: CGPoint(x: Radius, y: Radius))
                
                let End = CGPoint(x: CGFloat(x),y: CGFloat(y))
                
                context?.addLine(to: CGPoint(x: End.x, y: End.y))
                
                context?.setLineCap(CGLineCap.round)
                
                context?.setStrokeColor(red: 1,green: 1,blue: 1,alpha: 1)
                
                context?.setLineWidth(10/sqrt(CGFloat(pieces)))
                
                context?.strokePath()
                
                
            }
        }
        
    }
    
}



