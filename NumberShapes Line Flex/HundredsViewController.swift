//  This is the Update File for the NumberShapes Whiteboard 1.2.  Located in the Swift 2 folder. (surname NumberShapes Line Flex)
// Things to update:
// 1) Logic that sets label markers as a function of line width and the number of marks
// 2) Making the tick marks more noticable
// 3) Creating a number line class that manages itself.
// 4) fixing the "already an element added" array issue
// 5) not storing game states as strings
// 6) find a performance workaround for doing larger numbers



import UIKit


var n = 10
var operating = false
var Length = 1000
var Slider: Int = 0
var Mark = -1
var blocking = false
var oldslider = 0
var nlw: CGFloat!
var HundredsDescriptor = hundredsdescriptor()
var CountingView = countingview()
var HundredsNumberLine = horizontalnumberline()
var HundredsKey = swipekey()


class HundredsViewController: UIViewController
{
    
    @IBOutlet weak var operatorbutton: UIButton!
    
    @IBOutlet weak var approximatorbutton: UIButton!

    @IBAction func approximater(_ sender: UIButton)
    {
        
        if HundredsDescriptor.isHidden == true && HundredsNumberLine.isHidden == true
        {
            HundredsDescriptor.isHidden = false
            HundredsNumberLine.isHidden = false
            
        }
        else if HundredsDescriptor.isHidden == false && HundredsNumberLine.isHidden == false
        {
           
            HundredsDescriptor.isHidden = true
            HundredsNumberLine.isHidden = true
            
        }
        
    }
    
    
    @IBAction func helpme(_ sender: UIButton)
    {
        var i = 0
        
        let vc = UIAlertController(title: "\n\n\n", message: helpmodel.hundredsHelp[i].0, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Done", style: .default , handler: nil)
        
        let instImgView = UIImageView()
        instImgView.image = helpmodel.hundredsHelp[i].1
        
        let nextAction = UIAlertAction(title: "Next", style: .default , handler: {(alertaction) -> Void in
            
                i = i+1
                
                let j = i%(helpmodel.hundredsHelp.count)
                
            vc.message = helpmodel.hundredsHelp[j].0
            instImgView.image = helpmodel.hundredsHelp[j].1
            
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
        
        operating = !operating
        
        if operating
        {
            sender.setImage(UIImage(named: "="), for: UIControlState())
            Mark = Slider
        }
        else if !operating
        {
            sender.setImage(UIImage(named: "Plus_Minus"), for: UIControlState())
            
            let top = max(Slider,Mark,n*100)
            let bot = min(Slider,Mark,oldslider)
            
            Mark = -1
            
            CountingView.drawcountersfrom(n, start: bot, mark: Mark, blocking: blocking, end: top, slider: Slider)
            
            UpdateDescriptor()
            
        }
        
    }
    

    
    func pinched(_ sender: pinchit)
    {
  
        if sender.state == .ended
        {
            if sender.scale > 1
            {
                n = n-1
                if n < 5
                {
                    n = 5
                }
                else if 100*n < max(Slider,Mark)
                {
                    n = n + 1
                }
            }
            else if sender.scale < 1
            {
                n = n+1
                if n > 10
                {
                    n = 10
                }
            }


            
            var newCviewframe: CGRect
            {
                let w = CountingView.frame.width
                let h = w/CGFloat(n)
                let x = HundredsNumberLine.frame.origin.x
                let y = HundredsNumberLine.frame.origin.y - h
                
                return CGRect(x: x, y: y, width: w, height: h)
            }
            
            CountingView.frame = newCviewframe
            
            CountingView.presets(n, slider: Slider, mark: Mark, blocking: blocking)
            
            CountingView.drawcountersfrom(n, start: 0, mark: Mark, blocking: blocking, end: n*100, slider: Slider)
            
            HundredsNumberLine.drawme(100*n)
            
            
            CountingView.setNeedsDisplay()
            
        }
 
        
    }
    
    func HandleSwipes(_ sender: UISwipeGestureRecognizer)
    {
        
        
        var x = Int(Slider)
        
        // IncrementSlider
        if sender.direction == .left && x >= 10
        {
            x = x - 10
        }
        else if sender.direction == .right && x <= 100*n - 10
        {
            x = x + 10
        }
        else if sender.direction == .up && x <= 100*n - 1
        {
            x = x + 1
        }
        else if sender.direction == .down && x >= 1
        {
            x = x - 1
        }
        
        oldslider = Slider
        Slider = x
        UpdateDescriptor()
        
        let top = max(Slider,oldslider)
        let bot = min(Slider,oldslider)
        
        CountingView.drawcountersfrom(n, start: bot, mark: Mark, blocking: blocking, end: top, slider: Slider)
        
    }

    
    
    override func viewDidAppear(_ animated: Bool)
    {
     
        
        var numberlineframe: CGRect
        {
            let vw = view.frame.width
            nlw = 7/8*vw
            let h = nlw/30
            let x = vw/2 - nlw/2
            let y = view.frame.height - 100
            
            return CGRect(x: x, y: y, width: nlw, height: h)

        }
  
        var countingviewframe: CGRect
        {
            
            let w = numberlineframe.width
            let h = numberlineframe.width/CGFloat(n)
            let x = numberlineframe.origin.x
            let y = numberlineframe.origin.y - h
            
            return CGRect(x: x, y: y, width: w, height: h)
            
        }
        
        var descriptorframe: CGRect
        {
            
            let w = view.frame.width*4/5
            let h = 1/7*w
            
            let x = view.frame.width/2 - w/2
            
            let y = 1/5*view.frame.height
            
            return CGRect(x: x, y: y, width: w, height: h)
        }
        
        
        HundredsDescriptor = hundredsdescriptor(frame: descriptorframe)
        view.addSubview(HundredsDescriptor)
        
        CountingView = countingview(frame: countingviewframe)
        
        view.addSubview(CountingView)
        
        CountingView.presets(n, slider: Slider, mark: Mark, blocking: blocking)
        
        CountingView.drawcountersfrom(n, start: 0, mark: Mark, blocking: blocking, end: 100*n, slider: Slider)
        
        HundredsNumberLine = horizontalnumberline(frame: numberlineframe)
        view.addSubview(HundredsNumberLine)
        HundredsNumberLine.drawme(100*n)
        
      CountingView.isUserInteractionEnabled = true
    
      CountingView.setNeedsDisplay()
      
    }
    
    override func viewDidLoad()
    {
        
        let backGround = UIImageView()
        backGround.image = UIImage(named: "CloudsBackground")
        backGround.frame.styleFillContainer(container: self.view.frame)
        view.addSubview(backGround)
        view.sendSubview(toBack: backGround)
        
        // Gotta realign the states when reentering.  This is hakckey, sorry.
        if operating
        {
            operatorbutton.setImage(EqualsButton, for: UIControlState())
        }
        else if !operating
        {
            operatorbutton.setImage(AddAndSub, for: UIControlState())
        }
        
        // Setting up swipe gestures
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(HundredsViewController.HandleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(HundredsViewController.HandleSwipes(_:)))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(HundredsViewController.HandleSwipes(_:)))
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(HundredsViewController.HandleSwipes(_:)))
        
        let pinch = pinchit()
        
        pinch.addTarget(self, action: #selector(HundredsViewController.pinched(_:)))
        
        view.addGestureRecognizer(pinch)
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(downSwipe)
        view.addGestureRecognizer(upSwipe)
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        downSwipe.direction = .down
        upSwipe.direction = .up
        
        pinch.cancelsTouchesInView = false
        
        self.view.isUserInteractionEnabled = true
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }
    
    
    override func didReceiveMemoryWarning()
    {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

