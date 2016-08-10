//
//  LandingViewController.swift
//  NumberShapes Whiteboard
//
//  Created by Andrew Fenner on 12/21/15.
//  Copyright © 2015 NumberShapes. All rights reserved.
//

import Foundation
import UIKit


class LandingViewController: UIViewController
{
    @IBOutlet weak var ShowIntegersBtn: circleButton!

    @IBOutlet weak var ShowDecimalsBtn: circleButton!
    
    @IBOutlet weak var ShowFractionsBtn: circleButton!
    
    @IBOutlet weak var ShowMultiplicationBtn: circleButton!
 
    
    
    @IBOutlet weak var ShowThousandsButton: circleButton!
    
    // This is actually a show percents button now
    @IBOutlet weak var ShowHundredsBtn: circleButton!
    
    @IBOutlet weak var LogoBtn: UIButton!

    
    override func viewDidLayoutSubviews()
    {
 
        
        let h = view.frame.height/6
        let w = h
        
        let y = view.frame.height/2-w/2
        let cx = view.frame.width/2-w/2
        let lx = cx - 1.5*w
        let rx = cx + 1.5*w
        
        ShowFractionsBtn.frame = CGRect(x: lx, y: y, width: w, height: h)
        ShowIntegersBtn.frame = CGRect(x: cx, y: y, width: w, height: h)
        ShowDecimalsBtn.frame = CGRect(x: rx, y: y, width: w, height: h)
        ShowMultiplicationBtn.frame = CGRect(x: cx, y: y+1.5*h, width: w, height: h)
        ShowHundredsBtn.frame = CGRect(x: lx, y: y+1.5*h, width: w, height: h)
        
        ShowThousandsButton.frame = CGRect(x: rx, y: y+1.5*h, width: w, height: h)
        
        view.addSubview(ShowFractionsBtn)
        view.addSubview(ShowDecimalsBtn)
        view.addSubview(ShowIntegersBtn)
        view.addSubview(ShowThousandsButton)
        view.addSubview(ShowMultiplicationBtn)
        view.addSubview(ShowHundredsBtn)
        
        ShowIntegersBtn.setUpLabel("+Integers")
        ShowFractionsBtn.setUpLabel("Fractions")
        ShowDecimalsBtn.setUpLabel("Decimals")
        ShowMultiplicationBtn.setUpLabel(" Arrays ")
        ShowHundredsBtn.setUpLabel("Percents")
        ShowThousandsButton.setUpLabel("Hundreds")
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
