//
//  Bars.swift
//  NumberShapes Whiteboard
//
//  Created by Andrew Fenner on 6/4/16.
//  Copyright © 2016 NumberShapes. All rights reserved.
//

import Foundation
import UIKit

var approximatelyequal = " ≈ "
var isequal = " = "
var LineAndBarsView: lineandbarsview!
var MarkersView: markersview!
var Describer: describer!

struct model
{
    static var percent: Int = 50
    {
        didSet
        {
            if percent <= 0
            {
                percent = 0
            }
            else if percentx >= linelength
            {
                percent = Int(linelength/hundredx*100)
            }
        }
    }

    static var hundredval: CGFloat = 20
    {
        didSet
        {
            if hundredval >= CGFloat(linemax)
            {
                hundredval = CGFloat(linemax)
            }
            else if hundredval <= 0
            {
                hundredval = 0.001
            }
        }
    }
    static var linemax: Int = 25
    
    static var hundredselected: Bool = false
    {
        didSet
        {
            if hundredselected == true
            {
                MarkersView.HundredMark.image = UpSideDownSharpMarkSelected
                MarkersView.PercentMark.image = UIImage(named: "CroppedSharpMark")
            }
        }
    }
    
    static var percentselected: Bool = false
    {
        didSet
        {
            if percentselected == true
            {
                MarkersView.PercentMark.image = UIImage(named: "HighLightMark")
                MarkersView.HundredMark.image = UIImage(cgImage: SharpMarker.cgImage!, scale: CGFloat(1.0), orientation: .downMirrored)
            }
        }
    }
    
    static let linemaxpossible = Int(1000)
    
    static var percenttodec: CGFloat
    {
        return CGFloat(percent)/100
    }
    
    static var linelength: CGFloat
    {
        return MarkersView.frame.width
    }
    
    static var hundredx: CGFloat
    {
        
        return model.hundredval/CGFloat(linemax)*linelength

    }
    
    static var percentx: CGFloat
    {

        return percenttodec*hundredx
     
    }
}

class describer: UILabel
{
    
    // Inits
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.text = self._text
        self.textAlignment = NSTextAlignment.center
        self.font = UIFont(name: "ChalkBoard SE", size: self.frame.height)
        self.textColor = UIColor.black
        self.frame = frame
    }
    
}

class lineandbarsview: UIView
{
    
    var Bars = bars()
    var NumberLine = horizontalnumberline()

    // Inits
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        // Initialize BarFrame and NumberLine
        Bars = bars(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height/2))
        let numberlineframe = CGRect(x: 0, y: self.frame.height/2, width: self.frame.width, height: self.frame.height/2)
        self.addSubview(Bars)
        NumberLine = horizontalnumberline(frame: numberlineframe)
        self.addSubview(NumberLine)
        NumberLine.drawme(Int(model.linemax))
    }

}


class markersview: UIView
{
    // Code to make sure that we can detect touches of markers even when they are outside their containing view.
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView?
    {
        if(!self.clipsToBounds && !self.isHidden && self.alpha >= 0.0){
            let subviews = self.subviews.reversed()
            for member in subviews {
                let subPoint = member.convert(point, from: self)
                if let result:UIView = member.hitTest(subPoint, with: event) {
                    return result;
                }
            }
        }
        return nil
    }
    
    
    
    // Mark that is dragged to set the hundred point
    var HundredMark: hundredmark!
    
    // Mark that is dragged to set the percent mark
    var PercentMark: percentmark!

    
    // Compute the x coordinate of the hundred
    var hx: CGFloat
    {
        return model.hundredval/CGFloat(model.linemax)*self.frame.width
    }
    
    var px: CGFloat
    {
        return model.percenttodec*hx
    }

    
    // Inits
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.clearsContextBeforeDrawing = true
        self.backgroundColor = UIColor.clear
        self.setNeedsDisplay()
        
        let markerh = self.frame.height
        let markerw = markerh*155/215
        
        var hundredframe: CGRect
        {
            let h = markerh
            let w = markerw
            let x = hx - w/2
            let y = self.frame.height + markerh
            
            return CGRect(x: x, y: y, width: w, height: h)
        }
        
   
        
        var percentframe: CGRect
        {
            let h = markerh
            let w = markerw
            let x = px - w/2
            let y = CGFloat(0)
            
            return CGRect(x: x, y: y, width: w, height: h)
        }
        
        HundredMark = hundredmark(frame: hundredframe)
        PercentMark = percentmark(frame: percentframe)
        
        self.addSubview(HundredMark)
        self.addSubview(PercentMark)
        
    }
    
}

class bars: UIView
{
    

    // Label the indicate what the current percentage is.
    var percentlbl = UILabel()
    var wpercentlbl = UILabel()
    
    
    // Compute the x coordinate of the hundred
    var hundredx: CGFloat
    {
        return model.hundredval/CGFloat(model.linemax)*self.frame.width
    }
    
    var percentx: CGFloat
    {
        return model.percenttodec*hundredx + 0.001
    }
    
    
    var percentrect: CGRect
    {
        let x = CGFloat(0)
        let y = CGFloat(0)
        let w = percentx
        let h = self.frame.height
        
        return CGRect(x: x, y: y, width: w, height: h)
    }
    
    var hundredpercentrect: CGRect
    {
        let x = CGFloat(0)
        let y = CGFloat(0)
        let w = hundredx
        let h = self.frame.height
        
        return CGRect(x: x, y: y, width: w, height: h)
    }
    
    var lblrect: CGRect
    {
        let x = percentx/2
        let y = self.frame.height/2
        let w = self.frame.width
        let h = w
        
        return CGRect(x: x, y: y, width: w, height: h)
        
    }
    
    override func draw(_ rect: CGRect)
    {
        
        let mybluecolor = UIColor(red: 0.03, green: 0.46, blue: 0.798, alpha: 1.0)
        
        let percentpath = UIBezierPath(rect: percentrect)
        
        mybluecolor.setStroke()
        mybluecolor.setFill()
        percentpath.fill()
        
        let hundredpath = UIBezierPath(rect: hundredpercentrect)
        hundredpath.lineWidth = 2.5
        
        var hundredstroke: UIColor
        {
            if model.percent > 100
            {
                return UIColor.black
            }
            else
            {
                return mybluecolor
            }
        }
        
        hundredstroke.setStroke()
        hundredpath.stroke()
        
    }
    
    // Inits
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.clearsContextBeforeDrawing = true
        self.backgroundColor = UIColor.clear
        self.setNeedsDisplay()
        self.addSubview(percentlbl)
        percentlbl.text = "\(model.percent)%"
        percentlbl.textAlignment = NSTextAlignment.center
        percentlbl.adjustsFontSizeToFitWidth = true
        percentlbl.font = UIFont(name: "ChalkBoard SE", size: self.frame.height*3/5)
        percentlbl.textColor = UIColor.white
        percentlbl.frame = lblrect
        percentlbl.center = lblrect.origin
    }
}



class hundredmark: UIImageView
{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        model.hundredselected = true
        model.percentselected = false
    }
    
    
    func panhandle(_ sender: UIPanGestureRecognizer)
    {
        
        model.hundredselected = true
        model.percentselected = false
        
        let translation = sender.translation(in: sender.view)
        
        if let view = sender.view
        {
            if (view.center.x < 0 && translation.x > 0) || (view.center.x > model.linelength && translation.x < 0) || (view.center.x > 0 && view.center.x < model.linelength)
            {
                view.center = CGPoint(x: (view.center.x + translation.x),
                                      y: view.center.y)
                sender.setTranslation(CGPoint.zero, in: sender.view)
            }
        }

        
        // Calculate new hundred value and new location for percent mark.
        model.hundredval = (sender.view?.center.x)!/model.linelength*CGFloat(model.linemax)
        

        // Extension that gets the properly formatted text
        Describer.text = Describer._text
        MarkersView.PercentMark.center.x = model.percentx
        LineAndBarsView.Bars.percentlbl.center = LineAndBarsView.Bars.lblrect.origin
        LineAndBarsView.Bars.percentlbl.text = "\(Int(model.percent))%"
        LineAndBarsView.Bars.setNeedsDisplay()
        
        
        if sender.state == .ended || sender.state == .failed || sender.state == .cancelled
        {
            MarkersView.PercentMark.center.x = model.percentx+0.001
            MarkersView.HundredMark.center.x = model.hundredx+0.001
        }
        
    }
    
    // Inits
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panhandle))
        pan.cancelsTouchesInView = false
        self.addGestureRecognizer(pan)
        self.isUserInteractionEnabled = true
        self.image = UpSideDownSharpMark
    }
    
}

class percentmark: UIImageView
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        model.hundredselected = false
        model.percentselected = true
    }

    
    func panhandle(_ sender: UIPanGestureRecognizer)
    {
        model.hundredselected = false
        model.percentselected = true
        
        let translation = sender.translation(in: sender.view)
        
        if let view = sender.view
        {
            if (view.center.x < 0 && translation.x > 0) || (view.center.x > model.linelength && translation.x < 0) || (view.center.x > 0 && view.center.x < model.linelength)
            {
                view.center = CGPoint(x: (view.center.x + translation.x),
                                      y: view.center.y)
                sender.setTranslation(CGPoint.zero, in: sender.view)
            }
        }

        
        model.percent = Int(self.center.x/model.hundredx*100)
        print(model.percent, "Percent")
        
        Describer.text = Describer._text
        LineAndBarsView.Bars.percentlbl.center = LineAndBarsView.Bars.lblrect.origin
        LineAndBarsView.Bars.percentlbl.text = "\(Int(model.percent))%"
        LineAndBarsView.Bars.setNeedsDisplay()
        
        if sender.state == .ended || sender.state == .failed || sender.state == .cancelled || sender.state == .none
        {
            MarkersView.PercentMark.center.x = model.percentx+0.001
            MarkersView.HundredMark.center.x = model.hundredx+0.001
        }
        
    
    }

    
    // Inits
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panhandle))
        self.addGestureRecognizer(pan)
        self.isUserInteractionEnabled = true
        self.image = SharpMarker
    }
    
}



public extension CGFloat
{
    var cleanValue: String
    {
        if self.truncatingRemainder(dividingBy: 1) == 0
        {
            return String(format: "%.0f",self)
        }
        else
        {
            return String(format: "%.2f", self)
        }
    }
}

public extension CGFloat
{
    
    var Round: CGFloat
    {
        
        var T = self*100
        
        T = T.rounded()/100
    
        return T

    }
    
}

extension describer
{
    var _text: String
    {

        var symbol = isequal
        
        print(model.hundredval.Round,"rounded hundred")
        print(model.hundredval, "hundred not rounded")
        
        print(model.percenttodec.Round,"rounded percent")
        print(model.hundredval, "percent not rounded")
        
        let left = model.percenttodec*model.hundredval.Round
        let right = CGFloat(model.percenttodec.Round*model.hundredval.Round).Round
    
        
        print(left,"left")
        print(right,"right")

        
        if abs(left - right) > 0.001
        {
            print("notequal?")
            symbol = approximatelyequal
        }
        
        return "\(model.percent)% of " + model.hundredval.Round.cleanValue + symbol + right.cleanValue


    }
}





