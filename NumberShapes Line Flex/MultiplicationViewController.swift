//
//  ViewController.swift
//  2D NumberLine
//
//  Created by Andrew Fenner on 1/4/16.
//  Copyright © 2016 Andrew Fenner. All rights reserved.
//

import UIKit

class MultiplicationViewController: UIViewController
{
    @IBOutlet weak var ProportionBtn: UIButton!
    
    @IBOutlet weak var helpbutton: UIButton!
    // Marks
    var xm = -1
    var ym = -1
    
    @IBOutlet weak var multlbl: UILabel!
  
    @IBOutlet weak var multiplicationbtn: UIButton!

    @IBOutlet weak var propLbl: UILabel!
    
    @IBOutlet weak var equalsbtn: UIButton!
    
    var operating: Bool = false
    
    var propping: Bool = false
    
    var multiplying: Bool = false
    
    var pinched = false
    
    var blocking = false
    
    var Pincher = pinchhandler()
    
    var Descriptor = UILabel()
    
    var ctr = 1
    
    

    

    @IBOutlet weak var operatorbutton: UIButton!
    
    // X and Y values
    var x = 4
    var y = 4
    var n = 12
    
    var TwoDGridFrame: CGRect!
    
    
    // Two dimensional number line handles pretty much everything that goes on.
    var TwoDGrid = twodimensionalnumberline()
    
    @IBAction func helpbuttonclicked(_ sender: UIButton)
    {
      
        let help = helpmodel.gridHelp
        
        var i = 0
        
        let vc = UIAlertController(title: "\n\n\n", message: help[i].0, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Done", style: .default , handler: nil)
        
        let instImgView = UIImageView()
        instImgView.image = help[i].1
        
        let nextAction = UIAlertAction(title: "Next", style: .default , handler: {(alertaction) -> Void in
            
            i = i+1
            
            let j = i%(help.count)
            
            vc.message =  help[j].0
            instImgView.image = help[j].1
            
            self.present(vc, animated: true, completion: nil)
        })
        
        vc.addAction(okAction)
        vc.addAction(nextAction)
        
        self.present(vc, animated: true, completion:{(alertaction) -> Void in
            
            instImgView.frame = CGRect(x: 0, y: 0, width: vc.view.frame.height/3, height: vc.view.frame.height/3)
            
            instImgView.center = CGPoint(x: vc.view.frame.width/2, y: vc.view.frame.height/4)
            
            vc.view.addSubview(instImgView)
        })

    }
    
    
    @IBAction func equalsbuttonclicked(_ sender: UIButton)
    {
        
        // If I'm already operating I just want to go back to multiplying
        if operating
        {
            multiplying = true
            operating = false
            operatorbutton.isHidden = false
            multlbl.isHidden = true
            multiplicationbtn.isHidden = true
            propLbl.isHidden = true
            ProportionBtn.isHidden = true
            sender.isHidden = false
        }
        else if !operating
        {
            if propping && x < xm
            {
                x = xm
            }
    
            multiplying = false
            operating = false
            propping = false
            multlbl.isHidden = false
            multiplicationbtn.isHidden = false
            operatorbutton.isHidden = true
            sender.isHidden = true
            ProportionBtn.isHidden = false
            propLbl.isHidden = false
        }

        xm = -1
   
    
        
        populatedescriptor()
        TwoDGrid.BallGrid.drawallballs(n, x: x, y: y, xm: xm, ym: ym,propping: propping, blocking: blocking)
        
     
        
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        
        view.isOpaque = true
        let lx = view.frame.width/2-3/4*view.frame.height/2
        let ly = 1/8*view.frame.height
        let w = 3/4*view.frame.height
        let h = w
        let FontSize = 3/8*ly
        
        // SetUp Descriptor
        Descriptor.font = UIFont(name: "ChalkBoard SE", size: FontSize)
        TwoDGridFrame = CGRect(x: lx, y: ly, width: w, height: h)
        TwoDGrid.drawme(TwoDGridFrame, n: 12)
        Descriptor.frame = CGRect(x: lx, y: ly-1/8*w, width: w, height: 1/8*h)
        view.addSubview(TwoDGrid)
        view.addSubview(Descriptor)
        
        TwoDGrid.BallGrid.drawallballs(n, x: x, y: y, xm: xm, ym: ym,propping: propping, blocking: blocking)
        
    }
    
    @IBAction func blockorballbuttonclicked(_ sender: UIButton)
    {
        
        blocking = !blocking
        
        if blocking
        {
            sender.setTitle("Balls", for: UIControlState())
        }
        else if !blocking
        {
            sender.setTitle("Blocks", for: UIControlState())
        }
        
        TwoDGrid.BallGrid.drawallballs(n, x: x, y: y, xm: xm, ym: ym,propping: propping, blocking: blocking)
        
    }
    
    
    @IBAction func multiplicationbuttonclicked(_ sender: UIButton)
    {
        
        
        propping = false
        
        // wasn't multiplying when clicked
        if !multiplying
        {
            sender.isHidden = true
            multlbl.isHidden = true
            ProportionBtn.isHidden = true
            propLbl.isHidden = true
            operatorbutton.isHidden = false
            equalsbtn.isHidden = false
            
        }
        // was already multiplying
        else if multiplying
        {
            // Button is never clicked in this state
        }
        
        multiplying = !multiplying
        populatedescriptor()
        TwoDGrid.BallGrid.drawallballs(n, x: x, y: y, xm: xm, ym: ym,propping: propping, blocking: blocking)
        
    }
    
    
    @IBAction func proportionbuttonclicked(_ sender: UIButton!)
    {
        
        operating = false
        multiplying = false
        
        if propping == false
        {
            xm = x
            sender.isHidden = true
            equalsbtn.isHidden = false
            propLbl.isHidden = true
            multlbl.isHidden = true
            multiplicationbtn.isHidden = true
        }
        else if propping == true
        {
            x = xm
            
            xm = -1
            sender.setImage(UIImage(named: "Transparent Glass Circle"), for: UIControlState())
            propLbl.isHidden = false
            multiplicationbtn.isHidden = false
            multlbl.isHidden = false
        }
      
        propping = !propping
        populatedescriptor()
             TwoDGrid.BallGrid.drawallballs(n, x: x, y: y, xm: xm, ym: ym,propping: propping, blocking: blocking)
        
    }
    
    
    
    @IBAction func horizontaloperatorclicked(_ sender: UIButton)
    {

        propping = false
        
        if operating == false
        {
              xm = x
              sender.isHidden = true
            
        }
        else if operating == true
        {
              xm = -1
              TwoDGrid.BallGrid.drawallballs(n, x: x, y: y, xm: xm, ym: ym,propping: propping, blocking: blocking)
              populatedescriptor()
        }
        
        operating = !operating
        populatedescriptor()
             TwoDGrid.BallGrid.drawallballs(n, x: x, y: y, xm: xm, ym: ym,propping: propping, blocking: blocking)
        
    }
    
    
    @IBAction func HandlePinch(_ sender: pinchhandler)
    {
        
        pinched = true
        
        // Value that n cannot drop beneath
        let minpossibleN = max(x,y,xm)
        
        n = sender.GetNewN(minpossibleN, maxpossibleN: 20, scale: sender.scale, n: n)
        
        // Doesn't draw grid
        TwoDGrid.drawme(TwoDGridFrame, n: n)
        
        
    }
  

    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {

        if pinched == true
        {
                 TwoDGrid.BallGrid.drawallballs(n, x: x, y: y, xm: xm, ym: ym,propping: propping, blocking: blocking)
        }
        
    }

    
    
    func HandleSwipes(_ sender: UISwipeGestureRecognizer)
    {
        
        // Swipe incrementing logic
        if sender.direction == .up
        {
            if y != n
            {
                y += 1
            }
        }
        else if sender.direction == .down
        {
            if y != 0
            {
                y -= 1
            }
        }
        else if sender.direction == .right
        {
            if x != n
            {
                x += 1
            }
        }
        else if sender.direction == .left
        {
            if x != 0
            {
                x -= 1
            }
        }
            TwoDGrid.BallGrid.drawallballs(n, x: x, y: y, xm: xm, ym: ym,propping: propping, blocking: blocking)
        
        populatedescriptor()
        
        
    }
    
    func populatedescriptor()
    {
    
        if operating && xm != x
        {
            if xm != -1 && ym == -1 && (xm-x) < 0
            {
                Descriptor.text = "(\(xm) + \(abs(xm-x))) x \(y)"
            }
            else if xm != -1 && ym == -1 && (xm-x) > 0
            {
                Descriptor.text = "(\(xm) - \(abs(xm-x))) x \(y)"
            }
        }
        else if propping
        {
            if  xm <= x
            {
                Descriptor.text = "\(xm*y) : \(abs((x-xm))*y)"
            }
            else if x < xm
            {
                 Descriptor.text = "\(x*y) : \(abs((x-xm))*y)"
            }
            
            
        }
        else if multiplying || xm == x
        {
             Descriptor.text = "\(x) x \(y)"
        }
        else
        {
            Descriptor.text = "\(x*y)"
        }
        


    }
    
    
    override func viewDidLoad()
    {
        let backGround = UIImageView()
        backGround.image = UIImage(named: "CloudsBackground")
        backGround.frame.styleFillContainer(container: self.view.frame)
        view.addSubview(backGround)
        view.sendSubview(toBack: backGround)
        
        // Configure descriptor
        Descriptor.textAlignment = NSTextAlignment.center
        Descriptor.adjustsFontSizeToFitWidth = true
        
        
        // These are hidden at startup
        operatorbutton.isHidden = true
        equalsbtn.isHidden = true
       
        // Setting up swipe gestures
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(MultiplicationViewController.HandleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(MultiplicationViewController.HandleSwipes(_:)))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(MultiplicationViewController.HandleSwipes(_:)))
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(MultiplicationViewController.HandleSwipes(_:)))
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(downSwipe)
        view.addGestureRecognizer(upSwipe)
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        downSwipe.direction = .down
        upSwipe.direction = .up

        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

