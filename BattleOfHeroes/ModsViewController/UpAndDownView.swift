//
//  UpAndDownView.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/3/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

class UpAndDownView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var upAndDownTextLabel: UILabel!
    @IBOutlet weak var downBtn: UIButton!
    @IBOutlet weak var upBtn: UIButton!
    @IBOutlet weak var numberTextLabel: UILabel!
    @IBOutlet weak var drinksCounter: UILabel!
    
    var cards : [Int] = [2,3,4,5,6,7,8,9,10,11,12,13,14]
    var randNumbIndex : Int = 0
    var nextRandNumbIndex : Int = 0
    var nextButtonValue : Int = 0
    var drinks : Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    func commonInit() {
        Bundle.main.loadNibNamed("UpAndDownView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        upAndDownTextLabel.text = "Mi lesz a következő szám nagyobb vagy kissebb?"
        // First Init randNumb
        randNumbIndex = Int(arc4random_uniform(UInt32(cards.count)))
        numberTextLabel.text = "\(cards[randNumbIndex])"
        drinksCounter.text = "A Piák száma"
        print("Rand Number: \(cards[randNumbIndex])")

        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap))
        contentView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    func uppdateUI() {
        numberTextLabel.text = "\(cards[randNumbIndex])"
        drinks = drinks + 1
        drinksCounter.text = "\(drinks)"
    }
    
    func showNextRandomNumber() {
        nextRandNumbIndex = Int(arc4random_uniform(UInt32(cards.count)))
        print("Next Rand Number: \(cards[nextRandNumbIndex])")
        if randNumbIndex > nextRandNumbIndex && nextButtonValue == 1 {
            randNumbIndex = nextRandNumbIndex
            uppdateUI()
        } else if randNumbIndex < nextRandNumbIndex && nextButtonValue == 2 {
            randNumbIndex = nextRandNumbIndex
            uppdateUI()
        } else if randNumbIndex == nextRandNumbIndex {
            showNextRandomNumber()
        } else {
            numberTextLabel.text = "Lose"
            downBtn.isHidden = true
            upBtn.isHidden = true
        }
        
    }
    
    @IBAction func downBtnAction(_ sender: Any) {
        nextButtonValue = 1
        showNextRandomNumber()
    }
    
    @IBAction func upBtnAction(_ sender: Any) {
        nextButtonValue = 2
        showNextRandomNumber()
    }
    
    
    
    @objc func handleTap(gestureRecognizer: UITapGestureRecognizer) {
        self.removeFromSuperview()
    }
}
