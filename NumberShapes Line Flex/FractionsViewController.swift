// All of this code is fucky and needs to be redone.

import UIKit
import Foundation
import Darwin

var setfrac: (Int!,Int!,Bool!) = (0,0,false)

struct fractionModel
{
    static var Numerator = 8
    static var Denominator = 12
    static var CurrentImage = UIImage()
    static var CurrentImageName = "Sphere"
}



class FractionsViewController: UIViewController
{
    
    var ScaleFactor = 1
    
    var FractionBall = fractionball!(nil)
    
    var FractionBar = fractionbar!(nil)
    
    var FractionDescriptorWithObjectName = fractionofathingdescriptor!(nil)
    
    @IBAction func switchwhattocut(sender: UIButton)
    {
        
        fractionModel.CurrentImageName = sender.restorationIdentifier!
        
        FractionBall.img = UIImage(named: fractionModel.CurrentImageName)
        
        updateDisplay()

        FractionDescriptorWithObjectName.write(fractionModel.Numerator, D: fractionModel.Denominator, Img: fractionModel.CurrentImageName)
        
    }
    


    
    // This has the wrong name from when i was just fucking around
    @IBAction func reduce(sender: UIPinchGestureRecognizer)
    {
        var n = fractionModel.Numerator
        var d = fractionModel.Denominator
        
        if sender.state == .Ended
        {
            if fractionModel.Numerator != 0
            {
                if sender.scale > 1
                {
                    if d/ScaleFactor*(ScaleFactor+1) <= 100
                    {
                        
                        n = n/ScaleFactor*(ScaleFactor+1)
                        
                        d = d/ScaleFactor*(ScaleFactor+1)
                        
                        ScaleFactor = ScaleFactor+1
                        
                        fractionModel.Denominator = d
                        fractionModel.Numerator = n
                        
                    }
                }
                else if sender.scale < 1 && n != 1
                {
                    reduce()
                    ScaleFactor = 1
                }
            }
        }
        
        updateDisplay()
        
    }
    
    @IBAction func help(sender: UIButton)
    {
        
        let help = helpmodel.fractionsHelp
        
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
    
    
    
    @IBAction func HandleSwipes(sender: UISwipeGestureRecognizer)
    {
        
        var n = fractionModel.Numerator
        var d = fractionModel.Denominator
        
        ScaleFactor = 1
        
        if sender.direction == .Up
        {
            if d < 100
            {
                d += 1
            }
        }
        else if sender.direction == .Down
        {
            if d != 1 && n != d
            {
                d -= 1
            }
        }
        else if sender.direction == .Left
        {
            if n != 0
            {
                n -= 1
            }
        }
        else if sender.direction == .Right
        {
            if d != n
            {
                n += 1
            }
        }
        
        fractionModel.Numerator = n
        fractionModel.Denominator = d
        
        updateDisplay()
        
    }
    
    
    func GCD(A: Int, B: Int) -> Int
    {
        if A != B
        {
            let a = abs(A-B)
            let b = min(A,B)
            return GCD(a,B: b)
        }
        else
        {
            return A
        }
    }
    
    // This algorithm is a little wonky right now
    func reduce()
    {   
        
        let n = fractionModel.Numerator
        let d = fractionModel.Denominator
        
        let gcd = GCD(n, B: d)
        
        if gcd != 1
        {
            
            let ln = n/gcd
            let ld = d/gcd
            
            let nextn = n - ln
            var nextd = nextn/ln
            nextd = nextd*ld
            
            fractionModel.Numerator = nextn
            fractionModel.Denominator = nextd
        }
        
    }
    
    
    func updateDisplay()
    {
        
        FractionBall.writefrac(fractionModel.Numerator, d: fractionModel.Denominator)
        FractionDescriptorWithObjectName.write(fractionModel.Numerator,D: fractionModel.Denominator, Img: fractionModel.CurrentImageName)
        
    }
    
    
    override func viewDidAppear(animated: Bool)
    {
        
        var fractiondescriptorframe: CGRect
        {
            
            let h = 1/5*view.frame.height
            let w = 5*h
            let x = view.frame.width/2 - w/2
            let y = 1/10*view.frame.height
            
            return CGRect(x: x, y: y, width: w, height: h)
        }
        
        var fractionballrect: CGRect
        {
            let h = (view.frame.height - (fractiondescriptorframe.origin.y + fractiondescriptorframe.height))*8/9
            let w = h
            let x = view.frame.width/2 - h/2
            let y = fractiondescriptorframe.origin.y + fractiondescriptorframe.height + 1/10*h
            
            return CGRect(x: x, y: y, width: w, height: h)
        }
        
        var fractionbarrect: CGRect
        {
            
            let h = fractionballrect.height*2/5
            let w = 1000/426*h
            let x = self.view.frame.width/2 - w/2
            let y = fractionballrect.origin.y
            
            return CGRect(x: x, y: y, width: w, height: h)
            
        }
        
        FractionDescriptorWithObjectName = fractionofathingdescriptor(frame: fractiondescriptorframe)
        view.addSubview(FractionDescriptorWithObjectName)
        
        FractionBall = fractionball(frame: fractionballrect)
        FractionBall.img = UIImage(named: fractionModel.CurrentImageName)
        FractionBall.writefrac(fractionModel.Numerator, d: fractionModel.Denominator)
        view.addSubview(FractionBall)
        
        updateDisplay()
        
    }
    
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(FractionsViewController.HandleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(FractionsViewController.HandleSwipes(_:)))
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(FractionsViewController.HandleSwipes(_:)))
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(FractionsViewController.HandleSwipes(_:)))
        
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(downSwipe)
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        upSwipe.direction = .Up
        downSwipe.direction = .Down
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


