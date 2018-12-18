//
//  ScoreViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/4/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var endGameBtn: UIButton!
    @IBOutlet weak var scoreTableView: UITableView!
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var BackButton: UIButton!
    
    var playersList = NetworkSevice.sharedInstance.playerList
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeForNotification(name: .reloadScoreTableView, selector: #selector(reloadScoreTableView), object: nil)
        scoreTableView.separatorStyle = .none
        popView.layer.cornerRadius = 10
        popView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    
    
    @objc func reloadScoreTableView() {
        DispatchQueue.main.async {
        NetworkSevice.sharedInstance.getPlayerList(completionBlock: { (error) in
                if error != nil {
                    print("Error")
                } 
                self.playersList = NetworkSevice.sharedInstance.playerList
                self.scoreTableView.reloadData()
            })
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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

extension ScoreViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("ScoreHeaderTableViewCell",
                                                  owner: self,
                                                  options: nil)?.first as? ScoreHeaderTableViewCell
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let customCell = Bundle.main.loadNibNamed("ScoreTableViewCell",
                                                     owner: self,
                                                     options: nil)?.first as? ScoreTableViewCell {
            
            let playerL = playersList.sorted(by: { $0.allDrink > $1.allDrink })
            
            if  indexPath.row % 2 == 0 {
                let lightOrage = UIColor(red:0.96, green:0.59, blue:0.48, alpha:0.5)
                customCell.contentView.backgroundColor = lightOrage
                //customCell.backgroundColor = lightBlueColor
            } else {
                let lightYellow = UIColor(red:0.97, green:0.91, blue:0.40, alpha:0.5)
                customCell.contentView.backgroundColor = lightYellow
                customCell.playerNameLabel.textColor = UIColor(red:0.96, green:0.59, blue:0.48, alpha:1.0)
            }
            
            
            customCell.playerNameLabel.text = playerL[indexPath.row].playerName
            customCell.playerLifeLabel.text = "\(playerL[indexPath.row].life)"
            customCell.playerDrinksLabel.text = "\(playerL[indexPath.row].allDrink)"
            customCell.playerPositionLabel.text = "\(indexPath.row + 1)"
            return customCell
        }
        return UITableViewCell()
        
    }
    
    
    
}
