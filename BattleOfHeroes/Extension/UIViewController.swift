//
//  UIViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 6/14/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon

extension UIViewController {
    func curveTopCorners() {
        let path = UIBezierPath(roundedRect: self.view.bounds,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: 30, height: 0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.view.bounds
        maskLayer.path = path.cgPath
        self.view.layer.mask = maskLayer
    }
}
