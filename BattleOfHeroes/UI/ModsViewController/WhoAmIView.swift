//
//  WhoAmIView.swift
//  BattleOfHeroes
//
//  Created by Mark on 9/18/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

class WhoAmIView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var howAmIImageView: UIImageView!
    @IBOutlet weak var answerBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    var famousPersonList = NetworkSevice.sharedInstance.famousPerson
    let playersList = NetworkSevice.sharedInstance.playerList
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    func commonInit() {
        self.tap.isEnabled = false
        Bundle.main.loadNibNamed("WhoAmIView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
        
    }
    
    func updateUI() {
        if let player = GameManagement.sharedInstance.getNextGamePlayer() {
            print("Player: \(player.playerName)")
            GameManagement.sharedInstance.actuallyPlayer = player
            GameManagement.sharedInstance.actuallyPlayedGameCounter = GameManagement.sharedInstance.actuallyPlayedGameCounter + 1
            GameManagement.sharedInstance.actuallyPlayedGameType = #imageLiteral(resourceName: "001-idea.png")
            postNotification(name: .updateGameData)
        }
        
        nameLabel.isHidden = true
        
        let randomIndexForFamPerson = Int(arc4random_uniform(UInt32(famousPersonList.count)))
        
        let personOccupation = famousPersonList[randomIndexForFamPerson].occupation
        if GameManagement.sharedInstance.allowedPersonOccupation.contains(personOccupation) {
            nameLabel.text = famousPersonList[randomIndexForFamPerson].name
            let imageUrl = NSURL(string: famousPersonList[randomIndexForFamPerson].image)
            downloadImage(from: imageUrl! as URL)
        } else {
            updateUI()
        }
        
        
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.howAmIImageView.image = UIImage(data: data)
            }
        }
    }
    
    @IBAction func answerAction(_ sender: Any) {
        self.tap.isEnabled = true
        answerBtn.isHidden = true
        nameLabel.isHidden = false
        
    }
}
