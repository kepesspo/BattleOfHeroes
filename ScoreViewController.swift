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
    @IBOutlet weak var addDrinksBtn: UIButton!
    
    var playersList = NetworkSevice.sharedInstance.playerList
    var timer : Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeForNotification(name: .reloadScoreTableView, selector: #selector(reloadScoreTableView), object: nil)
        scoreTableView.separatorStyle = .none
        popView.layer.cornerRadius = 30
        popView.layer.masksToBounds = true
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(reloadScoreTableView), userInfo: nil, repeats: true)
        
        addDrinksBtn.isHidden = true
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
    
    @IBAction func addDrinksAction(_ sender: Any) {
        let spectateBonus = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SpectateBonusViewController") as! SpectateBonusViewController
        spectateBonus.modalPresentationStyle = .overFullScreen
        self.present(spectateBonus, animated: true, completion: nil)
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
            
            
            NetworkSevice.sharedInstance.getPlayerHowGetDrinks(completionBlock: { (error, valuePlayerShow) in
                if valuePlayerShow == 1 {
                    self.addDrinksBtn.isHidden = false
                } else {
                    self.addDrinksBtn.isHidden = true
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
                let lightYellow = UIColor(red:0.97, green:0.91, blue:0.40, alpha:0.5)
                customCell.contentView.backgroundColor = lightYellow
            } else {
                let lightOrage = UIColor(hexString: "#FFD393")
                customCell.contentView.backgroundColor = lightOrage
                customCell.playerNameLabel.textColor = UIColor(hexString: "#FFFFFF")
            }
            
            
            customCell.playerNameLabel.text = playerL[indexPath.row].playerName
            customCell.playerDrinksLabel.text = "\(playerL[indexPath.row].allDrink)"
            customCell.playerPositionLabel.text = "\(indexPath.row + 1)"
            return customCell
        }
        return UITableViewCell()
        
    }
    
    
    
}
