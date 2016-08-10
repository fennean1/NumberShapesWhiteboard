//
//  HelpFiles.swift
//  NumberShapes Whiteboard
//
//  Created by Andrew Fenner on 6/21/16.
//  Copyright © 2016 NumberShapes. All rights reserved.
//

import Foundation
import UIKit

class imagewithdetails: UIImage
{
    var name = "ImageName"
    var text = "A/An Image"
    
}

let AddAndSub = UIImage(named: "Plus_Minus")
let SwipeUp = UIImage(named: "Swipe Up")
let HideMarkers = UIImage(named: "HideButton")
let QuestionMark = UIImage(named: "Transparent Question Mark")
let PinchOut = UIImage(named: "PinchOut")
let PinchIn = UIImage(named: "PinchIn")
let PointerHand = UIImage(named: "PointerHand")
let Reset = UIImage(named: "Reset")
let SharpMarker = UIImage(named: "CroppedSharpMark")!
let SharpMarkerSelected = UIImage(named: "HighLightMark")
let SwipeRight = UIImage(named: "Swipe Right")
let SliderThumb = UIImage(named: "SeriousGlassThumb")
let EqualsButton = UIImage(named: "=")
let PropButton = UIImage(named: "PropButton")
let MultiplicationButton = UIImage(named: "MultiButton")
let UpSideDownSharpMark =  UIImage(CGImage: SharpMarker.CGImage!, scale: CGFloat(1.0), orientation: .DownMirrored)
let UpSideDownSharpMarkSelected = UIImage(CGImage: SharpMarkerSelected!.CGImage!, scale: CGFloat(1.0), orientation: .DownMirrored)
let FracBall = UIImage(named: "Sphere")
let Orange = UIImage(named: "Orange")
let Record = UIImage(named: "Record")
let Flower = UIImage(named: "Flower")
let FractionsBlock = UIImage(named: "FractionBlock")
let Dollar = UIImage(named: "Dollar")

extension String
{
    func getstringprefix(Up: Bool) -> String
    {
        let S = Array(self.characters)
        
        let vowels: [Character] = ["A","E","I","O","U"]
        
        if vowels.contains(S[0])
        {
            if Up == true
            {
                return "An " + self
            }
            else
            {
              return "an " + self
            }
        }
        else {return "a " + self}
    }
    
}
