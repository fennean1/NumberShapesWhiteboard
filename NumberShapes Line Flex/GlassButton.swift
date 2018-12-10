

import Foundation
import UIKit


// For creating switches that have a label element dicating what state the switch is in.
class circleButton: UIButton
{
    
    var btnLabel = UILabel()
    
    
    func setUpLabel(title: String)
    {
        // Setting up label frame dimensions
        let s = self.frame.height
        let w = s
        let h = w/(CGFloat(title.characters.count))*1.5
        let x = CGFloat(0)
        let y = s/2-h/2
        let lblframe = CGRect(x: x, y: y, width: w, height: h)
        let fontsize = 5/8*h
        
        
        self.addSubview(btnLabel)
        btnLabel.frame = lblframe
        btnLabel.textAlignment = NSTextAlignment.Center
        btnLabel.font = UIFont(name: "ChalkBoard SE", size: fontsize)
        btnLabel.text = title
    }
    
    
    // A little basic setting up.
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        
        self.setImage(UIImage(named: "Transparent Glass Circle"), forState: .Normal)
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Fill
        self.contentVerticalAlignment = UIControlContentVerticalAlignment.Fill
        self.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.setImage(UIImage(named: "Transparent Glass Circle"), forState: .Normal)
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Fill
        self.contentVerticalAlignment = UIControlContentVerticalAlignment.Fill
        self.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
    }
    
    
    
}