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
    
    @IBOutlet weak var contentView: UIView!
    let playersList = NetworkSevice.sharedInstance.playerList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeForNotification(name: .showBonus, selector: #selector(showBonusView(notification:)), object: nil)
        howDrinksTableView.separatorStyle = .none
        howDrinksTableView.allowsSelection = false
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveDrinksData(_ sender: Any) {
        //postNotification(name: .dismissGame)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func showBonusView(notification : Notification) {
        let player = notification.object as? Player
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BonusViewController") as! BonusViewController
        vc.playerForBonus.append(player!)
        vc.name = player?.playerName
        self.present(vc, animated: true, completion: nil)
        
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
            
            
            if  indexPath.row % 2 == 0 {
                let lightBlueColor = UIColor(red:0.06, green:0.78, blue:0.80, alpha:0.5)
                customCell.contentView.backgroundColor = lightBlueColor
                //customCell.backgroundColor = lightBlueColor
            } else {
                let lightYellowColor = UIColor(red:0.97, green:0.91, blue:0.40, alpha:0.5)
                customCell.contentView.backgroundColor = lightYellowColor
                customCell.drinksPlayerLabel.textColor = UIColor(red:0.06, green:0.78, blue:0.80, alpha:1.0)
            }
            customCell.player = playersList[indexPath.row]
            return customCell
        }
        return UITableViewCell()
        
        
    }
    
    
    
}
