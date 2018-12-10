//  This is the Update File for the NumberShapes Whiteboard 1.2.  Located in the Swift 2 folder. (surname NumberShapes Line Flex)
// Things to update:
// 1) Logic that sets label markers as a function of line width and the number of marks
// 2) Making the tick marks more noticable
// 3) Creating a number line class that manages itself. 
// 4) fixing the "already an element added" array issue
// 5) not storing game states as strings
// 6) find a performance workaround for doing larger numbers






import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var NumberLineView: UIView!
    
    
    // Game state variables
    var Mark1 = -1
    var Mark2 = -1
    var Slider = 0
    var OldSlider = 0
    
    // Starting length at bootup
    var Length = 20
    var OldLength = 20
    
    var MarksAreAtIndex = 0
    var TickMinYSpace = CGFloat(0)
    var TickEveryOther = 1
    var BallDimension = CGFloat(0)
    
    var linemax = 150
    
    var UpnDownInc = 10

    var WithShapes = false
    var Clear = false
    
    @IBOutlet var Pincher: pincher!
    
    // Variables that stores the state at all times so things don't have to recalculate if nothing has changed (ie. uislider)
    var GlobalState = "WithNumbersNotOperating"
    
    @IBOutlet weak var HideButton: UIButton!

    @IBOutlet weak var ShapeButton: shapebutton!
    
    @IBOutlet weak var SecondOperator: operateTwiceButton!
    
    @IBOutlet weak var FirstOperator: operateOnceButton!
    
    @IBOutlet weak var Descriptor: descriptor!
    
    // Reference to slider on Storyboard
    @IBOutlet weak var SliderButton: UISlider!
    
    @IBOutlet weak var ShapeDescriptor: shapeDescriptor!
    
    // Declare an image view to display horizontal line through tick marks
    var NumberLine = UIImageView()
    
    
    // The variable to be used to determine how often labels get placed on the numberline not sure why i made this CGFloat but i htink it has something to do with  math i have to do later.
    var MarksEvery = CGFloat(1)
    
    // A booleand variable used to check if pinch has occured
    var Pinched = false
    
    
    // POOOOOP: I know now that this actually creates a one element array with an arbitrary image view. If i wan't to set it to empty and then populate later i need [UIImageView] = []
    
    // Array to store the ball views
    var BallArray = [UIImageView()]
    
    // Array to store the images.
    var TickArray = [UIImageView()]
    
    // Array to store labels
    var LabelArray = [UILabel()]
    
    // Need to know operating states
    var OperatingOnce = false
    var OperatingTwice = false
    
    
    // The new lines and markers class has to handle this
    @IBAction func HideButtonClicked(_ sender: UIButton)
    {
        Clear = !Clear
        HideYoLine()
    }
    
    
    // Hides the numbers on the number line
    func HideYoLine()
    {
        if Clear == true
        {
            for index in 0...LabelArray.count-1
            {
                LabelArray[index].isHidden = true
            }
        }
        else if Clear == false
        {
            for index in 0...LabelArray.count-1
            {
                LabelArray[index].isHidden = false
            }
        }
    }

    
    func CalculateGameState(_ M1: Int, M2: Int, WithShapes: Bool) -> String
    {
        var gamestate = ""
        
        if M1 == -1 && M2 == -1
        {
            if WithShapes == true
            {
                gamestate = "WithShapesNotOperating"
            }
            else if WithShapes == false
            {
                gamestate = "WithNumbersNotOperating"
            }
        }
        else if M1 != -1 && M2 == -1
        {
            if WithShapes == true
            {
                gamestate = "WithShapesOperatingOnce"
            }
            else if WithShapes == false
            {
                gamestate = "WithNumbersOperatingOnce"
            }
        }
        else if M1 != -1 && M1 != -1
        {
            gamestate = "OperatingTwice"
        }
        
        return gamestate
        
    }
    
    

    
    @IBAction func ShapeButtonClicked(_ sender: shapebutton)
    {
        
        WithShapes = !WithShapes

        GlobalState = CalculateGameState(Mark1, M2: Mark2, WithShapes: WithShapes)
        
        sender.alignToState(GlobalState)
        
        UpdateStoryBoard(GlobalState)
        UpdateTheWholeLine()
        
    }
    

    
    // Handles clicks by the second operator button
    @IBAction func SecondOperator(_ sender: operateTwiceButton)
    {
            // Set second mark to current slider value but only if it's not the same as the other mark.
            if Slider != Mark1
            {
                Mark2 = Slider
                
                GlobalState = CalculateGameState(Mark1, M2: Mark2, WithShapes: WithShapes)
                
                UpdateStoryBoard(GlobalState)
            }
        
    }
    
    
    func UpdateStoryBoard(_ state: String)
    {
        UpdateDescriptor()
        Descriptor.alignToState(state)
        ShapeButton.alignToState(state)
        SecondOperator.alignToState(state)
        FirstOperator.alignToState(state)
        ShapeDescriptor.alignToState(state)
        
    }
    
    @IBAction func FirstOperator(_ sender: operateOnceButton)
    {
        GlobalState = CalculateGameState(Mark1, M2: Mark2, WithShapes: WithShapes)
        
        if GlobalState == "WithShapesNotOperating" || GlobalState == "WithNumbersNotOperating"
        {
            
            Mark1 = Slider
            
        }
        else
        {
            Mark1 = -1
            Mark2 = -1
        }
        
        // Updates the whole line
        UpdateTheWholeLine()
        
        GlobalState = CalculateGameState(Mark1, M2: Mark2, WithShapes: WithShapes)
        
        
        // Alligns to all the states
        UpdateStoryBoard(GlobalState)
    
    }
    
    // Draws a ball at a given point
    func DrawABall(_ DrawHere: Int)
    {
        
        // Get the name of the image to draw based on where it is
        let ImgName = WhatAmI(Mark1, M2: Mark2, S: Slider, IAmAt: DrawHere, State: GlobalState)
        
        // Draw the image (check for nil)
        if ImgName == "NILL"
        {
            BallArray[DrawHere].image = nil
        }
        else
        {
            BallArray[DrawHere].image = UIImage(named: ImgName)
        }
    }
    
    
    // Currently have two different descriptors one as UILabel and other as UIView class.
    func UpdateDescriptor()
    {
        // Need to know which descriptor to update
        if WithShapes != true
        {
            Descriptor.text = Descriptor.DescriptorText(Mark1, Mark2: Mark2, Slider: Slider)
        }
        // If using shapes, call the shape class's DrawMyViews which updates descriptor and resets the view.
        else if WithShapes == true
        {
            ShapeDescriptor.DrawMyViews(Mark1, S: Slider, State: GlobalState)
        }
    }
    
    
    
    @IBAction func SliderValueChanged(_ sender: UISlider!)
    {

        // Update slider position
        Slider = Int(sender.value)
        
        UpdateTheWholeLine()

        
        // Only update descriptor and not storyboard.  We need this because the descriptor is updated only when slider is moved so we need to remove computationally expensive things from this function
        UpdateDescriptor()
        
    }
    
    // Goes through the entire line and restores all proper states and positions
    func UpdateTheWholeLine()
    {
        for index in 0...Length
        {
            // Finds out what the "ball" should be and then draws it
            DrawABall(index)
        }
        
    }
    
    
    
    func Create1DImageArray(_ m: Int) -> [UIImageView]
    {
        // Doing this apparently creates the first element of the array so I have to add few elements when appending
        var Array1D = [UIImageView()]
        let n = m - 2
   
        for _ in 0...n
        {
            
            // Append 
            Array1D.append(UIImageView())
            
        }
        
        return Array1D
        
    }
    
    func Create1DLabelArray(_ m: Int) -> [UILabel]
    {
        // Doing this apparently creates the first element of the array so I have to add few elements when appending
        var Array1D = [UILabel()]
        let n = m - 2
        
        for _ in 0...n
        {
            
            // Append
            Array1D.append(UILabel())
            
            
        }
        
        return Array1D
        
    }
    
    func HandleSwipes(_ sender: UISwipeGestureRecognizer)
    {

        
        
        // IncrementSlider
        if sender.direction == .left && Slider > 0
        {
            Slider -= 1
        }
        else if sender.direction == .right && Slider < Length
        {
            Slider += 1
        }
        else if sender.direction == .up && Slider <= Length-10
        {
            Slider = Slider + 10
        }
        else if sender.direction == .down && Slider >= 10
        {
            Slider = Slider - 10
        }
  
        
        // Update SliderButton so it reflects the global slider value
        SliderButton.value = Float(Slider)
        
        UpdateTheWholeLine()
        
        // Slider changed so update global state (might not be necessary?)
        GlobalState = CalculateGameState(Mark1, M2: Mark2, WithShapes: WithShapes)

        UpdateStoryBoard(GlobalState)

        
    }
    
    
    // Draws the ball views on the view when resizing or adjusting range
    func DrawBallsViewOnView(_ ObjDimX: CGFloat, ObjDimY: CGFloat, Space: CGFloat, ObjCordY: CGFloat, ObjectArray: [UIImageView?])
    {
        // Populate everything except the first (0th) element of the array (We use a zeroth element of this array to handle error checking issues when slider is at zero.
        for Xindex in 1...ObjectArray.count-1
        {
            
            // increment x coordinate by the spacing
            let x = CGFloat(Xindex-1)*Space
            
            // add the object at index to the view
            NumberLineView.addSubview(ObjectArray[Xindex]!)
            
            // set frame for objects at array index
            ObjectArray[Xindex]?.frame = CGRect(x: x, y: ObjCordY, width: ObjDimX, height: ObjDimY)
            
        }
        
    }
    
    // Draws the tick markers on the view when resizing or adjusting range
    func DrawTickMarkers(_ ObjDimX: CGFloat,ObjDimY: CGFloat, Space: CGFloat, ObjCordY: CGFloat, ObjectArray: [UIImageView?])
    {
        
        // CURRENT METHOD: set a tick mark height for the ticks that get labels. Then reduce the marks that don't wind up over labels to some fraction of those that do.
        
        
        // Min height is for every mark that's not on the marks every
        let MinObjDimY = ObjDimY/2
        let MinObjDimX = MinObjDimY/10
        
        // Medium Height is achieved on the 5's when the intervals are at 10
        let MedObjDimY = 3/4*ObjDimY
        let MedObjDimX = MedObjDimY/10
        
        for Xindex in 0...ObjectArray.count-1
        {
            
            // increment x coordinate by the spacing
            let x = CGFloat(Xindex)*Space - ObjDimX/2
            
            // add the object at index to the view
            NumberLineView.addSubview(ObjectArray[Xindex]!)
            
            
            // Expand Tick Mark if hits and exmphasize mark
            if (Xindex*TickEveryOther)%Int(MarksEvery) == 0
            {
                ObjectArray[Xindex]?.frame = CGRect(x: x, y: ObjCordY, width: ObjDimX, height: ObjDimY)
            }
            // Truncate ticks if they're at 5 and MarksEveryTen
            else if MarksEvery == 10 && Xindex%5 == 0
            {
                
               ObjectArray[Xindex]?.frame = CGRect(x: x, y: ObjCordY+ObjDimY/8, width: MedObjDimX, height: MedObjDimY)
            }
            // else give bare minimum which is half the maximum tick mark
            else if Xindex%Int(MarksEvery) != 0
            {
                ObjectArray[Xindex]?.frame = CGRect(x: x, y: ObjCordY+MinObjDimY/2, width: MinObjDimX, height: MinObjDimY)
                
            }
    
            // Give it the tick
            ObjectArray[Xindex]?.image = UIImage(named: "Tick")
            
        }
        
    }
    
    
    // Draws the labels on the view
    func DrawLabelMarkers(_ ObjDimX: CGFloat, ObjDimY: CGFloat, Space: CGFloat, ObjCordY: CGFloat, ObjectArray: [UILabel?])
    {
        
        
        for Xindex in 0...ObjectArray.count-1
        {
           
            // increment x coordinate by the spacing
            let x = CGFloat(Xindex)*Space - ObjDimX/2
           
            // add the object at index to the view
            NumberLineView.addSubview(ObjectArray[Xindex]!)
            
            // set frame for objects at array index
            ObjectArray[Xindex]?.frame = CGRect(x: x, y: ObjCordY, width: ObjDimX, height: ObjDimY)
            
            // Set Label text
            let CGXIndex = CGFloat(Xindex)
            
            // If we let the font size equal the height and always keep the same height for our labels then this seems to work. More consistent and easier to picture.
            let FontSize = ObjDimY
            
            ObjectArray[Xindex]?.textAlignment = NSTextAlignment.center
            ObjectArray[Xindex]?.adjustsFontSizeToFitWidth = true
            ObjectArray[Xindex]?.font = UIFont(name: "ChalkBoard SE", size: FontSize)
            
            
            ObjectArray[Xindex]?.text = "\(Int(CGXIndex*MarksEvery))"
            
        }
        
    }
    
    // Draws a line through the center of the tick marks
    func DrawTheActualLine(_ BallsHeight: CGFloat, TickY: CGFloat)
    {
        // Remove and reset each time line is drawn (same prodedure for all numberline views)
        NumberLine.removeFromSuperview()
        
        // Add the view back to the numberline
        NumberLineView.addSubview(NumberLine)
        
        // Numberline is as wide as the view
        let ObjDimX = NumberLineView.frame.width
        
        // Thickness is a tenth of the Tick height
        let ObjDimY = TickY/10
        
        // Y coordinate is midway through each tick.
        let ObjCordY = BallsHeight + TickY/2 - ObjDimY/2
        
        // Set frame for objects at array index
        NumberLine.frame = CGRect(x: 0, y: ObjCordY, width: ObjDimX, height: ObjDimY)
        
        NumberLine.image = UIImage(named: "Line")
        
    }
    
    // This creates the Tick/Ball/Label and Line markers.  MOOOOOO All of this needs to be in it's own NumberLine class that manages it'self.
    // This should really only take marks every if i'm going to keep it in main (maign)
    func DrawNumberLine(_ length: Int, MarksEvery: CGFloat)
    {
        
        // Remove current views
        for view in NumberLineView.subviews
        {
            view.removeFromSuperview()
        }
        
        
        
        // Find out how long the label array has to be.
        let CGLength = CGFloat(length)
        
        

        
        // Calculate the number of intervals in the range
        let LabelArrayLength = Int((CGLength - CGLength.truncatingRemainder(dividingBy: MarksEvery))/MarksEvery)
        
        
        // Ball array lentgh is number of balls
        BallArray = Create1DImageArray(length+1)
        
        // Label array needs one extra for endcaps
        LabelArray = Create1DLabelArray(LabelArrayLength+1)
  
        
        // The slider maximum should always be the length
        SliderButton.maximumValue = Float(length)
        
        let FrameW = NumberLineView.frame.width
        BallDimension = FrameW/CGFloat(length)
        
        
        // Default dimensions for shit
        let TickY = FrameW/50
        let TickX = TickY/10
        // let LblX = FrameW/(CGFloat(Length)/CGFloat(MarksEvery))
        
        // Having all of the fonts be the same size is actually really appealing visually.
        let LblX = FrameW/25

        let LblY = 4/9*LblX
        let LblYCordinate = BallDimension+TickY

        TickMinYSpace = BallDimension*CGFloat(TickEveryOther)
        
        
        // Tick array lengths is the number of balls divided by how many balls make a tick
        let TickArrayL = Length/TickEveryOther

        //Tick Array needs one extra for endcaps
        TickArray = Create1DImageArray(TickArrayL+1)
    
        // Drawing all the tick markers
        DrawTickMarkers(TickX, ObjDimY: TickY, Space: TickMinYSpace, ObjCordY: BallDimension, ObjectArray: TickArray)
        
        // Drawing all the labels
        DrawLabelMarkers(LblX, ObjDimY: LblY , Space: BallDimension*MarksEvery, ObjCordY: LblYCordinate, ObjectArray: LabelArray)
        
        //Drawing the actual line
        DrawTheActualLine(BallDimension,TickY: TickY)
        
        // Drawing all the image views for the balls
        DrawBallsViewOnView(BallDimension, ObjDimY: BallDimension, Space: BallDimension, ObjCordY: 0,ObjectArray: BallArray)
        
        UpdateTheWholeLine()
        
        
    }

    // This has an old name used for testing
    @IBAction func adjustProgress(_ sender: pincher)
    {
        
        // Place where balls are
        let ballSpot = max(Slider, Mark1, Mark2)
        
        // Set Cap on how much it can move in a single pinch
        if abs(OldLength-Length) < Int(0.2*CGFloat(OldLength))
        {
            // Get new parameters
            let paramarray = sender.handlePinch(Length, balls: ballSpot,scalefactor: sender.scale, max: linemax)

        
            MarksEvery = CGFloat(paramarray[0])
            TickEveryOther  = paramarray[1]
            Length = paramarray[2]

            // Redraw the line based on new parameters
            DrawNumberLine(Length, MarksEvery: MarksEvery)
        
            // Keep Line hidden (or not)
            HideYoLine()
        }
        
    }
    
    
    // This resets the "pinched" boolean so that the logic knows that a new pinch has begun.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        OldLength = Length
    }
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        
        DrawNumberLine(Length, MarksEvery: MarksEvery)
        HideYoLine()
 
    
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation)
    {
        DrawNumberLine(Length, MarksEvery: MarksEvery)
        HideYoLine()
    }
    
    
    override func viewDidLoad()
    {
        let backGround = UIImageView()
        backGround.image = UIImage(named: "CloudsBackground")
        backGround.frame.styleFillContainer(container: self.view.frame)
        view.addSubview(backGround)
        view.sendSubview(toBack: backGround)
        
        self.title = "IntegerViewController"
        
        // Setting up swipe gestures
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.HandleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.HandleSwipes(_:)))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.HandleSwipes(_:)))
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.HandleSwipes(_:)))
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(downSwipe)
        view.addGestureRecognizer(upSwipe)
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        downSwipe.direction = .down
        upSwipe.direction = .up
        
       // Operator buttons not active upon startup
       SecondOperator.isHidden = true
       SecondOperator.isEnabled = false
        
       SliderButton.setThumbImage(UIImage(named: "SeriousGlassThumb"), for: UIControlState())
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

