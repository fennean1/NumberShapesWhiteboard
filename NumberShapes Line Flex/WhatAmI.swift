// This is the logic that determines where a ball is based on game state and index

import Foundation



// Takes a point on the numberline and returns the name of the image that should be at that point based on game attributes
// Takes a point on the numberline and returns the name of the image that should be at that point based on game attributes
// The name of the image as a function of game parameters
func WhatAmI(_ M1: Int, M2: Int, S: Int, IAmAt: Int, State: String)-> String
{
    
    var IAM = ""
    
    
    // Must ignore index below zero
    if IAmAt <= S && (State == "WithShapesNotOperating" || State == "WithShapesOperatingOnce")
    {
        IAM = "BlueBall"
    }
    else if IAmAt > S && (State == "WithShapesNotOperating" || State == "WithShapesOperatingOnce")
    {
        IAM = "NILL"
    }
    else if IAmAt < 0
    {
        IAM = "NILL"
    }
        // For when the operator has not been set
    else if M1 == -1
    {
        // Less than the slider value
        if IAmAt < S
        {
            IAM = "BlueBall"
        }
            // Greater than slider value
        else if IAmAt > S
        {
            IAM = "NILL"
        }
            // Equal to the slider value
        else if IAmAt == S
        {
            IAM = "BlueBall"
        }
    }
        // For when the operator has only been set once
    else if M2 == -1
    {
        // For when subtracting
        if S < M1
        {
            // Beneath Slider
            if IAmAt < S
            {
                IAM = "BlueBall"
            }
                // Above Slider and Under Mark
            else if IAmAt > S && IAmAt < M1
            {
                IAM = "BlueRing"
            }
                // Past Mark
            else if IAmAt > M1
            {
                IAM = "NILL"
            }
                // At Slider
            else if IAmAt == S
            {
                IAM = "BlueBall"
            }
                // At Mark
            else if IAmAt == M1
            {
                IAM = "BlueRing"
            }
        }
            // For when adding
        else if M1 < S
        {
            // Beneath Mark
            if IAmAt < M1
            {
                IAM = "BlueBall"
            }
                // Above Mark and under slider
            else if IAmAt > M1 && IAmAt < S
            {
                IAM = "OrangeBall"
            }
                // Past the slider
            else if IAmAt > S
            {
                IAM = "NILL"
            }
                // At Slider
            else if IAmAt == S
            {
                IAM = "OrangeBall"
            }
                // At Mark
            else if IAmAt == M1
            {
                IAM = "BlueBall"
            }
        }
        else if M1 == S
        {
            // Beneath Mark
            if IAmAt < M1
            {
                IAM = "BlueBall"
            }
                // Above Mark
            else if  IAmAt > M1
            {
                IAM = "NILL"
            }
            else if IAmAt == M1
            {
                IAM = "BlueBall"
            }
        }
        
    }
        // Second mark has been set
    else if M2 != -1
    {
        // Adding twice
        if M1 < M2 && M2 <= S
        {
            if IAmAt <= M1
            {
                IAM = "BlueBall"
            }
            else if IAmAt >= M1 && IAmAt <= M2
            {
                IAM = "OrangeBall"
            }
            else if IAmAt > M2 && IAmAt <= S
            {
                IAM = "PinkBall"
            }
        }
            // Subtracting twice
        else if S < M2 && M2 < M1
        {
            if IAmAt <= S
            {
                IAM = "BlueBall"
            }
            else if IAmAt > S && IAmAt <= M2
            {
                IAM = "PinkRing"
            }
            else if IAmAt > M2 && IAmAt <= M1
            {
                IAM = "BlueRing"
            }
            
        }
            // Adding and then subtracting without passing the first mark
        else if M1 <= S && S < M2
        {
            if IAmAt <= M1
            {
                IAM = "BlueBall"
            }
            else if IAmAt > M1 && IAmAt <= S
            {
                IAM = "OrangeBall"
            }
            else if IAmAt > S && IAmAt <= M2
            {
                IAM = "OrangeRing"
            }
        }
            // Adding and the subtracting passed the first mark
        else if S < M1 && M1 < M2
        {
            if IAmAt <= S
            {
                IAM = "BlueBall"
            }
            else if IAmAt > S && IAmAt <= M1
            {
                IAM = "BlueRing"
            }
            else if IAmAt > S && IAmAt <= M2
            {
                IAM = "OrangeRing"
            }
            
        }
            // Subtracting and then adding without passing the first mark
        else if M2 <= S && S < M1
        {
            if IAmAt <= M2
            {
                IAM = "BlueBall"
            }
            else if IAmAt > M2 && IAmAt <= S
            {
                IAM = "OrangeBall"
            }
            else if IAmAt > S && IAmAt <= M1
            {
                IAM = "BlueRing"
            }
            
        }
            // Subtracting and then adding passed first mark
        else if M2 < M1 && M1 <= S
        {
            
            if IAmAt <= M2
            {
                IAM = "BlueBall"
            }
            else if IAmAt > M2 && IAmAt <= S
            {
                IAM = "OrangeBall"
            }
            
        }
        
        
    }
    
    return IAM
    
}
