//
//  GameManagement.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/3/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit
import MDCCommon

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
    case twentyOne = "twentyOne"
    case highNoon = "highNoon"
    case extremeChallenge = "ExtremeChallenge"
    case collectThings = "collectThings"
    case glassBreaker = "glassBreaker"
    case fastNumber = "fastNumber"
    case showMe = "showMe"
    
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
        case .twentyOne: return "GameTitle_twentyOne".localized()
        case .highNoon: return "GameTitle_highNoon".localized()
        case .extremeChallenge: return "GameTitle_ExtremeChallenge".localized()
        case .collectThings: return "GameTitle_CollectThings".localized()
        case .glassBreaker: return "GameTitle_glassBreaker".localized()
        case .fastNumber: return "GameTitle_fastNumber".localized()
        case .showMe : return "GameTitle_showMe".localized()
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
        case .twentyOne: return "GameDescription_twentyOne".localized()
        case .highNoon: return "GameDescription_highNoon".localized()
        case .extremeChallenge: return "GameDescription_ExtremeChallenge".localized()
        case .collectThings: return "GameDescription_CollectThings".localized()
        case .glassBreaker: return "GameDescription_glassBreaker".localized()
        case .fastNumber: return "GameDescription_fastNumber".localized()
        case .showMe: return "GameDescription_showMe".localized()
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
        case .twentyOne: return .twentyOne
        case .highNoon: return .highNoon
        case .extremeChallenge: return .extremeChallenge
        case .collectThings: return .collectThings
        case .glassBreaker: return .glassBreaker
        case .fastNumber: return .fastNumber
        case .showMe: return .showMe
        }
    }
    
    func gameType() -> (GameType,UIColor){
        switch self {
        case .trueOrFalse: return (.personalGame,.init(hexString: "#7FA1C3"))
        case .categories: return (.groupWinGame,.init(hexString: "#EE8F9C"))
        case .hajime: return (.groupWinGame,.init(hexString: "#EE8F9C"))
        case .everybodyDrinks: return (.personalGame,.init(hexString: "#7FA1C3"))
        case .wheelOfFortune:return (.groupLoseGame,.init(hexString: "#46BEA1"))
        case .upAndDown: return (.groupLoseGame,.init(hexString: "#46BEA1"))
        case .ringOfFire: return (.groupLoseGame,.init(hexString: "#46BEA1"))
        case .memory: return (.groupWinGame,.init(hexString: "#EE8F9C"))
        case .musicRecognizer: return (.personalGame,.init(hexString: "#7FA1C3"))
        case .switchHand: return (.groupWinGame,.init(hexString: "#EE8F9C"))
        case .rockPaperScissors: return (.groupWinGame,.init(hexString: "#EE8F9C"))
        case .fingerIt: return (.personalGame,.init(hexString: "#7FA1C3"))
        case .cheersToTheGovernor: return (.groupWinGame,.init(hexString: "#EE8F9C"))
        case .haveIEverNever: return (.groupLoseGame,.init(hexString: "#46BEA1"))
        case .whoAmI: return (.personalGame,.init(hexString: "#7FA1C3"))
        case .spoon: return (.groupWinGame,.init(hexString: "#EE8F9C"))
        case .thePeopleChoice: return (.personalGame,.init(hexString: "#7FA1C3"))
        case .russianRoulette: return (.personalGame,.init(hexString: "#7FA1C3"))
        case .shipTrip: return (.groupWinGame,.init(hexString: "#EE8F9C"))
        case .horseRace: return (.groupWinGame,.init(hexString: "#EE8F9C"))
        case .anagram: return (.personalGame,.init(hexString: "#7FA1C3"))
        case .coinFlip: return (.personalGame,.init(hexString: "#7FA1C3"))
        case .fiveThing: return (.personalGame,.init(hexString: "#7FA1C3"))
        case .collectAndBoom: return (.groupLoseGame,.init(hexString: "#46BEA1"))
        case .theBottle: return (.groupLoseGame,.init(hexString: "#46BEA1"))
        case .tapper: return (.personalGame,.init(hexString: "#7FA1C3"))
        case .tickTak: return (.groupLoseGame,.init(hexString: "#46BEA1"))
        case .twentyOne: return (.groupWinGame,.init(hexString: "#EE8F9C"))
        case .highNoon: return (.personalGame,.init(hexString: "#7FA1C3"))
        case .extremeChallenge: return (.groupLoseGame,.init(hexString: "#46BEA1"))
        case .collectThings: return (.personalGame,.init(hexString: "#7FA1C3"))
        case .glassBreaker: return (.personalGame,.init(hexString: "#7FA1C3"))
        case .fastNumber: return (.groupWinGame,.init(hexString: "#EE8F9C"))
        case .showMe: return (.groupLoseGame,.init(hexString: "#EE8F9C"))
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
        case .twentyOne: return TwentyOneView()
        case .highNoon: return HighNoonView()
        case .extremeChallenge: return ExtremeChallengeView()
        case .collectThings: return CollectThingsView()
        case .glassBreaker: return GlassBreakerView()
        case .fastNumber: return FastNumberView()
        case .showMe: return ShowMeView()
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
        case .twentyOne: return #imageLiteral(resourceName: "001-high-five.png")
        case .highNoon: return #imageLiteral(resourceName: "009-helping.png")
        case .extremeChallenge: return #imageLiteral(resourceName: "010-hug.png")
        case .collectThings: return #imageLiteral(resourceName: "038-pinky-promise.png")
        case .glassBreaker: return #imageLiteral(resourceName: "044-best-friends.png")
        case .fastNumber: return #imageLiteral(resourceName: "049-tree-house.png")
        case .showMe: return #imageLiteral(resourceName: "042-inner-circle.png")
        }
    }
    
    func gameScore() -> Int {
        switch self {
        case .trueOrFalse: return 1
        case .categories: return 3
        case .hajime: return 3
        case .everybodyDrinks: return 1
        case .wheelOfFortune: return 2
        case .upAndDown: return 2
        case .ringOfFire: return 2
        case .memory: return 3
        case .musicRecognizer: return 2
        case .switchHand: return 3
        case .rockPaperScissors: return 3
        case .fingerIt: return 1
        case .cheersToTheGovernor: return 0
        case .haveIEverNever: return 2
        case .whoAmI: return 2
        case .spoon: return 0
        case .thePeopleChoice: return 0
        case .russianRoulette: return 1
        case .shipTrip: return 0
        case .horseRace: return 2
        case .anagram: return 1
        case .coinFlip: return 1
        case .fiveThing: return 1
        case .collectAndBoom: return 2
        case .theBottle: return 2
        case .tapper: return 1
        case .tickTak: return 2
        case .twentyOne: return 3
        case .highNoon: return 1
        case .extremeChallenge: return 1
        case .collectThings: return 1
        case .glassBreaker: return 1
        case .fastNumber: return 3
        case .showMe: return 2
        }
    }
    
    func gameFun() -> Int {
        switch self {
        case .trueOrFalse: return 1
        case .categories: return 1
        case .hajime: return 1
        case .everybodyDrinks: return 1
        case .wheelOfFortune: return 1
        case .upAndDown: return 1
        case .ringOfFire: return 1
        case .memory: return 1
        case .musicRecognizer: return 1
        case .switchHand: return 1
        case .rockPaperScissors: return 3
        case .fingerIt: return 1
        case .cheersToTheGovernor: return 2
        case .haveIEverNever: return 2
        case .whoAmI: return 2
        case .spoon: return 2
        case .thePeopleChoice: return 2
        case .russianRoulette: return 2
        case .shipTrip: return 3
        case .horseRace: return 4
        case .anagram: return 5
        case .coinFlip: return 3
        case .fiveThing: return 3
        case .collectAndBoom: return 2
        case .theBottle: return 3
        case .tapper: return 4
        case .tickTak: return 3
        case .twentyOne: return 3
        case .highNoon: return 4
        case .extremeChallenge: return 2
        case .collectThings: return 2
        case .glassBreaker: return 3
        case .fastNumber: return 3
        case .showMe: return 4
        }
    }
    
    func extraOtpion() -> Bool {
        switch self {
        case .trueOrFalse: return true
        case .categories: return false
        case .hajime: return false
        case .everybodyDrinks: return false
        case .wheelOfFortune: return false
        case .upAndDown: return false
        case .ringOfFire: return false
        case .memory: return false
        case .musicRecognizer: return true
        case .switchHand: return false
        case .rockPaperScissors: return false
        case .fingerIt: return false
        case .cheersToTheGovernor: return false
        case .haveIEverNever: return false
        case .whoAmI: return true
        case .spoon: return false
        case .thePeopleChoice: return false
        case .russianRoulette: return false
        case .shipTrip: return false
        case .horseRace: return false
        case .anagram: return false
        case .coinFlip: return false
        case .fiveThing: return false
        case .collectAndBoom: return false
        case .theBottle: return false
        case .tapper: return false
        case .tickTak: return false
        case .twentyOne: return false
        case .highNoon: return false
        case .extremeChallenge: return false
        case .collectThings: return false
        case .glassBreaker: return false
        case .fastNumber: return false
        case .showMe: return false
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
    case personalGame = "personal"
    case groupWinGame = "winGroup"
    case groupLoseGame = "LoseGroup"
    case battleGame = "Kétszemélyes Játékok"
    static let allValues = [personalGame,groupWinGame,groupLoseGame,battleGame]
    
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
    
    var networkAvailable = false
    var gameDataLoaded = false
    
    func isOnboardingClosed() -> Bool {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.onboardingClosed) != nil
    }
    
    func firstRun() -> Bool {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.firstRunClosed) != nil
    }
    
    func playInfoRun() -> Bool {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.playInfo) != nil
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
    
    var allCategories = ["Amerikai Elnőkők","Feltalálok","Programozási kifejezések","Növényevő állatok","Tavak","Autó márkák","Már halott emberek","Olimpiai bajnokok","Játék szoftverek","Növények","Kutya Fajták","Alkohol márkák vagy fajta","Tv csatornák","Film","Zene","Sport","Gaming","Stand","Szépség","Hiresség","Természet","Utazás","Politika","Kaja","Űr","Telefon márka","közösségi Oldalak","Bankok","Tv Csatornák","Délamerika Országok","Afrikai Országok","Ázsiai Országok","Gyűmölcsők","Templomok","Ruha márka","kocsmák","kőltők","autó versenyzők","munkakőr","hangszer","konyhai eszközök","Társasjátékok","Szín","Egyetemek","Humoristák","Sorozat","Parkok","Fesztiválok"]

    var showMe = ["Traktor","Kocsi","Ház","Tégla","Evőeszkőz"]
    // everyBodyDrinks Onece
    var everyBodyDrinksPlayerCountIndex = 0
    
    var collectThings = ["WC papir","Töltő", "Hajszáritó", "Zokni", "Pénztárca","Power Bank","Korsó","Dárc nyil","Sapka", "Sár","Uszogumi","Ovszer","Kalapács"]
    
    var activityWordList = ["Ködlámpa","Faág","Éjjeliszekrény","Gondolatolvasás","esőkabát","túristajelzés","madártoll","téliálom","fenyőillat","Kenyérpirító","Családfa","Kutatócsoport","Rakott krumpli","Befőttesüveg","Villámcsapás","Elnökválasztás","Vízipóló","Aranyeső","Gumilabda","Madártej","Paprikajancsi","Tőkehal","Dobverő","Fűszál","Csínytevő","Konyhanyelv","Közellenség","Tejszínhab","Mestermű","Csavarhúzó","Egyirányú utca","Lakat","Satufék","függöny karnis","gondolatolvasó","Gyerekzár","Ruháskosár","Bundás kenyér","Bakkecske","Gyapjúszőnyeg","Babaágy","Selyemhernyó","Almafa","Borbély","Tükörtojás","Elemlámpa","Pásztorkutya","Széldzseki","Jobbkézszabály","Kerékpártároló","Kilométeróra","Körforgalom","Kulcstartó","Tricikli","Lemezlovas","Szolgasors","Ütvefúró","Szorítókötés","Önkritika","Fakír","Repülőtér","Költőpénz","Gyerekjáték","Borospince","Számlatömb","Tűznyelő","Lótetű","Fagyáspont","Télapó","Ádámkosztüm","Visszajátszás","Tojástartó","Távcső","Családtag","Alagút","Jelszó","Szivargyújtó","Varródoboz","Boroshordó","Micimackó","Csepűrágó","Metresz","Körív","Kőolaj","Odvas","Habarcs","Elakadásjelző hárömszög","Kanyarodási szabály","Benzingőz","Fapapucs","Világítótorony","Izzó","üggönykarnis","szobainas","gyökérkezelés","nagyothalló készülék","érintésvédelem","gyerekzár","vesepecsenye","kulturális sokk","munkásosztály","gondolatolvasás","számmisztika","kenyérpirító","családfa","kutatócsoport","szervkereskedelem","Kőolaj","Benzingőz","Gyerekzár","Rokkantkocsi","Ruháskosár","Bundáskenyér","Bakkecske","Gyapjúszőnyeg","Babaágy","Selyemhernyó","Kősó","Almafa","Bordélyház","Borbély","Tükörtojás","Elemlámpa","Pásztorkutya","Tüzifa","Ködlámpa","Faág","Éjjeliszekrény","Széndioxid","Gondolatolvasás","Kenyérpirító","Családfa","Kutatócsoport","Szervkereskedelem","Rakottkrumpli","Befőttesüveg","Villámcsapás","Elnökválasztás","Szövegláda","Vízipóló","Aranyeső","Gumilabda","Nadrágszíj","Szamártej","Madártej","Paprikajancsi","Tőkehal","Dobverő","Bélcsavarodás","Fűszál","Csínytevő","Konyhanyelv","Közellenség","Lemezlovas","Országház","Szolgasors","Ütvefúró","Szorítókötés","Önkritika","Fakír","Repülőtér","Költőpénz","Gyerekjáték","Borospince","Számlatömb","Agydaganat","Tűznyelő","Cimbalomverő","Lótetű","Fagyáspont","Ügyvezető","Télapó","Ádámkosztüm","Visszajátszás","Tojástartó","Távcső","Családtag","Imakönyv","Öregasszony","Alagút","Jelszó","Hullámsír","Tökfödő","Szivargyújtó","Varródoboz","Boroshordó","Fuvarlevél","Tejszínhab","Mestermű","Takarékláng","Vékbélkúp","Bukósisak","Csavarhúzó","Durrdefekt","Egyirányú utca","Gyalogátkelőhely","Lakat","Láncolaj","Láthatósági mellény","Macskaszem","Pótgumi","Satufék","Sebességváltó","Széldzseki","Jobbkézszabály","Kerékpártároló","Kilométeróra","Körforgalom","Kulcstartó","Szelepsapka","Tricikli","Bohóc","Ádámcsutka","Ágytál","Akupunktúra","Akvárium","Állatkert","Antikrisztus","Nyálgombóc","Bakancslista","Bajuszfésű","Banyakemence","Bárányhimlő","Bélpoklos","Gumibogyószörp","Nyálbuborék","Csirkefogó","Dobostorta","Dohánylevél","Húsgombóc","Gitárhúr","Csokigolyó","Göncölszekér","Világháború","Hangverseny","Hattyúdal","Hidegvér","Mellimplantátum","Injekcióstű","Kávébab","Cserépkályha","Katasztrófafilm","Kígyóméreg","Konzervnyitó","Koporsószeg","Korcsolyapálya","Kocsmabútor","Kürtőskalács","Sírásó","Malacfarok","Marslakó","Botmixer","Mogyoróhéj","Mózeskosár","Napraforgó","Négykézláb","Nyúlfarok","Oroszlánszelídítő","Ökörszem","Pápaszem","Pingpongasztal","Olajradiátor","Retekláda","Rókalyuk","Csipkerózsika","Rongybaba","Hétfejű sárkány","Selyemgubó","Sípcsont","Sóbánya","Szerencsevadász","Tábortűz","Űrtartalom","Víztaszító","Sírkő","Tyúkszem","Ugrálóvár","Üvegtigris","Vámpírfog","Zabhegyező","Bowden","Bukósisak","Csavarhúzó","Durrdefekt","Egyirányú utca","Első lámpa","Folyadékpótlás","Gyalogátkelőhely","Hasra esik","Hátsó lámpa","Hegyi kerékpár","Jobbkézszabály","Kerékpártároló","Kerékpárút","Kilométeróra","Királydinnye","Körforgalom","Kulacstartó","Küllő","Lakat","Láncolaj","Lassú defekt","Láthatósági mellény","Ledobja a láncot","Macskaszem","Pótgumi","Satufék","Sebességváltó","Széldzseki","Szelepsapka","Szerelőkészlet","Tárcsafák","Tour de France","Tricikli","Verseny kerékpár"]
    
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
    func setAllGameModes() {
        gameModes = [
            GameMode.categories,
            GameMode.trueOrFalse,
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
                     //GameMode.spoon,
                     //GameMode.thePeopleChoice,
                     GameMode.russianRoulette,
//                     GameMode.shipTrip,
                     GameMode.horseRace,
                     GameMode.anagram,
                     GameMode.coinFlip,
                     GameMode.fiveThing,
                     GameMode.collectAndBoom,
                     GameMode.theBottle,
                     GameMode.tapper,
                     GameMode.tickTak,
                     GameMode.twentyOne,
                     GameMode.highNoon,
                     GameMode.extremeChallenge,
                     GameMode.collectThings,
                     //GameMode.glassBreaker,
                     GameMode.fastNumber,
                     GameMode.showMe
        ]
    }
    
    
    
    var gameStarted = false
    var isSpactate = false
    var selectedMode = 0
    var selectedSpac = 0
    var online = true
    var drininkCounterView : Bool = true
    var showExtraSetUp = false
    
    
    
    var horseRaceBettingPlayer: [HorseBet] = []
    
    
    
    var games = [Game]()
    func getGames() -> [Game] {
        setAllGameModes()
        games.removeAll()
        for game in gameModes {
            let mode = game.gameMode()
            let name = game.gameTitle()
            let description = game.gameDescription()
            let type = game.gameType()
            let gameImage = game.gameImage()
            let gameScore = game.gameScore()
            let gameManagement = game.gameManagementView()
            let gameFun = game.gameFun()
            let extraOption = game.extraOtpion()
            
            let gameData = Game(id: "",
                                name: name,
                                description: description,
                                isSelected: false,
                                gameMode: mode,
                                gameType: type.0,
                                gameTypeColor: type.1,
                                gameImage: gameImage,
                                gameManagement: gameManagement,
                                downloadsData: GamesDownloadingData.contains(mode),
                                addedScore: gameScore,
                                funIndex:gameFun,
                                extraOption: extraOption)
            games.append(gameData)
        }
        return games
    }
}
