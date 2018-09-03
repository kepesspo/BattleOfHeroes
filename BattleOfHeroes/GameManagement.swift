//
//  GameManagement.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/3/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

enum GameModes: String, EnumCollection {
    case trueOrFalse = "trueOrFalse"
    case categories = "categories"
    case hajime = "hajime"
    case everybodyDrinks = "everybodyDrinks"
    case wheelOfFortune = "wheelOfFortune"
    case upAndDown = "upAndDown"
    case ringOfFire = "ringOfFire"
    case memory = "memory"
    case musicRecognizer = "musicRecognizer"
    case switchHand = "switchHand"
    case rockPaperScissors = "rockPaperScissors"
    case fingerIt = "fingerIt"
    case cheersToTheGovernor = "cheersToTheGovernor"
    
    
    func gameTitle() -> String {
        switch self {
        case .trueOrFalse: return "GameTitle_trueOrFalse".localized()
        case .categories: return "GameTitle_categories".localized()
        case .hajime: return "GameTitle_hajime".localized()
        case .everybodyDrinks: return "GameTitle_everybodyDrinks".localized()
        case .wheelOfFortune: return "GameTitle_wheelOfFortune".localized()
        case .upAndDown: return "GameTitle_upAndDown".localized()
        case .ringOfFire: return "GameTitle_ringOfFire".localized()
        case .memory: return "GameTitle_memory".localized()
        case .musicRecognizer: return "GameTitle_musicRecognizer".localized()
        case .switchHand: return "GameTitle_switchHand".localized()
        case .rockPaperScissors: return "GameTitle_rockPaperScissors".localized()
        case .fingerIt: return "GameTitle_fingerIt".localized()
        case .cheersToTheGovernor: return "GameTitle_cheersToTheGovernor".localized()
        }
    }
    
    func gameDiscription() -> String {
        switch self {
        case .trueOrFalse: return "GameDiscription_trueOrFalse".localized()
        case .categories: return "GameDiscription_categories".localized()
        case .hajime: return "GameDiscription_hajime".localized()
        case .everybodyDrinks: return "GameDiscription_everybodyDrinks".localized()
        case .wheelOfFortune: return "GameDiscription_wheelOfFortune".localized()
        case .upAndDown: return "GameDiscription_upAndDown".localized()
        case .ringOfFire: return "GameDiscription_ringOfFire".localized()
        case .memory: return "GameDiscription_memory".localized()
        case .musicRecognizer: return "GameDiscription_musicRecognizer".localized()
        case .switchHand: return "GameDiscription_switchHand".localized()
        case .rockPaperScissors: return "GameDiscription_rockPaperScissors".localized()
        case .fingerIt: return "GameDiscription_fingerIt".localized()
        case .cheersToTheGovernor: return "GameDiscription_cheersToTheGovernor".localized()
        }
    }
    
    func gameView() -> GameView {
        switch self {
        case .trueOrFalse: return TrueOrFalseView()
        case .categories: return CategoriesView()
        case .hajime: return HajimeView()
        case .everybodyDrinks: return EverybodyDrinksView()
        case .wheelOfFortune: return WheelOfFortuneView()
        case .upAndDown: return UpAndDownView()
        case .ringOfFire: return RingOfFireView()
        case .memory: return MemoryView()
        case .musicRecognizer: return MusicRecognizerView()
        case .switchHand: return SwitchHandView()
        case .rockPaperScissors: return RockPaperScissorsView()
        case .fingerIt: return FingerItView()
        case .cheersToTheGovernor: return CheersToTheGovernorView()
        }
    }
    
    
    
    
}

enum CardValue: String {
    case two = "two"
    case three = "three"
    case four = "four"
    case five = "five"
    case six = "six"
    case seven = "seven"
    case eight = "eight"
    case nine = "nine"
    case ten = "ten"
    case jack = "jack"
    case queen = "Queen"
    case king = "king"
    case ace = "ace"
    
    func rulesString() -> String {
        switch self {
        case .two: return "is Choose – Válasz valakit aki iszik"
        case .three: return "is Me – Én iszok"
        case .four: return " is Whore – Összes lány iszik"
        case .five: return "Thumb Master - Aki kihuzza ö a jatékmester. Az ujját az asztalra helyezve. Aki utoljára utánnoza az iszik"
        case .six: return "is Dicks – Fiuk isznak"
        case .seven: return "is Heaven – Felkel mutatni az égre aki utoljára utánozza az iszik"
        case .eight: return "is Mate – Válasz valakit aki iszik veled"
        case .nine: return "Rhyme  - Aki huzta a lapot annak kell egy szot mondani. Utánna következőnek meg rimelnie kell arra a szora. ha nem siekerul akkor iszik"
        case .ten: return "Categories - Választni kell egy kategoriát és utánna abba a kategoriába kell mondani szot"
        case .jack: return " Make a Rule – Hozzni kell egy szabályt amit utánna be kell tartani."
        case .queen: return "Questions –Kérdésekkel kell beszélni egymással"
        case .king: return "Pour!- Összekell önteni a piákat. Az utolsó megissza"
        case .ace: return "Waterfall-  addig kell inni ameddig aki kihuzta az ászt"
        }
    }
    
    func cardIntValue() -> Int {
        switch self {
        case .two: return 2
        case .three: return 3
        case .four: return 4
        case .five: return 5
        case .six: return 6
        case .seven: return 7
        case .eight: return 8
        case .nine: return 9
        case .ten: return 10
        case .jack: return 11
        case .queen: return 12
        case .king: return 13
        case .ace: return 14
        }
    }
}

class GameManagement {
    static let sharedInstance = GameManagement()
    
    
    
    var cards = [#imageLiteral(resourceName: "2_of_clubs"): CardValue.two,#imageLiteral(resourceName: "2_of_spades"):CardValue.two,#imageLiteral(resourceName: "2_of_hearts"):CardValue.two,#imageLiteral(resourceName: "2_of_diamonds"):CardValue.two,
                 #imageLiteral(resourceName: "3_of_clubs"): CardValue.three,#imageLiteral(resourceName: "3_of_hearts"):CardValue.three,#imageLiteral(resourceName: "3_of_spades"):CardValue.three,#imageLiteral(resourceName: "3_of_diamonds"):CardValue.three,
                 #imageLiteral(resourceName: "4_of_clubs"): CardValue.four,#imageLiteral(resourceName: "4_of_hearts"):CardValue.four,#imageLiteral(resourceName: "4_of_spades"):CardValue.four,#imageLiteral(resourceName: "4_of_diamonds"):CardValue.four,
                 #imageLiteral(resourceName: "5_of_clubs"): CardValue.five,#imageLiteral(resourceName: "5_of_hearts"):CardValue.five,#imageLiteral(resourceName: "5_of_spades"):CardValue.five,#imageLiteral(resourceName: "5_of_diamonds"):CardValue.five,
                 #imageLiteral(resourceName: "6_of_clubs"):CardValue.six,#imageLiteral(resourceName: "6_of_hearts"):CardValue.six,#imageLiteral(resourceName: "6_of_spades"):CardValue.six,#imageLiteral(resourceName: "6_of_diamonds"):CardValue.six,
                 #imageLiteral(resourceName: "7_of_clubs"):CardValue.seven,#imageLiteral(resourceName: "7_of_spades"):CardValue.seven,#imageLiteral(resourceName: "7_of_hearts"):CardValue.seven,#imageLiteral(resourceName: "7_of_diamonds"):CardValue.seven,
                 #imageLiteral(resourceName: "8_of_clubs"):CardValue.eight,#imageLiteral(resourceName: "8_of_hearts"):CardValue.eight,#imageLiteral(resourceName: "8_of_spades"):CardValue.eight,#imageLiteral(resourceName: "8_of_diamonds"):CardValue.eight,
                 #imageLiteral(resourceName: "9_of_clubs"):CardValue.nine,#imageLiteral(resourceName: "9_of_hearts"):CardValue.nine,#imageLiteral(resourceName: "9_of_spades"):CardValue.nine,#imageLiteral(resourceName: "9_of_diamonds"):CardValue.nine,
                 #imageLiteral(resourceName: "10_of_clubs"):CardValue.ten,#imageLiteral(resourceName: "10_of_spades"):CardValue.ten,#imageLiteral(resourceName: "10_of_hearts"):CardValue.ten,#imageLiteral(resourceName: "10_of_diamonds"):CardValue.ten,
                 #imageLiteral(resourceName: "jack_of_clubs"):CardValue.jack,#imageLiteral(resourceName: "jack_of_spades"):CardValue.jack,#imageLiteral(resourceName: "jack_of_hearts"):CardValue.jack,#imageLiteral(resourceName: "jack_of_diamonds"):CardValue.jack,
                 #imageLiteral(resourceName: "queen_of_clubs"):CardValue.queen,#imageLiteral(resourceName: "queen_of_hearts"):CardValue.queen,#imageLiteral(resourceName: "queen_of_spades"):CardValue.queen,#imageLiteral(resourceName: "queen_of_diamonds"):CardValue.queen,
                 #imageLiteral(resourceName: "king_of_clubs"):CardValue.king,#imageLiteral(resourceName: "king_of_spades"):CardValue.king,#imageLiteral(resourceName: "king_of_hearts"):CardValue.king,#imageLiteral(resourceName: "king_of_diamonds"):CardValue.king,
                 #imageLiteral(resourceName: "ace_of_clubs"):CardValue.ace,#imageLiteral(resourceName: "ace_of_hearts"):CardValue.ace,#imageLiteral(resourceName: "ace_of_spades"):CardValue.ace,#imageLiteral(resourceName: "ace_of_diamonds"):CardValue.ace]
//
    var cardWithValue = [#imageLiteral(resourceName: "2_of_hearts"): CardValue.two,
                         #imageLiteral(resourceName: "3_of_hearts"): CardValue.three,
                         #imageLiteral(resourceName: "4_of_hearts"):CardValue.four,
                         #imageLiteral(resourceName: "5_of_hearts"):CardValue.five,
                         #imageLiteral(resourceName: "6_of_hearts"):CardValue.six,
                         #imageLiteral(resourceName: "7_of_hearts"): CardValue.seven,
                         #imageLiteral(resourceName: "8_of_hearts"): CardValue.eight,
                         #imageLiteral(resourceName: "9_of_hearts"):CardValue.nine,
                         #imageLiteral(resourceName: "10_of_hearts"):CardValue.ten,
                         #imageLiteral(resourceName: "jack_of_hearts"):CardValue.jack,
                         #imageLiteral(resourceName: "queen_of_hearts"):CardValue.queen,
                         #imageLiteral(resourceName: "king_of_hearts"): CardValue.king,
                         #imageLiteral(resourceName: "ace_of_hearts"): CardValue.ace]
    
    var copyCards = [UIImage:CardValue]()
    
    var defaultGameModes = ["trueOrFalse",
                            "categories",
                            "hajime",
                            "everybodyDrinks",
                            "wheelOfFortune",
                            "upAndDown",
                            "ringOfFire",
                            "musicRecognizer",
                            "switchHand",
                            "rockPaperScissors",
                            "fingerIt",
                            "cheersToTheGovernor"]
    
    var GamesView = [TrueOrFalseView(),
                     CategoriesView(),
                     HajimeView(),
                     EverybodyDrinksView(),
                     WheelOfFortuneView(),
                     UpAndDownView(),
                     RingOfFireView(),
                     MemoryView(),
                     MusicRecognizerView(),
                     SwitchHandView(),
                     RockPaperScissorsView(),
                     FingerItView(),
                     CheersToTheGovernorView()]
    
    var gamesCategories =  ["Film","Zene","Sport","Gaming","Stand","Szépség","Hiresség","Természet","Utazás","Politika","Kaja","Űr"]
    
    var everyBodyDrinksPlayerCountIndex = 0
    var ringOfFirePlayerCountIndex = 0
    
    
    // Számolja hogy megyik jatékosnál tartotatok
    var ringOFFirePlayerCounter = 0
    var gameModes = [String]()
    var randomColorSwitchIsON = true
    var randomColorVC = "Random Color"
    
    
    // Game Setup
    func getGames() -> [GameView] {
        var games = [GameView]()
        for gameName in GameManagement.sharedInstance.gameModes {
            games.append(GameModes.init(rawValue: gameName)!.gameView())
        }
        return games
    }
    
    func getAllGameNames() -> [GameModes] {
        var games = [GameModes]()
        for game in GameModes.cases() {
            games.append(game)
        }
        return games
    }
    
    func defaultGameSetUp() {
        GameManagement.sharedInstance.gameModes = defaultGameModes
    }
    
    
    
    //Card Setup
    func setCopyCardsList() -> [UIImage:CardValue] {
        copyCards = cards
        return copyCards
    }
}

public protocol EnumCollection: Hashable {
    static func cases() -> AnySequence<Self>
    static var allValues: [Self] { get }
}

public extension EnumCollection {
    
    public static func cases() -> AnySequence<Self> {
        return AnySequence { () -> AnyIterator<Self> in
            var raw = 0
            return AnyIterator {
                let current: Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else {
                    return nil
                }
                raw += 1
                return current
            }
        }
    }
    
    public static var allValues: [Self] {
        return Array(self.cases())
    }
}
