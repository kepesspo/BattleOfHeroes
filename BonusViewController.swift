//
//  BonusViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 10/5/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import MDCCommon
import Lottie

class BonusViewController: UIViewController {

    @IBOutlet weak var giveDrinksBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var playerTableView: UITableView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var bonusAnimationView: LOTAnimationView!
    @IBOutlet weak var contentView: UIView!
    
    var playerForBonus = [Player]()
    var playerList = [Player]()
    var name: String?
    var tableviewHeight : CGFloat?
    
    var drinks : [Int] = [2,3,5,7]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = playerForBonus[0].playerName
        playerTableView.isHidden = true
        okButton.isHidden = true
        resultLabel.isHidden = true
        self.giveDrinksBtn.isHidden = true
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        playerTableView.separatorStyle = .none
        tableviewHeight = playerTableView.rowHeight * CGFloat(playerList.count)
        playerTableView.contentSize.height = tableviewHeight ?? 0
        
        playerList = Factory.shared.playerList
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openBonus))
        bonusAnimationView.addGestureRecognizer(gesture)
        playBonusAnimation()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func closeAction(_ sender: Any) {
        Factory.shared.dataManager.updatePlayerUseBonus(player: playerForBonus[0], bonus: 1) { (error) in
            if error == nil {
                self.dismiss(animated: true, completion: nil)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    @IBAction func giveDrinks(_ sender: Any) {
        playerTableView.isHidden = false
        giveDrinksBtn.isHidden = true
        
    }
    
    func playBonusAnimation() {
        bonusAnimationView.loopAnimation = false
        bonusAnimationView.play()
        
    }
    
    @objc func openBonus() {
        self.bonusAnimationView.isHidden = true
        self.giveDrinksBtn.isHidden = false
    }
    
}


extension BonusViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Factory.shared.playerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let customCell = Bundle.main.loadNibNamed("BonusPlayerTableViewCell",
                                                     owner: self,
                                                     options: nil)?.first as? BonusPlayerTableViewCell {
            customCell.selectionStyle = .none
            customCell.contentView.backgroundColor = UIColor(hexString: "#FFD393")
            let player = playerList[indexPath.row]
            customCell.nameLabel.text = player.playerName
            
            return customCell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        okButton.isHidden = false
        resultLabel.isHidden = false
        playerTableView.allowsSelection = false
        playerTableView.isScrollEnabled = false
        let selectedPlayer = playerList[indexPath.row]
        let randomDrinks = Int(arc4random_uniform(UInt32(drinks.count)))
        resultLabel.text = "\(selectedPlayer.playerName) a büntetésed \(drinks[randomDrinks]) pia"
        
        if let indexPath = playerTableView.indexPathForSelectedRow {
            let currentCell = playerTableView.cellForRow(at: indexPath) as? BonusPlayerTableViewCell
            currentCell?.contentView.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8431372549, blue: 0.168627451, alpha: 1)
        }
    }
}
