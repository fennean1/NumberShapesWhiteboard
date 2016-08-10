//
//  PinchHandler.swift
//  2D NumberLine
//
//  Created by Andrew Fenner on 1/6/16.
//  Copyright © 2016 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit

class pinchhandler: UIPinchGestureRecognizer
{
    
    
    func initialize()
    {
        self.cancelsTouchesInView = false
    }
    
    
    func GetNewN(minpossibleN: Int, maxpossibleN: Int, scale: CGFloat, n: Int) -> Int
    {
        
        self.cancelsTouchesInView = false
        
        let newN = Int(CGFloat(n)*1/sqrt(scale))
        
        if newN < minpossibleN
        {
            return n
        }
        else if newN <= 5
        {
            return 5
        }
        else if newN >= maxpossibleN
        {
            return maxpossibleN
        }
        else
        {
            return newN
        }
        
    }
    
}



class pinchit: UIPinchGestureRecognizer
{
    var newval: CGFloat = 1
    var returnval: Int!
    
    func newn(minn: CGFloat,scale: CGFloat,maxx: CGFloat, current: CGFloat) -> Int
    {
        
        newval = CGFloat(current)*1/(scale*scale)
        
        let toobig = newval > CGFloat(maxx)
        let toosmall = newval < minn
        
        if toobig
        {
            returnval = Int(maxx)
        }
        else if toosmall
        {
            returnval = Int(minn.Round)
        }
        else
        {
            returnval = Int(newval.Round)
        }
        
        self.scale = 1
        
        return returnval
    }
    
}


class swipekey: UIView
{
    
    var lbls: [UILabel] = []
    
    let keyImage = UIImageView()
    
    // A little basic setting up.
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        let size = CGSize(width: frame.width/3, height: frame.width/3)
        
        for i in 0...3
        {
            let new = UILabel()
            new.backgroundColor = UIColor.clearColor()
            new.font = UIFont(name: "Chalkboard SE", size: self.frame.height/8)
            new.textAlignment = .Center
            self.addSubview(new)
            lbls.append(new)
            lbls[i].frame = CGRect(origin: CGPointZero, size: size)

        }
    
        let p0 = frame.width/6
        let p1 = frame.width/2
        let p2 = 5/6*frame.width
        

        lbls[0].center = CGPoint(x: p0, y: p1) // Left
        lbls[1].center = CGPoint(x: p1, y: p0) // Up
        lbls[2].center = CGPoint(x: p2, y: p1) // Right
        lbls[3].center = CGPoint(x: p1, y: p2) // Down
        keyImage.frame = CGRect(origin: CGPointZero, size: size)
        keyImage.center = CGPoint(x: p1, y: p1) //Image
        keyImage.image = UIImage(named: "SwipeKey2")
        self.addSubview(keyImage)
        
    }
    
    func setkey(up: String, left: String,right: String,down: String,emph: Int?)
    {
        lbls[0].text = left
        lbls[1].text = up
        lbls[2].text = right
        lbls[3].text = down
        
        if let i = emph
        {
            lbls[i].textColor = UIColor.blueColor()
        }
    }
    
}


