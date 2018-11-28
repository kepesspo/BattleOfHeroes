//
//  GameInfoBlurViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 9/17/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

class GameInfoBlurViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let press = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        self.view.addGestureRecognizer(press)
        
        infoLabel.text = "Long tap to show game details screen. You can customize the game and you get some information about the game"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
