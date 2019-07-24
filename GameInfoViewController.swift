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

    var masks: [(rect: CGRect, radius: CGFloat)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let press = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        self.view.addGestureRecognizer(press)
//        contentView.layer.cornerRadius = 10
//        contentView.layer.masksToBounds = true
//        infoLabel.text = "A játék kiválasztásához nyomd meg a játék ikonját. \n\n Amennyiben szeretnéd személyre szabni a játékot akkor a jobb oldalt megtalálható gombra vagy (long tappel) tudod elérni. \n\n A játék irányító felületén fogsz látni információt a játékról illetve pár tulajdonságot. \n\n Ha az alsó panelt felhúzod a játék menetet tudod szabályozni."
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupMaskWith(mask: masks[0])
    }
    
    func setupMaskWith(mask: (rect: CGRect, radius: CGFloat)) {
        let shape = CAShapeLayer()
        shape.frame = view.bounds
        let path = UIBezierPath(rect: view.bounds)
        path.append(UIBezierPath(roundedRect: mask.rect, cornerRadius: mask.radius))
        
//        path.append(UIBezierPath(roundedRect: CGRect(x: mask.rect.minX,
//                                                     y: mask.rect.maxY + 50,
//                                                     width: mask.rect.width,
//                                                     height: mask.rect.height),
//                                 cornerRadius: mask.radius))
        
        
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
