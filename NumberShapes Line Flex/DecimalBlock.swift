

import UIKit
import Foundation



class decimalblock: UIView
{
    
    var img = UIImage(named: "BlueBlock")
    var Mesh = mesh()
    var Cut = true
    var WhatToCut = UIImageView()
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder:aDecoder)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
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
        self.backgroundColor = UIColor.clear
        self.setNeedsDisplay()
        self.setvisibleregion(40, den: 100)
  
    }
    
    func setvisibleregion(_ num: Int, den: Int)
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
        
        layerright.path = UIBezierPath(roundedRect: rightrect, cornerRadius: 0).cgPath
        layerright.fillColor = UIColor.white.cgColor
        self.layer.addSublayer(layerright)
        
        layertop.path = UIBezierPath(roundedRect: toprect, cornerRadius: 0).cgPath
        layertop.fillColor = UIColor.white.cgColor
        self.layer.addSublayer(layertop)

    }

    
    override func draw(_ rect: CGRect)
    {
        
            let context = UIGraphicsGetCurrentContext()
            
            for index in 0...2*dim + 1
            {
                
                let DoubleIndex = CGFloat(index)
                let dx = self.frame.width/CGFloat(dim)
                
                var y = CGFloat(0)
                var x = DoubleIndex.truncatingRemainder(dividingBy: 11)*dx
                var End = CGPoint(x: x, y: self.frame.width)
                
                // Flip to do the rows
                if index >= dim + 1
                {
                    y = x
                    x = 0
                    End = CGPoint(x: self.frame.width, y: y)
                }
                
                context?.move(to: CGPoint(x: x, y: y))
                
                context?.addLine(to: CGPoint(x: End.x, y: End.y))
                context?.setLineCap(CGLineCap.round)
                
                UIColor.white.setStroke()
                
                context?.setLineWidth(dx/CGFloat(dim))
                context?.strokePath()
                
            }
        
    }
    
}



