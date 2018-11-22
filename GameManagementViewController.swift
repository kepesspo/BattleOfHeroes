//
//  GameManagementViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 11/22/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

class GameManagementViewController: UIViewController {
    
    @IBOutlet weak var infoBtn: UIButton!
    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
 
    @IBAction func infoAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameDetaisViewController") as! GameDetaisViewController
        vc.titleData = game?.name
        vc.descriptionData = game?.description
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func closeManagement(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
