//
//  WhoAmI.swift
//  NumberShapes Whiteboard
//
//  Created by Andrew Fenner on 12/30/15.
//  Copyright © 2015 NumberShapes. All rights reserved.
//

import Foundation

// m = mark, v = value of slider, l = location you're evaluating

func whoami(m: Int, v: Int,var l: Int, imgarr: [String]) -> String
{
    
    // Simply for naming so we can trace in the if statements
    let solidblue = imgarr[0]
    let openblue = imgarr[1]
    let solidorange = imgarr[2]
    //let openorange = img[3]

    let Nill = "NILL"

    var theball = Nill
    
        // Some index correction bullshit for this. Not totally tranparent but it's been working well.
        l += 1
    
        let a = [l,m,v].sort(<)
        
        let option: (Int,Int,Int)? = (a[0],a[1],a[2])
        
        if case .Some(-1,l,_) = option
        {
            theball = solidblue
        }
        else if case .Some(-1,_,l) = option
        {
            theball = Nill
        }
        else if case .Some(m,l,_) = option
        {
            if m == l
            {
                theball = solidblue
            }
            else
            {
                theball = solidorange
            }
        }
        else if case .Some(v,l,_) = option
        {
            if l == v
            {
                theball = solidblue
            }
            else
            {
                theball = openblue
            }
        }
        else if case .Some(l,v,_) = option
        {
            theball = solidblue
        }
        else if case .Some(_,m,v) = option
        {
            theball = solidblue
        }

    
    return theball
    
}


func precision(x: Float,n: Int) -> Float
{
    let y = pow(10,Double(n))
    return Float(round(Double(x)*y)/y)
}


