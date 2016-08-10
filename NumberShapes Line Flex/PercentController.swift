//
//  LandingViewController.swift
//  NumberShapes Whiteboard
//
//  Created by Andrew Fenner on 12/21/15.
//  Copyright © 2015 NumberShapes. All rights reserved.
//

import Foundation
import UIKit


class PercentsViewController: UIViewController
{

    let pinch = pinchit()
    
    @IBAction func helpme(sender: UIButton)
    {
        let help = helpmodel.percentsHelp
        
        var i = 0
        
        let vc = UIAlertController(title: "\n\n\n", message: help[i].0, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Done", style: .Default , handler: nil)
        
        let instImgView = UIImageView()
        instImgView.image = help[i].1
        
        let nextAction = UIAlertAction(title: "Next", style: .Default , handler: {(alertaction) -> Void in
            
            i = i+1
            
            let j = i%(help.count)
            
            vc.message =  help[j].0
            instImgView.image = help[j].1
            
            self.presentViewController(vc, animated: true, completion: nil)
        })
        
        vc.addAction(okAction)
        vc.addAction(nextAction)
        
        self.presentViewController(vc, animated: true, completion:{(alertaction) -> Void in
            
            instImgView.frame = CGRect(x: 0, y: 0, width: vc.view.frame.height/3, height: vc.view.frame.height/3)
            
            instImgView.center = CGPoint(x: vc.view.frame.width/2, y: vc.view.frame.height/4)
            
            vc.view.addSubview(instImgView)
        })
        
    }

    
    
    @IBAction func reset(sender: UIButton)
    {
        
        model.percent = 50
        model.linemax = 25
        model.hundredval = 20
        
        let _minn = max(model.hundredval,model.percenttodec*model.hundredval)
        model.linemax = pinch.newn(_minn, scale: CGFloat(pinch.scale),maxx: CGFloat(model.linemaxpossible),current: CGFloat(model.linemax))
        LineAndBarsView.NumberLine.drawme(model.linemax)
        Describer.text = Describer._text
        MarkersView.HundredMark.center.x = model.hundredx
        MarkersView.PercentMark.center.x = model.percentx
        LineAndBarsView.Bars.percentlbl.center = LineAndBarsView.Bars.lblrect.origin
        LineAndBarsView.Bars.percentlbl.text = "\(Int(model.percent))%"
        LineAndBarsView.Bars.setNeedsDisplay()

        
        
    }
    
    func handleswipes(sender: UISwipeGestureRecognizer)
    {
        
            if model.hundredselected == true
            {
                
                if sender.direction == .Up && model.hundredval <= model.linelength - 0.1
                {
                    print("swipedup")
                    model.hundredval = model.hundredval + 0.1
                }
                else if sender.direction == .Down && model.hundredval >= 0.1
                {
                    model.hundredval = model.hundredval - 0.1
                }
                    
                if sender.direction == .Right && model.hundredval <= model.linelength - 0.01
                {
                    model.hundredval = model.hundredval + 0.01
                }
                else if sender.direction == .Left && model.hundredval >= 0.01
                {
                    model.hundredval = model.hundredval - 0.01
                }
            }
            else if model.percentselected == true
            {
                if sender.direction == .Up && model.percent <= Int(model.linelength) - 10
                {
                    model.percent = model.percent + 10
                }
                else if sender.direction == .Down && model.percent >= 10
                {
                    model.percent = model.percent - 10
                }
                
                if sender.direction == .Right && model.percent <= Int(model.linelength) - 1
                {
                    model.percent = model.percent + 1
                }
                else if sender.direction == .Left && Int(model.percent) >= 1
                {
                    model.percent = model.percent - 1
                }
            }
        
        Describer.text = Describer._text
        MarkersView.HundredMark.center.x = model.hundredx
        MarkersView.PercentMark.center.x = model.percentx
        LineAndBarsView.Bars.percentlbl.center = LineAndBarsView.Bars.lblrect.origin
        LineAndBarsView.Bars.percentlbl.text = "\(Int(model.percent))%"
        LineAndBarsView.Bars.setNeedsDisplay()
        
    }
    
    var linesandbarsframe: CGRect
    {
    
        let w = self.view.frame.width*18/20
        let h = w/10
        let x = (self.view.frame.width-w)/2
        let y = self.view.frame.height - 3*h
    
        return CGRect(x: x, y: y, width: w, height: h)

    }

    
    var markersframe: CGRect
    {
        let w = self.linesandbarsframe.width
        let h = 2*linesandbarsframe.height/3*215/155
        let x = self.view.frame.width/2 - w/2
        let y = linesandbarsframe.origin.y - h
        
        return CGRect(x: x, y: y, width: w, height: h)
        
    }
    
    var describerframe: CGRect
    {
        
        let w = self.view.frame.width
        let h = 1/30*w
        let x = self.view.frame.width/2-w/2
        let y = 4*h
        
        return CGRect(x: x, y: y, width: w, height: h)
        
    }
    
    
    override func viewDidAppear(animated: Bool)
    {
    
        Describer = describer(frame: describerframe)
        LineAndBarsView = lineandbarsview(frame: linesandbarsframe)
        MarkersView = markersview(frame: markersframe)
        self.view.addSubview(LineAndBarsView)
        self.view.addSubview(MarkersView)
        self.view.addSubview(Describer)
        MarkersView.setNeedsDisplay()
        LineAndBarsView.Bars.setNeedsDisplay()
        
    }

    func pinched(sender: pinchit)
    {

        let _minn = max(model.hundredval,model.percenttodec*model.hundredval)
        model.linemax = sender.newn(_minn, scale: CGFloat(sender.scale),maxx: CGFloat(model.linemaxpossible),current: CGFloat(model.linemax))
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        print("Poop")
        
        let _minn = max(model.hundredval,model.percenttodec*model.hundredval)
        model.linemax = pinch.newn(_minn, scale: CGFloat(pinch.scale),maxx: CGFloat(model.linemaxpossible),current: CGFloat(model.linemax))
        LineAndBarsView.NumberLine.drawme(model.linemax)
        Describer.text = Describer._text
        MarkersView.HundredMark.center.x = model.hundredx
        MarkersView.PercentMark.center.x = model.percentx
        LineAndBarsView.Bars.percentlbl.center = LineAndBarsView.Bars.lblrect.origin
        LineAndBarsView.Bars.percentlbl.text = "\(Int(model.percent))%"
        LineAndBarsView.Bars.setNeedsDisplay()
        
    }
    
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()

        pinch.cancelsTouchesInView = false
        pinch.addTarget(self, action: #selector(self.pinched(_:)))
        
        self.view.addGestureRecognizer(pinch)
        
        // Setting up swipe gestures
        let leftSwipe = UISwipeGestureRecognizer(target: self, action:#selector(self.handleswipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleswipes(_:)))
        let downSwipe = UISwipeGestureRecognizer(target: self, action:#selector(self.handleswipes(_:)))
        let upSwipe = UISwipeGestureRecognizer(target: self, action:#selector(self.handleswipes(_:)))
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(downSwipe)
        view.addGestureRecognizer(upSwipe)
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        downSwipe.direction = .Down
        upSwipe.direction = .Up
        
    

    }


    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
