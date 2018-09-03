//
//  GameDetaisViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/14/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

class GameDetaisViewController: UIViewController {
    
    @IBOutlet weak var gameDescriptionLabel: UILabel!
    @IBOutlet weak var gameTitleLabel: UILabel!
    
    var titleData: String?
    var descriptionData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpView() {
        gameTitleLabel.text = titleData
        gameDescriptionLabel.text = descriptionData
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
