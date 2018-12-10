

import UIKit
import Foundation



class fractionbar: UIView
{
    
    var img = Dollar
    var Lattice = lattice()
    var Cut = true
    var WhatToCut = UIImageView()
    
    func write(_ N: Int, D: Int, Img: String)
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
        self.backgroundColor = UIColor.clear
        self.clearsContextBeforeDrawing = true
        self.setNeedsDisplay()
        
    }
    
    func setvisibleregion(_ num: Int, den: Int)
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
        
        overlay.path = UIBezierPath(roundedRect: overlayrect, cornerRadius: 0).cgPath
        overlay.fillColor = UIColor.white.cgColor
        self.layer.addSublayer(overlay)
        self.setNeedsDisplay()
        
    }
    
    
    override func draw(_ rect: CGRect)
    {
        
        let context = UIGraphicsGetCurrentContext()

        for index in 0...D
        {
            
            let DoubleIndex = CGFloat(index)
            let dx = self.frame.width/CGFloat(D)
            
            let y = CGFloat(0)
            let x = DoubleIndex*dx
            let End = CGPoint(x: x, y: self.frame.width)
            
            context?.move(to: CGPoint(x: x, y: y))
            
            context?.addLine(to: CGPoint(x: End.x, y: End.y))
            context?.setLineCap(CGLineCap.round)
            
            UIColor.white.setStroke()
            
            context?.setLineWidth(sqrt(dx/CGFloat(3*D)))
            context?.strokePath()
            
        }
    }
}



