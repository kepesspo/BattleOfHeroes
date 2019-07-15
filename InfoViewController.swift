//
//  InfoViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 12/17/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import MDCCommon

class InfoViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var informationTextView: UITextView!
    @IBOutlet weak var infoImageView: UIImageView!
    
    var infoText :String?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popView.layer.cornerRadius = 30
        popView.layer.masksToBounds = true
        informationTextView.text = infoText
        infoImageView.image = image ?? UIImage()
    }
    

    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
