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

    let baseLineImageView = UIImageView()
    public let descriptionTextLabel: UILabel = UILabel()
    public let moveView:UIView = UIView()
    
    public let fireButton: UIButton = UIButton()
    public let resetButton:UIButton = UIButton()
    
    public let speedStepper = UIStepper()
    public let speedLabel = UILabel()
    var buttonStatus:Bool = false
    public var moveSpeed:Double = 1
    
    let customRed = UIColor(red:0.91, green:0.56, blue:0.56, alpha:1.00)
    let customBlue = UIColor(red:0.58, green:0.74, blue:0.89, alpha:1.00)
    let customGreen = UIColor(red:0.53, green:0.74, blue:0.45, alpha:1.00)
    
    var animator:UIViewPropertyAnimator?
    
    var startX:CGFloat = 0
    var endX:CGFloat = 0
    
    public var fireButtonAction: ()->() = {}
    public var resetButtonAction: ()->() = {}
    public var viewWidth: Int = 0
    public var viewHeight: Int = 0
    
    public func receive(_ message: PlaygroundValue) {
        // Implement this method to receive messages sent from the process running Contents.swift.
        // This method is *required* by the PlaygroundLiveViewMessageHandler protocol.
        // Use this method to decode any messages sent as PlaygroundValue values and respond accordingly.
        
        switch message {
        case let .string(text):
            descriptionTextLabel.text = "texttttt\(text)"
            
        default:
            break
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red:0.97, green:0.98, blue:0.98, alpha:1.00)
        
        baseLineImageView.frame = CGRect(x: 0, y: 0, width: 400, height: 18)
        // not use image
        // let image: UIImage = UIImage(named: "baseLine.png")!
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
        fireButton.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        
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
        speedStepper.stepValue = 3
        speedStepper.addTarget(self, action: #selector(stepperCahnged(sender:)), for: .valueChanged)
        view.addSubview(speedStepper)
        
        //resetButton
        resetButton.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        resetButton.backgroundColor = customGreen
        resetButton.layer.cornerRadius = 25
        resetButton.setTitle("リセット", for: .normal)
        resetButton.titleLabel?.textColor = UIColor.white
        resetButton.titleLabel?.textAlignment = .center
        resetButton.addTarget(self, action: #selector(moveViewPositionReset(sender:)), for: .touchUpInside)
        view.addSubview(resetButton)
        
        speedLabel.text = "\(moveSpeed)"
        speedLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        speedLabel.textAlignment = .center
        view.addSubview(speedLabel)
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let viewWidth = view.frame.width
        let viewHeight = view.frame.height
        
        self.viewWidth = Int(viewWidth)
        self.viewHeight = Int(viewHeight)
        
        baseLineImageView.layer.position = CGPoint(x: viewWidth/2, y: 100)
        descriptionTextLabel.frame = CGRect(x: 0, y: 0, width: viewWidth-20, height: 50)
        descriptionTextLabel.layer.position = CGPoint(x: viewWidth/2, y: viewHeight/10*3)
        
        // fireButton.layer.position = CGPoint(x: viewWidth/2, y: viewHeight/2)
        
        moveView.layer.position = CGPoint(x: (viewWidth-baseLineImageView.frame.width)/2, y: 100)
        // speedStepper.layer.position = CGPoint(x: viewWidth/10*2, y: viewHeight/10*9)
        
        // resetButton.layer.position = CGPoint(x: viewWidth/4*3, y: viewHeight/10*9)
        
        // speedLabel.layer.position = CGPoint(x: viewWidth/5*1, y: viewHeight/10*8)
        
        startX = (view.frame.width - baseLineImageView.frame.width)/2
        endX = view.frame.width-startX
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    @objc func buttonTapped(sender: UIButton) {
        //button status check
        
        fireButtonAction()
        
        /*
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
        */
    }
    
    public func movePointStart() {
        buttonStatus = true
        fireButton.backgroundColor = customRed
        fireButton.setTitle("ストップ", for: .normal)
        
        setAnimation()
        animator?.startAnimation()
    }
    
    public func movePointStop() {
        buttonStatus = false
        fireButton.backgroundColor = customBlue
        fireButton.setTitle("スタート", for: .normal)
        
        // moveView.layer.position = CGPoint(x: startX, y: 100)
        
        animator?.stopAnimation(true)
    }
    
    @objc func stepperCahnged(sender: UIStepper) {
        let speed = (1 / sender.value)*10
        moveSpeed = speed
        speedLabel.text = "\(sender.value)"
    }
    
    @objc func moveViewPositionReset(sender:UIButton) {
        resetButtonAction()
        // self.moveView.layer.position = CGPoint(x: startX, y: 100)
    }
    
    public func setSpeed(_ speed: Double) {
        let speed = (1 / speed)*10
        moveSpeed = speed
        speedLabel.text = "\(speed)"
    }
    
    public func pointReset() {
        self.moveView.layer.position = CGPoint(x: startX, y: 100)
    }
    
    func setAnimation() {
        let timing = UICubicTimingParameters(animationCurve: .linear)
        animator = UIViewPropertyAnimator(duration: moveSpeed, timingParameters: timing)
        
        animator?.addAnimations {
            self.moveView.layer.position = CGPoint(x: self.endX, y: 100)
        }
    }
}
