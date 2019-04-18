//
//  ScoreViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/4/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var scoreTableView: UITableView!
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var horseRaceBtn: UIButton!
    
    var playersList = NetworkSevice.sharedInstance.playerList
    var timer : Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeForNotification(name: .reloadScoreTableView, selector: #selector(reloadScoreTableView), object: nil)
        scoreTableView.separatorStyle = .none
        popView.layer.cornerRadius = 10
        popView.layer.masksToBounds = true
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(reloadScoreTableView), userInfo: nil, repeats: true)
        
        horseRaceBtn.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    
    @IBAction func horseRaceAction(_ sender: Any) {
        let raceBet = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HorseRaceBetViewController") as! HorseRaceBetViewController
        raceBet.modalPresentationStyle = .overFullScreen
        self.present(raceBet, animated: true, completion: nil)
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
            
            
            NetworkSevice.sharedInstance.getHorseRaceRunning(completionBlock: { (error, valueHorseRace) in
                if valueHorseRace == 1 {
                    self.horseRaceBtn.isHidden = false
                } else {
                    self.horseRaceBtn.isHidden = true
                }
            })
            
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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
            customCell.playerDrinksLabel.text = "\(playerL[indexPath.row].allDrink)"
            customCell.playerPositionLabel.text = "\(indexPath.row + 1)"
            return customCell
        }
        return UITableViewCell()
        
    }
    
    
    
}
