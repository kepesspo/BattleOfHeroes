//
//  FamousPerson.swift
//  BattleOfHeroes
//
//  Created by Mark on 11/19/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation

struct FamousPerson {
    var name = ""
    var age = ""
    var occupation = ""
    var image = ""
    
    
    init(name: String, age: String, occupation: String, image: String) {
        self.name = name
        self.age = age
        self.occupation = occupation
        self.image = image
    }
}
