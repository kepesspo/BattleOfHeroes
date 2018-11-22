//
//  LottieView.swift
//  BattleOfHeroes
//
//  Created by Mark on 11/20/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import Lottie

class LottieView: LOTAnimationView {
    fileprivate(set) var name: String?
    
    override func setAnimation(named animationName: String) {
        super.setAnimation(named: animationName)
        name = animationName
    }

}
