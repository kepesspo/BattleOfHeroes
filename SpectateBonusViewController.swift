//
//  SpectateBonusViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 4/23/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import UIKit
import MDCCommon

class SpectateBonusViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var playerTableView: UITableView!
    
    var playerList = [Player]()
    var playerName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        playerTableView.separatorStyle = .none
        playerTableView.layer.cornerRadius = 10
        
        playerList = NetworkSevice.sharedInstance.playerList
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func okAction(_ sender: Any) {
        NetworkSevice.sharedInstance.playerHowGetDrinksForSpectator(playerName: playerName) { (error) in
            if error == nil {
                print("Mark added")
            } else {
                print("Error when added spectator drink member")
            }
        }
        self.dismiss(animated: true, completion: nil)
    }

}
extension SpectateBonusViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NetworkSevice.sharedInstance.playerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let customCell = Bundle.main.loadNibNamed("BonusPlayerTableViewCell",
                                                     owner: self,
                                                     options: nil)?.first as? BonusPlayerTableViewCell {
            if  indexPath.row % 2 == 0 {
                let lightBlueColor = UIColor(red:0.06, green:0.78, blue:0.80, alpha:0.5)
                customCell.contentView.backgroundColor = lightBlueColor
                //customCell.backgroundColor = lightBlueColor
            } else {
                let lightYellowColor = UIColor(red:0.97, green:0.91, blue:0.40, alpha:0.5)
                customCell.contentView.backgroundColor = lightYellowColor
                customCell.nameLabel.textColor = UIColor(red:0.06, green:0.78, blue:0.80, alpha:1.0)
            }
            
            let player = playerList[indexPath.row]
            customCell.nameLabel.text = player.playerName
            
            return customCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        okButton.isHidden = false
        playerTableView.allowsSelection = false
        playerTableView.isScrollEnabled = false
        let selectedPlayer = playerList[indexPath.row]
        playerName = selectedPlayer.playerName
        
        
    }
}

