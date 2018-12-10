//
//  HelpFiles.swift
//  NumberShapes Whiteboard
//
//  Created by Andrew Fenner on 6/21/16.
//  Copyright © 2016 NumberShapes. All rights reserved.
//

import Foundation
import UIKit


struct helpmodel
{
    
    static var hundredsHelp: [(String,UIImage?)] = [("Touch above the number line to create numbers.",PointerHand),("Swipe up and down adjust the number by 1.",SwipeUp),("Swipe left right to adjust the number by 10.",SwipeRight),(
        "Use the +/- button to set a point to add or subtract from.",AddAndSub),("Use the marker button to remove all labels.",HideMarkers),("Pinch inward to zoom out.",PinchIn),("Pinch outward to zoom in",PinchOut),("Still need help? Visit www.number-shapes.com or check us out on Twitter & YouTube",QuestionMark)]
    
    
    static var percentsHelp: [(String,UIImage?)] = [("Drag the markers to adjust their values.",SharpMarker),("When a marker is selected, you can use swipe gestures to adjust its value.",SharpMarkerSelected),("Swiping left and right will adjust the Percentage by 1.",SwipeRight),("Swiping up and down will adjust the Percentage by 10",SwipeUp),("Swiping left and right will adjust the 100% mark by 0.01.",SwipeRight),("Swiping up and down will adjust the 100% Mark by 0.10.",SwipeUp),("Pinch inward to zoom out.",PinchIn),("Pinch outward to zoom in.",PinchOut),("Still need help? Visit www.number-shapes.com or check us out on Twitter & YouTube.",QuestionMark)]

    
    static var decimalsHelp: [(String,UIImage?)] = [("Drag the slider to adjust the values.",SliderThumb),("Use the +/- button to set the number you want to add or subtract from.",AddAndSub),("Swiping up and down will add and subtract hundredths.",SwipeUp),("Swiping left and right will add and subtract tenths.",SwipeRight),("Pinch inward to zoom out.",PinchIn),("Pinch outward to zoom in.",PinchOut),("Still need help? Visit www.number-shapes.com or check us out on Twitter & YouTube.",QuestionMark)]
    
    
    static var gridHelp: [(String,UIImage?)] = [("Swipe up and down to create rows.",SwipeUp),("Swipe left and right to create columns.",SwipeRight),("Use the X button for multiplication",MultiplicationButton),("Use the +/- button to set the number you want to add or subtract from.",AddAndSub),("Use the = button to see the total value.",EqualsButton),("Pinch inward to zoom out.",PinchIn),("Pinch outward to zoom in",PinchOut),("Use the : button to create proportions.",PropButton),("Still need help? Visit www.number-shapes.com or check us out on Twitter & YouTube",QuestionMark)]
    
    static var fractionsHelp: [(String,UIImage?)] = [("Swipe up and down adjust the denominator.",SwipeUp),("Swipe left and right to adjust the numerator.",SwipeRight),("Pinch inward to reduce the fraction (if possible).",PinchIn),("Pinch outward to expand the fraction",PinchOut),("Choose your own image.",Record),("Still need help? Visit www.number-shapes.com or check us out on Twitter & YouTube",QuestionMark)]
    
    
    
}