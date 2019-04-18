//
//  LoaderViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 12/10/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import Lottie

class LoaderViewController: UIViewController {

    @IBOutlet weak var loaderView: LOTAnimationView!
    @IBOutlet weak var loaderTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if GameManagement.sharedInstance.selectedMode == 1 {
            self.view.backgroundColor = #colorLiteral(red: 0.7269999981, green: 0.8669999838, blue: 0.875, alpha: 1)
            loaderView.backgroundColor = #colorLiteral(red: 0.7269999981, green: 0.8669999838, blue: 0.875, alpha: 1)
            
        } else {
            self.view.backgroundColor =  #colorLiteral(red: 0.9647058824, green: 0.8666666667, blue: 0.8745098039, alpha: 1)
            loaderView.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.8666666667, blue: 0.8745098039, alpha: 1)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loaderView.loopAnimation = true
        loaderView.play()
        loaderTextLabel.text = "GameLoaderText".localized()
       
        
        
    }
}
