//
//  NetworkViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 3/7/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit
import MDCCommon

class NetworkViewController: UIViewController {

    @IBOutlet weak var networkErrorView: LottieView!
    @IBOutlet weak var networkLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playNetworkErrorAnimation()
    }
    
    func playNetworkErrorAnimation() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        print("Play Network Error Animation")
        networkLabel.text = "Ha nincs internet hozzáférés akkor az olyan játékok ahol internet kapcsolatra van szükség azok a játékok tovább lesznek léptetve"
        networkErrorView.loopAnimation = true
        networkErrorView.play()
        
        
    }
    
    func dismissErrorNetworkView () {
        self.removeFromParent()
    }

    
    @IBAction func continueAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
