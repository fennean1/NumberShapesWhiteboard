//
//  StoryBoardClasses.swift
//  NumberShapes Line Flex
//
//  Created by Barbara L Fenner on 10/19/15.
//  Copyright © 2015 NumberShapes. All rights reserved.
//

import Foundation
import UIKit



class operateTwiceButton: UIButton
{
    
    // This button is sometimes set to hidden
    func alignToState(_ State: String)
    {
        switch State
        {
        case "WithShapesNotOperating":
            
            self.isHidden = true
            self.isEnabled = false
            
        case "WithNumbersNotOperating":
            
            self.isHidden = true
            self.isEnabled = false

        case "WithShapesOperatingOnce":
            
            self.isHidden = true
            self.isEnabled = false
            
        case "WithNumbersOperatingOnce":
            
            self.isHidden = false
            self.isEnabled = true
            
        case "OperatingTwice":
            
            self.isHidden = true
            self.isEnabled = false
            
        default:
            
            self.isHidden = true
            self.isEnabled = false
            
        }
    }

}


class operateOnceButton: UIButton
{
    
    // This button is never set to hidden
    func alignToState(_ State: String)
    {
        switch State
        {
        case "WithShapesNotOperating":
            
            self.setImage(UIImage(named: "Plus_Minus"), for: UIControlState())
            
        case "WithNumbersNotOperating":
            
            self.setImage(UIImage(named: "Plus_Minus"), for: UIControlState())

        case "WithShapesOperatingOnce":
        
            self.setImage(UIImage(named: "="), for: UIControlState())
            
        case "WithNumbersOperatingOnce":
            
            self.setImage(UIImage(named: "="), for: UIControlState())
            
        case "OperatingTwice":
            
            self.setImage(UIImage(named: "="), for: UIControlState())
            
        default:
            
            self.isEnabled = true
            self.isHidden = false
            self.setImage(UIImage(named: "Plus_Minus"), for: UIControlState())
            
        }
    }
    
}



class descriptor: UILabel
{
    // Determines the string that the descriptor must display
    func DescriptorText(_ Mark1: Int, Mark2: Int, Slider: Int) -> String
    {
        
        var OperatingOnce = false
        var OperatingTwice = false
        
        if Mark1 != -1
        {
            if Mark2 == -1
            {
                OperatingOnce = true
            }
            else if Mark2 != -1
            {
                OperatingOnce = true
                OperatingTwice = true
            }
        }
        
        
        var TextToDisplay = ""
        
        if !OperatingOnce && !OperatingTwice
        {
            
            TextToDisplay = "\(Slider)"
            
        }
        else if OperatingOnce && !OperatingTwice
        {
            TextToDisplay = "\(Mark1)"
            
            if Slider > Mark1
            {
                TextToDisplay += " + \(Slider - Mark1)"
            }
            else if Slider < Mark1
            {
                
                TextToDisplay += " - \(Mark1 - Slider)"
            }
            
        }
        else if OperatingOnce && OperatingTwice
        {
            
            // Set up first two
            if Mark2 > Mark1
            {
                TextToDisplay = "\(Mark1) + \(Mark2 - Mark1)"
            }
            else if Mark2 < Mark1
            {
                TextToDisplay = "\(Mark1) - \(Mark1 - Mark2)"
            }
            
            // Add third
            if Slider > Mark2
            {
                TextToDisplay += " + \(Slider - Mark2)"
            }
            else if Slider < Mark2
            {
                TextToDisplay += " - \(Mark2 - Slider)"
            }
            
        }
        
        return TextToDisplay
        
    }

    
    func alignToState(_ State: String)
    {
        switch State
        {
        case "WithShapesNotOperating":
            
            self.isHidden = true
            self.isEnabled = false
            
        case "WithNumbersNotOperating":
            
            self.isHidden = false
            self.isEnabled = true
        
        case "WithShapesOperatingOnce":
            
            self.isHidden = true
            self.isEnabled = false
            
        case "WithNumbersOperatingOnce":
            
            self.isHidden = false
            self.isEnabled = true
            
        case "OperatingTwice":
            
            self.isHidden = false
            self.isEnabled = true
        
        default:
            
            self.isHidden = false
            self.isEnabled = true
            
        }
    }
}


class shapebutton: UIButton
{
    
    // This button is never set to hidden
    func alignToState(_ State: String)
    {
        switch State
        {
        case "WithShapesNotOperating":
            
            self.isEnabled = true
            self.isHidden = false
            self.setImage(UIImage(named: "ShowWithNumbersButton"), for: UIControlState())
            
        case "WithNumbersNotOperating":
            
            self.isEnabled = true
            self.isHidden = false
            self.setImage(UIImage(named: "ShowWithShapesButton"), for: UIControlState())
            
        case "WithShapesOperatingOnce":
            
            self.isEnabled = true
            self.isHidden = false
            self.setImage(UIImage(named: "ShowWithNumbersButton"), for: UIControlState())
            
        case "WithNumbersOperatingOnce":
            
            self.isEnabled = true
            self.isHidden = false
            self.setImage(UIImage(named: "ShowWithShapesButton"), for: UIControlState())
            
        case "OperatingTwice":
            
            self.isEnabled = false
            self.isHidden = true
            
        default:
            
            self.isEnabled = true
            self.isHidden = false
            self.setImage(UIImage(named: "ShowWithShapes"), for: UIControlState())
            
        }
    }
}

// NumberShape class is just a UIView with image array subview..could there be more here?
class NumberShape: UIView
{
    var ImgArr: [UIImageView] = []

}

// Turns a number into a three element array of hundreds, tens and ones
func FindPlaceValues(_ number: Int) -> [Int]
{
    var PlaceValuesArray: [Int] = []

    if number >= 100
    {
        PlaceValuesArray.append(number - number%100)
        
        //Remove middle element if it's zero
        if number%100-number%10 != 0
        {
            PlaceValuesArray.append(number%100-number%10)
        }
        
        PlaceValuesArray.append(number%10)
    }
    else if 10 < number && number < 100
    {
        PlaceValuesArray.append(number%100-number%10)
        PlaceValuesArray.append(number%10)
    }
    else if number <= 10
    {
        PlaceValuesArray.append(number)
    }
    
    print(PlaceValuesArray)
    
    return PlaceValuesArray
    
}


func CreateNumberShape(_ number: Int, dim: CGFloat) -> NumberShape
{
    
        // Array that stores the place values (100,50,5) etc.
        let arr = FindPlaceValues(number)
    
        let ReturnShape = NumberShape()
        let ViewH = dim
        var ViewW = CGFloat(0)
    
        for index in 0...arr.count-1
        {
            if arr[index] != 0
            {
                print(index)
                ViewW = ViewW+ViewH
                let addImg = UIImageView()
                ReturnShape.ImgArr.append(addImg)
                ReturnShape.addSubview(addImg)
                let ImgX = ViewH*CGFloat(index)
                ReturnShape.ImgArr[index].frame = CGRect(x: ImgX, y: 0, width: ViewH, height: ViewH)
                ReturnShape.ImgArr[index].image = UIImage(named: "\(arr[index])")
            }
        }
    
        ReturnShape.frame = CGRect(x: 0, y: 0, width: ViewW, height: ViewH)
    
        return ReturnShape

}



class shapeDescriptor: UIView
{

    
    // Draws the views and assigns the images
    func DrawMyViews(_ M1: Int, S: Int, State: String)
    {
        // Remove current views
        for view in self.subviews
        {
            view.removeFromSuperview()
        }
        
        // Get traits for later use
        let frameH = self.frame.height
        let frameW = self.frame.width
        let frameCenter = frameW/2
        
        // General sizing concerns
        let nsH = 3/4*frameH
        
        
        if State == "WithShapesNotOperating" || S == M1
        {
            let FirstNumber = CreateNumberShape(S, dim: nsH)
            let CenterX = frameCenter-FirstNumber.frame.width/2
            self.addSubview(FirstNumber)
            FirstNumber.frame.origin = CGPoint(x: CenterX,y: 0)
            
        }
        else if State == "WithShapesOperatingOnce"
        {
            // Add the operator
            let Operation = UIImageView()
            self.addSubview(Operation)
            
            // Sizing shit with this is a little fucky right now.  It's not wrong or anything it's just not totally clear why or what is happening. Doesn't help that the plus sign has to be put at some fraction of all the other bullshit so that it looks right.  Maybe I should modify the asset so I can set it to be the same size as nsH (numbershape height) which is the parameter that's passed to the CreateNumberShape function so it knows what size to make the image view that it returns.
            let CenterX = frameCenter - nsH/4
            Operation.frame = CGRect(x: CenterX, y: 3/16*frameH, width: 1/2*nsH, height: 1/2*nsH)
            
            if S > M1
            {
                Operation.image = UIImage(named: "+")
            }
            else if S < M1
            {
                Operation.image = UIImage(named: "-")
            }
            
            let FirstNumber = CreateNumberShape(M1, dim: nsH)
            let SecondNumber = CreateNumberShape(abs(M1-S), dim: nsH)
            
            self.addSubview(FirstNumber)
            self.addSubview(SecondNumber)
            
            SecondNumber.frame.origin = CGPoint(x: frameCenter+nsH/3,y: 0)
            FirstNumber.frame.origin = CGPoint(x: frameCenter - nsH/3 - FirstNumber.frame.width,y: 0)

            
            
        }
    }
    
    func alignToState(_ State: String)
    {
        switch State
        {
        case "WithShapesNotOperating":
            
            self.isHidden = false
            
        case "WithNumbersNotOperating":
            
            self.isHidden = true
            
        case "WithShapesOperatingOnce":
            
            self.isHidden = false
            
        case "WithNumbersOperatingOnce":
            
            self.isHidden = true
            
        case "OperatingTwice":
            
            self.isHidden = true
            
        default:
            
           self.isHidden = true
            
        }
    }
}













// States:  ShapesOperatingOnlyOne
