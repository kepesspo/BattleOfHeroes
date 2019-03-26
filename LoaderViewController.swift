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

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loaderView.loopAnimation = true
        loaderView.play()
        loaderTextLabel.text = "GameLoaderText".localized()
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
