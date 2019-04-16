//
//  EndGameViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 12/18/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit

class EndGameViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var showResultBtn: UIButton!
    @IBOutlet weak var endGameBtn: UIButton!
    @IBOutlet weak var endGameTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view.
    }
    
    func setUpView() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        //showResultBtn.setTitle("EndGameViewController_showResultBtnTitle".localized(), for: .normal)
        //endGameBtn.setTitle("EndGameViewController_endGameBtnTitle".localized(), for: .normal)
        //endGameTitle.text = "EndGameViewController_titleText".localized()
        
    }

    @IBAction func closeAndGameView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func showScoreView() {
        let scorePopVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScoreViewController") as! ScoreViewController
        scorePopVC.modalPresentationStyle = .overFullScreen
        self.present(scorePopVC, animated: true, completion: nil)
    }
    
    
    @IBAction func showResultView(_ sender: Any) {
        showScoreView()
    }
    
    @IBAction func endGameAction(_ sender: Any) {
        GameManagement.sharedInstance.battlePlayer = []
        GameManagement.sharedInstance.actuallyPlayedGameCounter = 0
        GameManagement.sharedInstance.gameStarted = false
        self.dismiss(animated: false, completion: nil)
        postNotification(name: .endGame)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
