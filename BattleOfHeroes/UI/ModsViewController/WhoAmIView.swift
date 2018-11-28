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
    @IBOutlet weak var gameInLevelLabel: UILabel!
    @IBOutlet weak var whoAmILabel: UILabel!
    @IBOutlet weak var howAmIImageView: UIImageView!
    @IBOutlet weak var answerBtn: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var occurationLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    var famousPersonList = NetworkSevice.sharedInstance.famousPerson
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    func commonInit() {
        subscribeForNotification(name: .addCounterValue, selector: #selector(updateLevelCounterUI), object: nil)
        self.tap.isEnabled = true
        Bundle.main.loadNibNamed("WhoAmIView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateUI()
        updateLevelCounterUI()
        
    }
    
    @objc func updateLevelCounterUI() {
        gameInLevelLabel.text = self.levelCounter
    }
    
    func updateUI() {
        nameLabel.isHidden = true
        occurationLabel.isHidden = true
        ageLabel.isHidden = true
        
        
        let randomIndex = Int(arc4random_uniform(UInt32(famousPersonList.count)))
        nameLabel.text = famousPersonList[randomIndex].name
        occurationLabel.text = famousPersonList[randomIndex].occupation
        ageLabel.text = famousPersonList[randomIndex].age
        let imageUrl = NSURL(string: famousPersonList[randomIndex].image)
        
        downloadImage(from: imageUrl as! URL)
        self.howAmIImageView.layer.cornerRadius = 10
        self.howAmIImageView.clipsToBounds = true
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
        answerBtn.isHidden = true
        nameLabel.isHidden = false
        occurationLabel.isHidden = false
        ageLabel.isHidden = false
        
    }
}