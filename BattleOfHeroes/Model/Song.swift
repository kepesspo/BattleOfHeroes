//
//  Song.swift
//  BattleOfHeroes
//
//  Created by Mark on 11/22/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation

struct Song {
    var mainImage = ""
    var name = ""
    var previewURL = ""
    var artist = ""
    
    init(mainImage: String, name: String, previewURL:String, artist: String) {
        self.mainImage = mainImage
        self.name = name
        self.previewURL = previewURL
        self.artist = artist
    }
}
