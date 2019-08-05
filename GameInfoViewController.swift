//
//  GameInfoViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 9/17/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import MDCCommon

class GameInfoViewController: UIViewController {

    @IBOutlet weak var firstMaskStackView: UIStackView!
    @IBOutlet weak var secondMaskStackView: UIStackView!
    @IBOutlet weak var thirdMaskStackView: UIStackView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    
    var masks: [(rect: CGRect, radius: CGFloat)] = []
    var counter: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        firstLabel.text = "Játék kijelöléshez nyomd meg a játék ikonját."
        secondLabel.text = "Nyomd a 3 pontot a játék személyre szabásához."
        thirdLabel.text = "Játékmenet beállításokért húzd fel a panelt."
        let press = UITapGestureRecognizer(target: self, action: #selector(nextMask))
        self.view.addGestureRecognizer(press)
    }
    
    @objc func nextMask() {
        counter = counter + 1
        if counter == 0 {
            setupMaskWith(mask: masks[0])
            firstMaskStackView.isHidden = false
            secondMaskStackView.isHidden = true
            thirdMaskStackView.isHidden = true
        } else if counter == 1 {
            setupMaskWith(mask: masks[1])
            firstMaskStackView.isHidden = true
            secondMaskStackView.isHidden = false
            thirdMaskStackView.isHidden = true
        } else if counter == 2 {
            setupMaskWith(mask: masks[2])
            firstMaskStackView.isHidden = true
            secondMaskStackView.isHidden = true
            thirdMaskStackView.isHidden = false
        } else {
            self.dismissView()
            counter = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupMaskWith(mask: masks[0])
        secondMaskStackView.isHidden = true
        thirdMaskStackView.isHidden = true
        counter = 0
    }
    
    func setupMaskWith(mask: (rect: CGRect, radius: CGFloat)) {
        let shape = CAShapeLayer()
        shape.frame = view.bounds
        let path = UIBezierPath(rect: view.bounds)
        path.append(UIBezierPath(roundedRect: mask.rect, cornerRadius: mask.radius))
        shape.path = path.cgPath
        shape.fillRule = .evenOdd
        view.layer.mask = shape
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissView() {
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.firstRunClosed)
        self.dismiss(animated: true, completion: nil)
        
    }

}
