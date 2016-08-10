

import Foundation
import UIKit

class ballgrid: UIView
{
    
    
    
    var BallArray: [[UIImageView]] = [[]]

    func clearsubviews()
    {
        // Clear current views
        for view in self.subviews
        {
            view.removeFromSuperview()
        }
    }
    
    
    func drawallballs(n: Int, x: Int, y: Int, xm: Int,ym: Int, propping: Bool, blocking: Bool)
    {
        clearsubviews()

        let topy = max(y,ym)
        let topx = max(x,xm)
        
         BallArray = Array(count: n, repeatedValue:Array(count: n, repeatedValue: UIImageView()))
       
        // Set self to incoming frame
        let dx = self.frame.height/CGFloat(n)
        
        if topx != 0 && topy != 0
        {
        
            for row in 0...topx-1
            {
                    for col in 0...topy-1
                    {
                        let ball = UIImageView()
                        ball.opaque = true
                        self.addSubview(ball)
                        ball.frame = CGRect(x: CGFloat(row)*dx, y: self.frame.height - CGFloat(col+1)*dx, width: dx, height: dx)
                        
                        let imgname = findmyballs(x, y: y, xm: xm, ym: ym, lx: row, ly: col,propping: propping, blocking: blocking)
        
                        
                        ball.image = UIImage(named: imgname)
                
                        BallArray[row].append(ball)
                        
                    }
            }
        }
        
    }
    
    
    
    
    
    // A little basic setting up.
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        self.backgroundColor = UIColor.blueColor()
        self.clearsContextBeforeDrawing = true
        
        
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.clearsContextBeforeDrawing = true
        
        
    }
    
    
    
}