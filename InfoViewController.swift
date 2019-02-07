//
//  InfoViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 12/17/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var informationTextView: UITextView!
    
    var infoText :String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popView.layer.cornerRadius = 10
        popView.layer.masksToBounds = true
        informationTextView.text = infoText
        // Do any additional setup after loading the view.
    }
    

    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
