//
//  GridManager.swift
//  2D NumberLine
//
//  Created by Andrew Fenner on 1/7/16.
//  Copyright © 2016 Andrew Fenner. All rights reserved.
//

import Foundation
import UIKit


// This finds the name of the ball that needs to be displayed at a given location on the grid. This function will actually be called for each and every ball that appears on the grid.
func findmyballs(x: Int, y: Int, xm: Int, ym: Int, lx: Int, ly: Int, propping: Bool, blocking: Bool) -> String
{
    

    //Array that will dictate image names. Will depend on whether we're balling or not.
    var img: [String] = []
    
    
    //We'll assing one of these to image depending on balling or not
    let ballnamearray = ["BlueBall","BlueRing","OrangeBall","OrangeRing"]
    let blocknamearray = ["BlueBlock","BlueRect","OrangeBlock","OrangeBox"]
    
    var myball = ""
    
    // "Blocking" determines whether or not the grid is showing blocks or balls.
    if blocking == false
    {
        img = ballnamearray
    }
    else if blocking == true
    {
        img = blocknamearray
    }
    
    // Simply for naming so we can trace in the if statements
    let solidblue = img[0]
    let openblue = img[1]
    let solidorange = img[2]
    let openorange = img[3]

    
    // Key: Index: 0-> SolidBlue? 1-> OpenBlue? 2-> SolidOrange? 3-> OpenOrange
    func NoEdgeCaseProtocol(var l: Int,m: Int,v:Int) -> String
    {
        var theball: String!
        
        l = l+1
        
        let a = [l,m,v].sort(<)
        
        let option: (Int,Int,Int)? = (a[0],a[1],a[2])
        
        if case .Some(-1,_,_) = option
        {
            theball = solidblue
        }
        else if case .Some(l,_,_) = option
        {
            theball = solidblue
        }
        else if case .Some(m,l,_) = option
        {
            theball = solidorange
        }
        else if case .Some(v,l,_) = option
        {
            if propping == true
            {
                theball = solidorange
            }
            else
            {
                theball = openblue
            }
        }
        else
        {
            // This is a hacky way of handling when there is no ball that matches the critera.  It "tricks" UIKit into not rendering a ball by returning a string that doesn't not correspond any asset.
            theball = ""
        }
        
        return theball
        
    }

    
return NoEdgeCaseProtocol(lx, m: xm, v: x)
    
    
}