//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  An auxiliary source file which is part of the book-level auxiliary sources.
//  Provides the implementation of the "always-on" live view.
//

import UIKit
import PlaygroundSupport

@objc(Book_Sources_LiveViewController)
public class LiveViewController: UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
    /*
    public func liveViewMessageConnectionOpened() {
        // Implement this method to be notified when the live view message connection is opened.
        // The connection will be opened when the process running Contents.swift starts running and listening for messages.
    }
    */

    /*
    public func liveViewMessageConnectionClosed() {
        // Implement this method to be notified when the live view message connection is closed.
        // The connection will be closed when the process running Contents.swift exits and is no longer listening for messages.
        // This happens when the user's code naturally finishes running, if the user presses Stop, or if there is a crash.
    }
    */

    public func receive(_ message: PlaygroundValue) {
        // Implement this method to receive messages sent from the process running Contents.swift.
        // This method is *required* by the PlaygroundLiveViewMessageHandler protocol.
        // Use this method to decode any messages sent as PlaygroundValue values and respond accordingly.
    }
    
    let baseLineImageView = UIImageView()
    let descriptionTextLabel: UILabel = UILabel()
    let moveView:UIView = UIView()
    
    let fireButton: UIButton = UIButton()
    let resetButton:UIButton = UIButton()
    
    let speedStepper = UIStepper()
    let speedLabel = UILabel()
    var buttonStatus:Bool = false
    var moveSpeed:Double = 1
    
    let customRed = UIColor(red:0.91, green:0.56, blue:0.56, alpha:1.00)
    let customBlue = UIColor(red:0.58, green:0.74, blue:0.89, alpha:1.00)
    let customGreen = UIColor(red:0.53, green:0.74, blue:0.45, alpha:1.00)
    
    var animator:UIViewPropertyAnimator?
    
    var startX:CGFloat = 0
    var endX:CGFloat = 0
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        
        // let image: UIImage = UIImage(named: "baseLine.png")!
        baseLineImageView.frame = CGRect(x: 0, y: 0, width: 300, height: 18)
        // baseLineImageView.image = image
        
        baseLineImageView.frame.size.height = 1
        baseLineImageView.backgroundColor = UIColor.black
        
        view.addSubview(baseLineImageView)
    
        
        // UILabel
        descriptionTextLabel.text = "線のちょうど真ん中に印が来たら\nボタンを押してください"
        descriptionTextLabel.textAlignment = .center
        descriptionTextLabel.numberOfLines = 2
        
        view.addSubview(descriptionTextLabel)
        
        //button
        fireButton.frame = CGRect(x: 0, y: 0, width: 200, height: 70)
        fireButton.layer.cornerRadius = 25
        fireButton.backgroundColor = customBlue
        fireButton.titleLabel?.textColor = UIColor.white
        fireButton.titleLabel?.textAlignment = .center
        fireButton.setTitle("スタート", for: .normal)
        // fireButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
        view.addSubview(fireButton)
        
        //moveView
        moveView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        moveView.layer.cornerRadius = 15
        moveView.backgroundColor = UIColor.green
        view.addSubview(moveView)
        
        //speedStpper
        speedStepper.maximumValue = 10
        speedStepper.minimumValue = 1
        speedStepper.value = moveSpeed
        speedStepper.stepValue = 1
        // speedStepper.addTarget(self, action: #selector(stepperCahnged(sender:)), for: .valueChanged)
        view.addSubview(speedStepper)
        
        //resetButton
        resetButton.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        resetButton.backgroundColor = customGreen
        resetButton.layer.cornerRadius = 25
        resetButton.setTitle("リセット", for: .normal)
        resetButton.titleLabel?.textColor = UIColor.white
        resetButton.titleLabel?.textAlignment = .center
        // resetButton.addTarget(self, action: #selector(moveViewPositionReset(sender:)), for: .touchUpInside)
        view.addSubview(resetButton)
        
        speedLabel.text = "\(moveSpeed)"
        speedLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        speedLabel.textAlignment = .center
        view.addSubview(speedLabel)
        
        // self.view = view
    }
     
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let viewWidth = view.frame.width
        let viewHeight = view.frame.height
        
        baseLineImageView.layer.position = CGPoint(x: viewWidth/2, y: 100)
        descriptionTextLabel.frame = CGRect(x: 0, y: 0, width: viewWidth-20, height: 50)
        descriptionTextLabel.layer.position = CGPoint(x: viewWidth/2, y: viewHeight/10*3)
        
        fireButton.layer.position = CGPoint(x: viewWidth/2, y: viewHeight/2)
        
        moveView.layer.position = CGPoint(x: (viewWidth-300)/2, y: 100)
        speedStepper.layer.position = CGPoint(x: viewWidth/10*2, y: viewHeight/10*9)
        
        resetButton.layer.position = CGPoint(x: viewWidth/4*3, y: viewHeight/10*9)
        
        speedLabel.layer.position = CGPoint(x: viewWidth/5*1, y: viewHeight/10*8)
        
        startX = (view.frame.width-300)/2
        endX = view.frame.width-startX
    }
    /*
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    @objc func buttonTapped(sender: UIButton) {
        //button status check
        
        if buttonStatus {
            //move状態
            buttonStatus = false
            fireButton.backgroundColor = customBlue
            fireButton.setTitle("スタート", for: .normal)
            
            //moveView.layer.position = CGPoint(x: startX, y: 100)
            
            animator?.stopAnimation(true)
            
            // TODO self.present(ResultViewController(), animated: true, completion: nil)
        } else {
            buttonStatus = true
            fireButton.backgroundColor = customRed
            fireButton.setTitle("ストップ", for: .normal)
            
            setAnimation()
            animator?.startAnimation()
        }
        
    }
    
    @objc func stepperCahnged(sender: UIStepper) {
        let speed = (1 / sender.value)*10
        moveSpeed = speed
        speedLabel.text = "\(sender.value)"
    }
    
    @objc func moveViewPositionReset(sender:UIButton) {
        self.moveView.layer.position = CGPoint(x: startX, y: 100)
    }
    
    func setAnimation() {
        let timing = UICubicTimingParameters(animationCurve: .linear)
        animator = UIViewPropertyAnimator(duration: moveSpeed, timingParameters: timing)
        
        animator?.addAnimations {
            self.moveView.layer.position = CGPoint(x: self.endX, y: 100)
        }
    }*/
}
