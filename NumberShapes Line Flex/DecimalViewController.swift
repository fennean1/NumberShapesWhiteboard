//  This is the Update File for the NumberShapes Whiteboard 1.2.  Located in the Swift 2 folder. (surname NumberShapes Line Flex)
// Things to update:
// 1) Logic that sets label markers as a function of line width and the number of marks
// 2) Making the tick marks more noticable
// 3) Creating a number line class that manages itself.
// 4) fixing the "already an element added" array issue
// 5) not storing game states as strings
// 6) find a performance workaround for doing larger numbers






import UIKit


class DecimalViewController: UIViewController {
    
    @IBOutlet weak var NumberLineView: UIView!
    
    @IBOutlet weak var operatorbutton: UIButton!
    
    // Game state variables
    var operating = false
    var Mark = Float(-1)
    var Slider = 0
    
    // Starting length at bootup
    var Length = 7
    var OldLength = 7
    
    // These are vague
    var MarksAreAtIndex = 0
    var TickMinYSpace = CGFloat(0)
    var TickEveryOther = 1
    var BallDimension = CGFloat(0)
    
    let linemax = 100
    
    // Testing the blockline
    var BlockLine = blockline()
  
    var Clear = false
    
    // Variables that stores the state at all times so things don't have to recalculate if nothing has changed (ie. uislider)
    var GlobalState = "Integers"

    
    @IBOutlet weak var Descriptor: descriptor!
    
    // Reference to slider on Storyboard
    @IBOutlet weak var SliderButton: UISlider!
    
    
    // Declare an image view to display horizontal line through tick marks
    var NumberLine = UIImageView()
    
    
    // The variable to be used to determine how often labels get placed on the numberline not sure why i made this CGFloat but i htink it has something to do with  math i have to do later.
    var MarksEvery = CGFloat(1)
    
    // A booleand variable used to check if pinch has occured
    var Pinched = false
    
    // Array to store the ball views
    var BallArray = [UIImageView()]
    
    // Array to store the images.
    var TickArray = [UIImageView()]
    
    // Array to store labels
    var LabelArray = [UILabel()]
    
    @IBAction func hide(_ sender: UIButton)
    {
       
        for index in LabelArray
        {
            index.isHidden = !index.isHidden
        }
       
    }
    
    

    @IBAction func help(_ sender: UIButton)
    {
        let help = helpmodel.decimalsHelp
        
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
    
 
    
    @IBAction func operatorclicked(_ sender: UIButton)
    {
        
        BlockLine.Mark = precision(SliderButton.value, n: 2)
        Mark = BlockLine.Mark
        
        operating = !operating
        
        if operating
        {
            sender.setImage(UIImage(named: "="), for: UIControlState())
        }
        else if !operating
        {
             sender.setImage(UIImage(named: "Plus_Minus"), for: UIControlState())
            Mark = -1
            BlockLine.Mark = Mark
        }
        
        UpdateDescriptor()
        DrawBlocksandView()
        
        
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
    
    
    
    // Currently have two different descriptors one as UILabel and other as UIView class.
    func UpdateDescriptor()
    {
        let s = precision(SliderButton.value, n: 2)
        
        var TextToDisplay = NSString(format: "%.2f",s) as String
        
        if !operating
        {
            
            TextToDisplay = NSString(format: "%.2f", s) as String
            
        }
        else if operating
        {
            TextToDisplay = NSString(format: "%.2f", Mark) as String

            
            if s > Mark
            {
                TextToDisplay += NSString(format: " + %.2f", (s-Mark)) as String
            }
            else if s < Mark
            {
                
                 TextToDisplay += NSString(format: " - %.2f", (Mark-s)) as String
            }
            
        }
        
        
        Descriptor.text = TextToDisplay
    }
    
    
    
    @IBAction func SliderValueChanged(_ sender: UISlider!)
    {
        
        // Update slider position
        Slider = Int(sender.value)
        
        DrawBlocksandView()
    
        UpdateDescriptor()
        
        
    }

    func DrawBlocksandView()
    {
        // BEGIN FRAME
        // Block size is frame width divided by length
        let blocksize = NumberLineView.frame.width/CGFloat(Length)
        
        // Width is number of blocks times slider value
        let w = blocksize*CGFloat(SliderButton.value)
        
        // Height is size of block
        let h = blocksize
        
        // Set frame
        BlockLine.frame = CGRect(x: 0, y: 0, width: w, height: h)
        // END FRAME
        
        
        BlockLine.length = Length
        
        // Slider is sent to blocks with precision
        BlockLine.slider = precision(SliderButton.value, n: 2)
        
        if Int(BlockLine.frame.width) == 0
        {
            BlockLine.layer.sublayers?.removeAll()
            BlockLine.refreshtheblocks()
           
        }
        else
        {
            BlockLine.setNeedsDisplay()
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
        
        var x = precision(SliderButton.value,n: 2)
        
        BlockLine.setNeedsDisplay()
        
        // IncrementSlider
        if sender.direction == .left && x >= 0.1
        {
            x = x - 0.1
        }
        else if sender.direction == .right && x <= (Float(Length) - 0.1)
        {
            x = x + 0.1
        }
        else if sender.direction == .up && x <= (Float(Length) - 0.01)
        {
            x = x + 0.01
        }
        else if sender.direction == .down && x >= 0.01
        {
            x = x - 0.01
        }
        
        SliderButton.value = x
        Slider = Int(SliderButton.value)
        
        UpdateDescriptor()
        DrawBlocksandView()
        
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
        for view in NumberLineView.subviews {
            view.removeFromSuperview()
        }
        
        
        
        // Blockline needs to be added here so pinch can work when it redraws numberline view after removing all subviews
        NumberLineView.addSubview(BlockLine)
        
        DrawBlocksandView()
        
        
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

    }
    
    // This has an old name used for testing
    @IBAction func PinchToZoom(_ sender: pincher)
    {
        
        // Set Cap on how much it can move in a single pinch
        if abs(OldLength-Length) < Int(0.2*CGFloat(OldLength))
        {
            // Get new parameters
            let top = Int(max(SliderButton.value,Mark))+1
            
            let paramarray = sender.handlePinch(Length, balls: top ,scalefactor: sender.scale, max: linemax)
            
            
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
        // This was added for extra pinch control (no overflow)
        OldLength = Length
    }
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        
        DrawNumberLine(Length, MarksEvery: MarksEvery)
        HideYoLine()
        
        let blocksize = NumberLineView.frame.width/CGFloat(Length)
        
        BlockLine.frame = CGRect(x: 0, y: 0, width: NumberLineView.frame.width, height: blocksize)
        
        BlockLine.length = Length

        
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
        
        self.title = "DecimalViewController"
        
        // Setting up swipe gestures
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(DecimalViewController.HandleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(DecimalViewController.HandleSwipes(_:)))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(DecimalViewController.HandleSwipes(_:)))
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(DecimalViewController.HandleSwipes(_:)))
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(downSwipe)
        view.addGestureRecognizer(upSwipe)
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        downSwipe.direction = .down
        upSwipe.direction = .up
        
        
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

