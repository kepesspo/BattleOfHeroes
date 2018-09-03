//
//  RandomColorViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 7/5/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

class RandomColorViewController: UIViewController {
    
    var randomColorView  : UIView!
    var randomColorViewButton : UIButton!
    
    var colorsToGetRandomly : [UIColor] = [UIColor.white,UIColor.white, UIColor.white, UIColor.white, UIColor.white]
    var randomGestuseImages : [UIImage] = [#imageLiteral(resourceName: "001-like"),#imageLiteral(resourceName: "003-hand"),#imageLiteral(resourceName: "002-clap")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        RandomColorPresenter.sharedInstance.isAlreadyPresented = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        RandomColorPresenter.sharedInstance.isAlreadyPresented = false
        RandomColorPresenter.sharedInstance.canThrow = true
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func generateColorView(color: UIColor, image: UIImage) {
        randomColorView = UIView()
        randomColorView.frame = view.bounds
        randomColorView.backgroundColor = color
        
        randomColorViewButton = UIButton()
        randomColorViewButton.frame = CGRect(x:self.view.frame.size.width / 2 - 100,
                                             y: self.view.frame.size.height / 2 - 100,
                                             width: 200,
                                             height: 200)
        
        randomColorViewButton.setBackgroundImage(image, for: .normal)
        
        randomColorViewButton.addTarget(self, action: #selector(dismissSelf), for: UIControlEvents.touchUpInside)
        randomColorView.addSubview(randomColorViewButton)
        
        self.view.addSubview(randomColorView)
        if let topController = UIApplication.topViewController() {
            topController.present(self, animated: true, completion: nil)
        }
        
    }
    
    @objc func genareateColor() {
        let indexToColor = Int(arc4random_uniform(UInt32(colorsToGetRandomly.count)))
        let indexGesture = Int(arc4random_uniform(UInt32(randomGestuseImages.count)))
        
        let color = colorsToGetRandomly[indexToColor]
        let image = randomGestuseImages[indexGesture]
        generateColorView(color: color, image: image)
    }
}

