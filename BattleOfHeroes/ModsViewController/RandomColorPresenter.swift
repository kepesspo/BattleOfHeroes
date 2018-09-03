//
//  RandomColorPresenter.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/16/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation


enum timePeriod : TimeInterval {
    case easy = 18.0
    case medium = 24.0
    case hard = 30.0
}

class RandomColorPresenter {
    static let sharedInstance = RandomColorPresenter()
    
    var canThrow : Bool = true
    var isAlreadyPresented: Bool = false

    var randomNumber : [timePeriod] = [timePeriod.easy, timePeriod.medium, timePeriod.hard]

    init() {
        runTimer()
    }
    
    func runTimer(time: TimeInterval? = nil) {
        let index = Int(arc4random_uniform(UInt32(randomNumber.count)))
        let number = randomNumber[index]
        _ = Timer.scheduledTimer(timeInterval: time ?? number.rawValue,
                                 target: self,
                                 selector: #selector(createRandomViewController),
                                 userInfo: nil,
                                 repeats: false)
    }
    
    @objc func createRandomViewController() {
        guard canThrow && !isAlreadyPresented else {
            runTimer(time: 5.0)
            return
        }
        runTimer()
        canThrow = false
        let randomVC = RandomColorViewController()
        randomVC.genareateColor()
    }
}

