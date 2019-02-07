//
//  GroupDrinkViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 1/25/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit

class GroupDrinkViewController: UIViewController {

    @IBOutlet weak var drinkView: LottieView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playGroupDrinkAnimation()
        
        // Do any additional setup after loading the view.
    }
    
    func playGroupDrinkAnimation() {
        drinkView.loopAnimation = true
        drinkView.play()
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func doneButtonAction(_ sender: Any) {
        postNotification(name: .reloadGroupDrinkTimer)
        self.dismiss(animated: true, completion: nil)
    }
    
}
