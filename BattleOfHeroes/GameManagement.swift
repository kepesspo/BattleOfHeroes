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
    case shipTrip = "shipTrip"
    case horseRace = "horseRace"
    case anagram = "anagram"
    case coinFlip = "coinFlip"
    case fiveThing = "fiveThing"
    case collectAndBoom = "collectAndBoom"
    case theBottle = "theBottle"
    case tapper = "tapper"
    case tickTak = "tickTak"
    
    
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
        case .shipTrip: return "GameTitle_shipTrip".localized()
        case .horseRace: return "GameTitle_horseRace".localized()
        case .anagram: return "GameTitle_anagram".localized()
        case .coinFlip: return "GameTitle_coinFlip".localized()
        case .fiveThing: return "GameTitle_fiveThing".localized()
        case .collectAndBoom: return "GameTitle_collectAndBoom".localized()
        case .theBottle: return "GameTitle_theBottle".localized()
        case .tapper: return "GameTitle_tapper".localized()
        case .tickTak: return "GameTitle_TickTak".localized()
        }
    }
    
    func gameDescription() -> String {
        switch self {
        case .trueOrFalse: return "GameDescription_trueOrFalse".localized()
        case .categories: return "GameDescription_categories".localized()
        case .hajime: return "GameDescription_hajime".localized()
        case .everybodyDrinks: return "GameDescription_everybodyDrinks".localized()
        case .wheelOfFortune: return "GameDescription_wheelOfFortune".localized()
        case .upAndDown: return "GameDescription_upAndDown".localized()
        case .ringOfFire: return "GameDescription_ringOfFire".localized()
        case .memory: return "GameDescription_memory".localized()
        case .musicRecognizer: return "GameDescription_musicRecognizer".localized()
        case .switchHand: return "GameDescription_switchHand".localized()
        case .rockPaperScissors: return "GameDescription_rockPaperScissors".localized()
        case .fingerIt: return "GameDescription_fingerIt".localized()
        case .cheersToTheGovernor: return "GameDescription_cheersToTheGovernor".localized()
        case .haveIEverNever: return "GameDescription_haveIEverNever".localized()
        case .whoAmI: return "GameDescription_whoAmI".localized()
        case .spoon: return "GameDescription_spoon".localized()
        case .thePeopleChoice: return "GameDescription_thePeopleChoice".localized()
        case .russianRoulette: return "GameDescription_russianRoulette".localized()
        case .shipTrip: return "GameDescription_shipTrip".localized()
        case .horseRace: return "GameDescription_horseRace".localized()
        case .anagram: return "GameDescription_anagram".localized()
        case .coinFlip: return "GameDescription_coinFlip".localized()
        case .fiveThing: return "GameDescription_fiveThing".localized()
        case .collectAndBoom: return "GameDescription_collectAndBoom".localized()
        case .theBottle: return "GameDescription_theBottle".localized()
        case .tapper: return "GameDescription_tapper".localized()
        case .tickTak: return "GameDescription_TickTak".localized()
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
        case .shipTrip: return .shipTrip
        case .horseRace: return .horseRace
        case .anagram: return .anagram
        case .coinFlip: return .coinFlip
        case .fiveThing: return .fiveThing
        case .collectAndBoom: return .collectAndBoom
        case .theBottle: return .theBottle
        case .tapper: return .tapper
        case .tickTak: return .tickTak
        }
    }
    
    func gameType() -> GameType {
        switch self {
        case .trueOrFalse: return .personalGame
        case .categories: return .lineGame
        case .hajime: return .lineGame
        case .everybodyDrinks: return .personalGame
        case .wheelOfFortune:return .groupGame
        case .upAndDown: return .lineGame
        case .ringOfFire: return .groupGame
        case .memory: return .lineGame
        case .musicRecognizer: return .personalGame
        case .switchHand: return .groupGame
        case .rockPaperScissors: return .battleGame
        case .fingerIt: return .groupGame
        case .cheersToTheGovernor: return .lineGame
        case .haveIEverNever: return .groupGame
        case .whoAmI: return .personalGame
        case .spoon: return .groupGame
        case .thePeopleChoice: return .personalGame
        case .russianRoulette: return .personalGame
        case .shipTrip: return .groupGame
        case .horseRace: return .groupGame
        case .anagram: return .personalGame
        case .coinFlip: return .battleGame
        case .fiveThing: return .personalGame
        case .collectAndBoom: return .lineGame
        case .theBottle: return .groupGame
        case .tapper: return .battleGame
        case .tickTak: return .groupGame
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
        case .shipTrip: return ShiptripView()
        case .horseRace: return HorseRaceView()
        case .anagram: return AnagramView()
        case .coinFlip: return CoinFlipView()
        case .fiveThing: return FiveThingsView()
        case .collectAndBoom: return CollectAndBoomView()
        case .theBottle: return TheBottleView()
        case .tapper: return TapperView()
        case .tickTak: return TickTakView()
        }
    }
    
    func gameManagementView() -> UIView {
        switch self {
        case .musicRecognizer: return MusicRecognizerManagerView()
        case .whoAmI: return WhoAmIManagerView()
        case .trueOrFalse: return TrueOrFalseManagerView()
        default:
            return UIView()
        }
    }
    
    
    func gameImage() -> UIImage {
        switch self {
        case .trueOrFalse: return #imageLiteral(resourceName: "035-friend")
        case .categories: return #imageLiteral(resourceName: "034-chat")
        case .hajime: return #imageLiteral(resourceName: "013-laugh.png")
        case .everybodyDrinks: return #imageLiteral(resourceName: "024-friendship-1")
        case .wheelOfFortune: return #imageLiteral(resourceName: "006-loyalty")
        case .upAndDown: return #imageLiteral(resourceName: "011-friendship")
        case .ringOfFire: return #imageLiteral(resourceName: "022-bracelet")
        case .memory: return #imageLiteral(resourceName: "008-puzzle")
        case .musicRecognizer: return #imageLiteral(resourceName: "021-listener")
        case .switchHand: return #imageLiteral(resourceName: "041-shaka")
        case .rockPaperScissors: return #imageLiteral(resourceName: "026-fist")
        case .fingerIt: return #imageLiteral(resourceName: "014-sharing")
        case .cheersToTheGovernor: return #imageLiteral(resourceName: "036-toast.png")
        case .haveIEverNever: return #imageLiteral(resourceName: "002-mad")
        case .whoAmI: return #imageLiteral(resourceName: "033-reunion")
        case .spoon: return #imageLiteral(resourceName: "045-crossed-arrows")
        case .thePeopleChoice: return #imageLiteral(resourceName: "040-friends.png")
        case .russianRoulette: return #imageLiteral(resourceName: "030-dependable.png")
        case .shipTrip: return #imageLiteral(resourceName: "019-search.png")
        case .horseRace: return #imageLiteral(resourceName: "017-origami.png")
        case .anagram: return #imageLiteral(resourceName: "018-social-media.png")
        case .coinFlip: return #imageLiteral(resourceName: "005-promise.png")
        case .fiveThing: return #imageLiteral(resourceName: "007-connection.png")
        case .collectAndBoom: return #imageLiteral(resourceName: "025-add-friend.png")
        case .theBottle: return #imageLiteral(resourceName: "012-beer.png")
        case .tapper: return #imageLiteral(resourceName: "016-best-friend.png")
        case .tickTak: return #imageLiteral(resourceName: "048-letter.png")
        }
    }
}


let GamesDownloadingData: [GameMode] = [
    .whoAmI,
    .trueOrFalse,
    .haveIEverNever,
    .musicRecognizer,
    .anagram
]


enum GameType : String {
    case personalGame = "Egyéni Játékok"
    case groupGame = "Csoportos Játékok"
    case lineGame = "Sor Játékok"
    case battleGame = "Kétszemélyes Játékok"
    static let allValues = [personalGame,groupGame,lineGame,battleGame]
    
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
    
    var networkWorks = false
    
    func isOnboardingClosed() -> Bool {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.onboardingClosed) != nil
    }
    
    func firstRun() -> Bool {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.firstRunClosed) != nil
    }
    
    func getRoomName() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.roomName) ?? ""
    }
    
    func getGameData() -> (roomid: String, roomPass: String) {
        let roomId = UserDefaults.standard.string(forKey: UserDefaultsKeys.roomId)
        let roomName = UserDefaults.standard.string(forKey: UserDefaultsKeys.roomPass)
        let roomPass = UserDefaults.standard.string(forKey: UserDefaultsKeys.roomPass)
        return (roomId ?? "",roomPass ?? "")
    }
    
    var gamesCategories =  ["Film","Zene","Sport","Gaming","Stand","Szépség","Hiresség","Természet","Utazás","Politika","Kaja","Űr"]
    var easyCategories = ["Film","Zene","Sport","Gaming","Stand","Szépség","Hiresség","Természet","Utazás","Politika","Kaja","Űr"]
    var mediumCategies = ["Autó márkák","Már halott emberek","Olimpiai bajnokok","Játék szoftverek","Növények","Kutya Fajták","Alkohol márkák vagy fajta","Tv csatornák"]
    var hardCategories = ["Amerikai Elnőkők","Feltalálok","Programozási kifejezések","Növényevő állatok","Tavak"]
    
    // everyBodyDrinks Onece
    var everyBodyDrinksPlayerCountIndex = 0
    
    
    
    
    // Music Recognizer
    var spotifyToken = UserDefaults.standard.string(forKey: UserDefaultsKeys.spotifyToken) {
        didSet {
            UserDefaults.standard.set(spotifyToken, forKey: UserDefaultsKeys.spotifyToken)
        }
    }
    
    var allowedYears: [Int] = [1980, 1981, 1982, 1983, 1984, 1985, 1986, 1987, 1988, 1989, 1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019]
    
    var allowedPersonOccupation: [String] = ["ENTREPRENEUR",
                                             "US Presidents",
                                             "DJ",
                                             "ACTRESS",
                                             "Actor",
                                             "Soccer Players",
                                             "YouTube Star",
                                             "TV Actress",
                                             "Pop Singer",
                                             "Rapper",
                                             "Reality Star",
                                             "Instagram Star",
                                             "Dancer"]
    
    
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
    var defChosenGames = [Game]()
    
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
                     //GameMode.cheersToTheGovernor,
                     GameMode.haveIEverNever,
                     GameMode.whoAmI,
                     //GameMode.spoon,
                     //GameMode.thePeopleChoice,
                     GameMode.russianRoulette,
                     //GameMode.shipTrip,
                     GameMode.horseRace,
                     GameMode.anagram,
                     GameMode.coinFlip,
                     GameMode.fiveThing,
                     GameMode.collectAndBoom,
                     GameMode.theBottle,
                     GameMode.tapper,
                     GameMode.tickTak
        ]
        
        return gameModes
    }
    
    
    var battleGameModes : [GameMode] = [GameMode]()
    func getBattleGameMode() -> [GameMode] {
        battleGameModes = [GameMode.hajime,
                           GameMode.upAndDown,
                           GameMode.memory,
                           GameMode.rockPaperScissors,
                           GameMode.musicRecognizer,
                           GameMode.whoAmI,
                           GameMode.coinFlip,
                           GameMode.fiveThing,
                           GameMode.collectAndBoom,
                           GameMode.tapper,
                           GameMode.tickTak]
        return battleGameModes
    }
    
    var battlePlayer: [Player] = []
    
    var gameDrinkMultiplier : Int = 1
    
    var showBonusView : Bool = true
    var drininkCounterView : Bool = true
    
    var groupDrinksAllow : Bool = true
    var groupDrinkTime : Int = 300
    
    var randomPictogramAllow : Bool = true
    var randomPictogramTime : Int = 420
    
    var drinkVariation : [Int] = [0,1,2,3]
    
    var userDefDrinkVariation = true
    
    var selectedMode = 0
    
    var battlePlayerOneValue = 0
    var battlePlayerTwoValue = 0
    
    var actuallyPlayedGameCounter = 0
    var actuallyPlayerName = ""
    var actuallyPlayedGameType = #imageLiteral(resourceName: "001-idea.png")
    var actuallyGameDesc = ""
    
    var gameStarted = false
    var isSpactate = false
    
    var selectedSpac = 0
    var battleGameRun = false
    
    
    var figures = ["black_figures-1","blue_figures-1","yellow_figures-1",
                   "pink_figures-1","green_figures-1","gray_figures-1",
                   "orange_figures-1","dark_figures-1","purple_figures-1","gray_figures-1"]
    
    var showExtraSetUp = false
    var playerCount = 0
    var horseRaceBettingPlayer: [HorseBet] = []
    var games = [Game]()
    func getGames() -> [Game] {
        getChosenGameMode()
        games.removeAll()
        for game in gameModes {
            let mode = game.gameMode()
            let name = game.gameTitle()
            let description = game.gameDescription()
            let type = game.gameType()
            let gameImage = game.gameImage()
            let gameManagement = game.gameManagementView()
            let gameData = Game(id: "",
                                name: name,
                                description: description,
                                isSelected: false,
                                gameMode: mode,
                                gameType: type,
                                gameImage: gameImage,
                                gameManagement: gameManagement,
                                downloadsData: GamesDownloadingData.contains(mode))
            games.append(gameData)
        }
        return games
    }
    
    var battleGames = [Game]()
    func getBattleGames() -> [Game] {
        getBattleGameMode()
        battleGames.removeAll()
        for battleGamesItem in battleGameModes {
            let mode = battleGamesItem.gameMode()
            let name = battleGamesItem.gameTitle()
            let description = battleGamesItem.gameDescription()
            let type = battleGamesItem.gameType()
            let gameImage = battleGamesItem.gameImage()
            let gameManagement = battleGamesItem.gameManagementView()
            let gameData = Game(id: "",
                                name: name,
                                description: description,
                                isSelected: false,
                                gameMode: mode,
                                gameType: type,
                                gameImage: gameImage,
                                gameManagement: gameManagement,
                                downloadsData: GamesDownloadingData.contains(mode))
            battleGames.append(gameData)
        }
        return battleGames
    }
}
