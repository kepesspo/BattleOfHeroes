//
//  GameManagement.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/3/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit

enum GameMode: String {
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
    case haveIEverNever = "haveIEverNever"
    case whoAmI = "howIAmView"
    case spoon = "spoonView"
    case thePeopleChoice = "thePeopleChoiceView"
    case russianRoulette = "russianRouletteView"
    
    
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
        case .haveIEverNever: return "GameTitle_haveIEverNever".localized()
        case .whoAmI: return "GameTitle_whoAmI".localized()
        case .spoon: return "GameTitle_spoon".localized()
        case .thePeopleChoice: return "GameTitle_thePeopleChoice".localized()
        case .russianRoulette: return "GameTitle_russianRoulette".localized()
            
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
        case .haveIEverNever: return "GameDiscription_haveIEverNever".localized()
        case .whoAmI: return "GameDiscription_whoAmI".localized()
        case .spoon: return "GameDiscription_spoon".localized()
        case .thePeopleChoice: return "GameDiscription_thePeopleChoice".localized()
        case .russianRoulette: return "GameDiscription_russianRoulette".localized()
        }
    }
    
    func gameMode() -> GameMode {
        switch self {
        case .trueOrFalse: return .trueOrFalse
        case .categories: return .categories
        case .hajime: return .hajime
        case .everybodyDrinks: return .everybodyDrinks
        case .wheelOfFortune:return .wheelOfFortune
        case .upAndDown: return .upAndDown
        case .ringOfFire: return .ringOfFire
        case .memory: return .memory
        case .musicRecognizer: return .musicRecognizer
        case .switchHand: return .switchHand
        case .rockPaperScissors: return .rockPaperScissors
        case .fingerIt: return .fingerIt
        case .cheersToTheGovernor: return .cheersToTheGovernor
        case .haveIEverNever: return .haveIEverNever
        case .whoAmI: return .whoAmI
        case .spoon: return .spoon
        case .thePeopleChoice: return .thePeopleChoice
        case .russianRoulette: return .russianRoulette
        }
    }
    
    func gameType() -> GameType {
        switch self {
        case .trueOrFalse: return .normalGame
        case .categories: return .normalGame
        case .hajime: return .normalGame
        case .everybodyDrinks: return .normalGame
        case .wheelOfFortune:return .normalGame
        case .upAndDown: return .normalGame
        case .ringOfFire: return .toolGame
        case .memory: return .normalGame
        case .musicRecognizer: return .teamGame
        case .switchHand: return .toolGame
        case .rockPaperScissors: return .normalGame
        case .fingerIt: return .normalGame
        case .cheersToTheGovernor: return .normalGame
        case .haveIEverNever: return .normalGame
        case .whoAmI: return .teamGame
        case .spoon: return .toolGame
        case .thePeopleChoice: return .teamGame
        case .russianRoulette: return .normalGame
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
        case .haveIEverNever: return HaveIEverNeverView()
        case .whoAmI: return WhoAmIView()
        case .spoon: return SpoonView()
        case .thePeopleChoice: return ThePeopleChoiceView()
        case .russianRoulette: return RussianRouletteView()
        }
    }
    
    
    func gameImage() -> UIImage {
        switch self {
        case .trueOrFalse: return #imageLiteral(resourceName: "035-friend")
        case .categories: return #imageLiteral(resourceName: "034-chat")
        case .hajime: return #imageLiteral(resourceName: "016-best-friend")
        case .everybodyDrinks: return #imageLiteral(resourceName: "024-friendship-1")
        case .wheelOfFortune: return #imageLiteral(resourceName: "006-loyalty")
        case .upAndDown: return #imageLiteral(resourceName: "011-friendship")
        case .ringOfFire: return #imageLiteral(resourceName: "022-bracelet")
        case .memory: return #imageLiteral(resourceName: "008-puzzle")
        case .musicRecognizer: return #imageLiteral(resourceName: "021-listener")
        case .switchHand: return #imageLiteral(resourceName: "041-shaka")
        case .rockPaperScissors: return #imageLiteral(resourceName: "026-fist")
        case .fingerIt: return #imageLiteral(resourceName: "014-sharing")
        case .cheersToTheGovernor: return #imageLiteral(resourceName: "012-beer")
        case .haveIEverNever: return #imageLiteral(resourceName: "002-mad")
        case .whoAmI: return #imageLiteral(resourceName: "033-reunion")
        case .spoon: return #imageLiteral(resourceName: "045-crossed-arrows")
        case .thePeopleChoice: return #imageLiteral(resourceName: "040-friends.png")
        case .russianRoulette: return #imageLiteral(resourceName: "030-dependable.png")
        }
    }
    
    
    
}


enum GameType : String {
    case normalGame = "Normál Játékok"
    case toolGame = "Eszközös játákok"
    case teamGame = "Csapat játékok"
    
    static let allValues = [normalGame,toolGame,teamGame]

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
    
    var gamesCategories =  ["Film",
                            "Zene",
                            "Sport",
                            "Gaming",
                            "Stand",
                            "Szépség",
                            "Hiresség",
                            "Természet",
                            "Utazás",
                            "Politika",
                            "Kaja",
                            "Űr"]
    
    // everyBodyDrinks Onece
    var everyBodyDrinksPlayerCountIndex = 0
    
    
    
    
    // Music Recognizer
    var spotifyToken = UserDefaults.standard.string(forKey: UserDefaultsKeys.spotifyToken) {
        didSet {
            UserDefaults.standard.set(spotifyToken, forKey: UserDefaultsKeys.spotifyToken)
        }
    }
    var songTrackIDList = ["26eZSJp30jI0aPdpQL55xC",
                           "6naxalmIoLFWR0siv8dnQQ",
                           "1q7VPiBFlBF7PMtmI6mWyM",
                           "0p34Y0tZFOvG3UpZQizOzv",
                           "2771LMNxwf62FTAdpJMQfM",
                           "0Qt4s6DQlOsdhNW64DkZK3",
                           "400QEuv1HXJcm7gGSya4fn",
                           "547GSUncZG09Bvfd8s0Cmy",
                           "6RnkFd8Fqqgk1Uni8RgqCQ",
                           "344jzKdBGLJYZdhKjj4884"]
    
    
    
    // Ring of fire
    var ringOFFirePlayerCounter = 0
    var ringOfFirePlayerCountIndex = 0
    
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
    
    //Card Setup
    func setCopyCardsList() -> [UIImage:CardValue] {
        copyCards = cards
        return copyCards
    }
    
    
    
    
    
    
    // Game Setup
    var chosenGames = [Game]()
    var gameModes : [GameMode] = [GameMode]()
    func getChosenGameMode() -> [GameMode] {
        gameModes = [GameMode.trueOrFalse,
                     GameMode.categories,
                     GameMode.hajime,
                     GameMode.everybodyDrinks,
                     GameMode.wheelOfFortune,
                     GameMode.upAndDown,
                     GameMode.ringOfFire,
                     GameMode.memory,
                     GameMode.musicRecognizer,
                     GameMode.switchHand,
                     GameMode.rockPaperScissors,
                     GameMode.fingerIt,
                     GameMode.cheersToTheGovernor,
                     GameMode.haveIEverNever,
                     GameMode.whoAmI,
                     GameMode.spoon,
                     GameMode.thePeopleChoice,
                     GameMode.russianRoulette]
        
        return gameModes
    }
    
    
    
    
    
    
    var games = [Game]()
    func getGames() -> [Game] {
        getChosenGameMode()
        games.removeAll()
        for game in gameModes {
            let mode = game.gameMode()
            let name = game.gameTitle()
            let description = game.gameDiscription()
            let type = game.gameType()
            let gameImage = game.gameImage()
            let gameData = Game(id: "", name: name, description: description, isSelected: false, gameMode: mode, gameType: type, gameImage: gameImage)
            games.append(gameData)
        }
        return games
    }
}
