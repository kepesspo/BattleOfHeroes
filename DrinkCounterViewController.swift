//
//  DrinkCounterViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/8/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

class DrinkCounterViewController: UIViewController {
    
    @IBOutlet weak var howDrinksTableView: UITableView!
    
    let playersList = NetworkSevice.sharedInstance.playerList
    
    override func viewDidLoad() {
        super.viewDidLoad()

        howDrinksTableView.allowsSelection = false
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        RandomColorPresenter.sharedInstance.canThrow = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveDrinksData(_ sender: Any) {
        if GameManagement.sharedInstance.randomColorSwitchIsON {
            RandomColorPresenter.sharedInstance.canThrow = true
        }
        //postNotification(name: .dismissGame)
        self.dismiss(animated: true, completion: nil)
    }

}

extension DrinkCounterViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        if let customCell = Bundle.main.loadNibNamed("HowDrinksTableViewCell",
                                                     owner: self,
                                                     options: nil)?.first as? HowDrinksTableViewCell {
            customCell.player = playersList[indexPath.row]
            return customCell
        }
        return UITableViewCell()
        
        
    }
    
    
    
}
