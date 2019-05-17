//
//  DrinkCounterViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/8/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import TTSegmentedControl

class DrinkCounterViewController: UIViewController {
    
    @IBOutlet weak var howDrinksTableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var drinkingSegmentedControl: TTSegmentedControl!
    @IBOutlet weak var infoText: UILabel!
    
    let playersList = NetworkSevice.sharedInstance.playerList
    
    var actullyDrinkCount = 0
    var drinkValue : [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeForNotification(name: .showBonus, selector: #selector(showBonusView(notification:)), object: nil)
        howDrinksTableView.separatorStyle = .none
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        drinkingSegmentedControl.itemTitles = []
        drinkingSegmentedControl.defaultTextFont = UIFont.helveticaNeueLight(15)
        drinkingSegmentedControl.selectedTextFont = UIFont.helveticaNeueLight(15)
        drinkingSegmentedControl.layer.cornerRadius = 5
        drinkingSegmentedControl.allowChangeThumbWidth = false
       
        
        infoText.text = "DrinkCounterViewController_infoText".localized()
        
        for valueOfDrink in drinkValue {
            drinkingSegmentedControl.itemTitles.append("\(valueOfDrink)")
        }
        
        if drinkValue.count == 1 {
            self.actullyDrinkCount = drinkValue[0]
            drinkingSegmentedControl.isUserInteractionEnabled = false
        } else {
            self.actullyDrinkCount = drinkValue[0]
            drinkingSegmentedControl.isUserInteractionEnabled = true
        }
    
        
        
        drinkingSegmentedControl.didSelectItemWith = { (index, title) -> () in
            switch index {
            case 0:
                self.actullyDrinkCount = self.drinkValue[0]
                print("")
            case 1:
                self.actullyDrinkCount = self.drinkValue[1]
               print("")
            case 2:
                self.actullyDrinkCount = self.drinkValue[2]
                print("")
            case 3:
                self.actullyDrinkCount = self.drinkValue[3]
                print("")
            default:
                print("Default")
            }
            print("Selected item \(index)")
            
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveDrinksData(_ sender: Any) {
        GameManagement.sharedInstance.userDefDrinkVariation = true
        GameManagement.sharedInstance.drinkVariation = []
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        if let customCell = Bundle.main.loadNibNamed("HowDrinksTableViewCell",
                                                     owner: self,
                                                     options: nil)?.first as? HowDrinksTableViewCell {
            
            let lightYellowColor = UIColor(red:0.97, green:0.91, blue:0.40, alpha:0.5)
            customCell.contentView.backgroundColor = lightYellowColor
            customCell.player = playersList[indexPath.row]
            return customCell
        }
        return UITableViewCell()
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPath = howDrinksTableView.indexPathForSelectedRow {
            let currentCell = howDrinksTableView.cellForRow(at: indexPath) as? HowDrinksTableViewCell
            currentCell?.contentView.backgroundColor = #colorLiteral(red: 0.8470588235, green: 0.8431372549, blue: 0.168627451, alpha: 1)
            let updatedPlayer = playersList[indexPath.row]
            NetworkSevice.sharedInstance.updatePlayerDrinks(player: updatedPlayer, drinks: actullyDrinkCount) { (error) in
                if error != nil {
                    print("error")
                } else {
                    currentCell?.drinkCountLabel.text = "\(self.actullyDrinkCount)"
                    print(updatedPlayer)
                }
            }
            
        }
        
        
    }   
}

extension UIFont {
    class func helveticaNeueLight(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Light", size: size)!
    }
}
