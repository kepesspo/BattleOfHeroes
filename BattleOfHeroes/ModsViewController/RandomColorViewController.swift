//
//  RandomColorViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/5/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

class RandomColorViewController: UIViewController {
    
    enum timePeriod : TimeInterval {
        case easy = 3.0
        case medium = 6.0
        case hard = 9.0
    }

    @IBOutlet weak var startRoundBtn: UIButton!
    
    
    var randomColorView  : UIView!
    var randomColorViewButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func nextRoundAction(_ sender: Any) {
       runTimer()
        
    }
    
    @objc func runTimer() {
        self.randomColorView?.removeFromSuperview()
        
        let randomNumber = [timePeriod.easy, timePeriod.medium, timePeriod.hard]
        let index = Int(arc4random_uniform(UInt32(randomNumber.count)))
        let number = randomNumber[index]
       
        _ = Timer.scheduledTimer(timeInterval: number.rawValue, target: self, selector: #selector(generateColorView), userInfo: nil, repeats: false)
    }
    
    @objc func generateColorView() {
        let colorsToGetRandomly = [UIColor.red, UIColor.blue, UIColor.green]
        let index = Int(arc4random_uniform(UInt32(colorsToGetRandomly.count)))
        let color = colorsToGetRandomly[index]
        
        randomColorView = UIView()
        randomColorView.frame = CGRect(x: self.view.frame.origin.x,
                                       y: self.view.frame.origin.y,
                                       width: self.view.frame.size.width,
                                       height: self.view.frame.size.height)
        randomColorView.backgroundColor = color
        
        randomColorViewButton = UIButton()
        randomColorViewButton.frame = CGRect(x:self.view.frame.size.width / 2 - 100,
                                             y: self.view.frame.size.height / 2 - 100,
                                             width: 200,
                                             height: 200)
        
        let text = NSMutableAttributedString()
        text.appendColored(.white, font: .bold(60), "Stop")
        
        randomColorViewButton.setAttributedTitle(text, for:.normal)
        
        
        randomColorViewButton.addTarget(self, action: #selector(runTimer), for: UIControlEvents.touchUpInside)
        
//        let gestureRecognizer = UITapGestureRecognizer(target: self.randomColorView, action:#selector(handleTap))
//        randomColorView.addGestureRecognizer(gestureRecognizer)
        
        randomColorView.addSubview(randomColorViewButton)
        
        self.view.addSubview(randomColorView)
    }
    
//    @objc func handleTap(gestureRecognizer: UITapGestureRecognizer) {
//        runTimer()
//    }
    @IBAction func showRandView(_ sender: Any) {
        

//        let trueOrFalse = trueOrFalseView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
//        self.view.addSubview(trueOrFalse)
    }
    
}

