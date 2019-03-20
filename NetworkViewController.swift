//
//  NetworkViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 3/7/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit

class NetworkViewController: UIViewController {

    @IBOutlet weak var networkErrorView: LottieView!
    @IBOutlet weak var networkLabel: UILabel!
    
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
        networkLabel.text = "Waiting for internet connection..."
        networkErrorView.loopAnimation = true
        networkErrorView.play()
        
        
    }
    
    func dismissErrorNetworkView () {
        self.removeFromParent()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
