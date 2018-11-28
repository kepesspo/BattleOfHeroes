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
    var songTrackIDList = ["27AHAtAirQapVldIm4c9ZX",
                           "5c4tB0saSkNHX5CyDosuF7",
                           "26eZSJp30jI0aPdpQL55xC",
                           "6naxalmIoLFWR0siv8dnQQ",
                           "1q7VPiBFlBF7PMtmI6mWyM",
                           "0p34Y0tZFOvG3UpZQizOzv",
                           "2771LMNxwf62FTAdpJMQfM",
                           "0Qt4s6DQlOsdhNW64DkZK3",
                           "400QEuv1HXJcm7gGSya4fn",
                           "547GSUncZG09Bvfd8s0Cmy",
                           "6RnkFd8Fqqgk1Uni8RgqCQ",
                           "344jzKdBGLJYZdhKjj4884",
                           "4abEcEslcRjBS6xSZh9naQ",
                           "3nHH210MdVkYnt6oe2D7aW",
                           "1LhtEsd3PtVqrCanRgBpUM",
                           "1di1BEgJYzPvXUuinsYJGP",
                           "6KPMiBhU6O9RBImTQXQNCe",
                           "2vlgOAH3M8Fmo19wOjeRyw",
                           "2ekn2ttSfGqwhhate0LSR0",
                           "2Gl0FzuLxflY6nPifJp5Dr",
                           "6FzjJPwf5JzzFOei7h6Qrp",
                           "5tJjo5JDF9zhzYD7yQfATH",
                           "1vxw6aYJls2oq3gW0DujAo",
                           "3CRDbSIZ4r5MsZ0YwxuEkn",
                           "0E9ZjEAyAwOXZ7wJC0PD33",
                           "0FE9t6xYkqWXU2ahLh6D8X",
                           "7wMq5n8mYSKlQIGECKUgTX",
                           "7vFoFDWqTX0mHzLfrF1Cfy",
                           "4VrWlk8IQxevMvERoX08iC",
                           "2Foc5Q5nqNiosCNqttzHof",
                           "3U4isOIWM3VvDubwSI3y7a",
                           "2Cd9iWfcOpGDHLz6tVA3G4",
                           "41Fflg7qHiVOD6dEPvsCzO",
                           "32OlwWuMpZ6b0aN2RZOeMS",
                           "58zsLZPvfflaiIbNWoA22O",
                           "4esOae7i4rqTbAu9o5Pxco",
                           "0ifSeVGUr7py5GggttDhXw",
                           "48td6xvpokdYwvbl3JIiXP",
                           "6b3b7lILUJqXcp6w9wNQSm",
                           "7py16W5fWYLFFS6BElKAjn",
                           "4BggEwLhGfrbrl7JBhC8EC",
                           "0Ph6L4l8dYUuXFmb71Ajnd",
                           "57bgtoPSgt236HzfBOd8kj",
                           "1eDWNWA7Lf41KXfk0RRmkC",
                           "5FR54UnizyI8pE5E9Zb0Dt",
                           "6hvFrZNocdt2FcKGCSY5NI",
                           "6dWqHAuGLmsjvUxOe9S2t6",
                           "4Cy0NHJ8Gh0xMdwyM9RkQm",
                           "64IL0ZrOV7F6BDPm5fhfUa"    ,
                           "4rzfv0JLZfVhOhbSQ8o5jZ"    ,
                           "3FhNJaCNypOAnZccdYGAWN"    ,
                           "7GmHOAdriOnI9s5S79GAUr"    ,
                           "5kNYGyPkorBykxgUE6EL1X"    ,
                           "49X0LAl6faAusYq02PRAY6"    ,
                           "3mZjcZH6CEp4YBm7iz3P7l"    ,
                           "4eZO97RGFo7IN6gm24Nv0S"    ,
                           "5qTvkDrSfvwDv6RBjjcfQr"    ,
                           "440JHgcmlgu65MbKBg20ba"    ,
                           "5S8EZuiSNFR2N5eG58oISQ"    ,
                           "7jley98gCQFueQ5MCaFWIb"    ,
                           "2GYHyAoLWpkxLVa4oYTVko"    ,
                           "0eAvGqc9t4Wuc6gDcSi5Aa"    ,
                           "6fgbQt13JlpN59PytgTMsA"    ,
                           "4bJygwUKrRgq1stlNXcgMg"    ,
                           "1Le4SDanBrX8OtmnnyTNrh"    ,
                           "0k2GOhqsrxDTAbFFSdNJjT"    ,
                           "3oobWqIgYrSRg18uqRuPIF"    ,
                           "3ZOEytgrvLwQaqXreDs2Jx"    ,
                           "0bXpmJyHHYPk6QBFj25bYF"    ,
                           "2J2hVpwVV25EK8Bvd3OgCK"    ,
                           "1hEh8Hc9lBAFWUghHBsCel"    ,
                           "6ZLGthToczpvnL5Eoy6yrY"    ,
                           "2Ms33RTRCT6gArrpcrPxmo"    ,
                           "172u95XX2JxIfBZi1v0vKN"    ,
                           "2c3sKqWYVJ0NsE3elgRhKH"    ,
                           "0gPQTLaqHDgdupKEok7J2x"    ,
                           "3RmKpob8xzv1pzHEQrMJah"    ,
                           "4bz7uB4edifWKJXSDxwHcs"    ,
                           "3aw9iWUQ3VrPQltgwvN9Xu"    ,
                           "75lRRdjplzfpmBjNzMPyjR"    ,
                           "4N6R6yqkFUTyF3AYOdR0T7"    ,
                           "0I3q5fE6wg7LIfHGngUTnV"    ,
                           "4WY3HyGXsWqjFRCVD6gnTe"    ,
                           "2Y6CA1HAZjwPxBL8EZjwUW"    ,
                           "65o8SI1kfFAIr0EjXeBRkB"    ,
                           "1Ov4E4nE7E0yzeqpbhEE5g"    ,
                           "5JemkdKwXNsNnogI0Mg0ZZ"    ,
                           "5BSclXJTa9B0iURhUjZo50"    ,
                           "5D2mYZuzcgjpchVY1pmTPh"    ,
                           "3e9L9HiHKcfYLAga28Vmcf"    ,
                           "4Sdjsnfimz0DCYhbI35uoz"    ,
                           "6jEZLz3YpnEBRpVkv35AmP"    ,
                           "2lnzGkdtDj5mtlcOW2yRtG"    ,
                           "7dyluIqv7QYVTXXZiMWPHW"    ,
                           "0k25PBFQ8QUJcvqoQL27hk"    ,
                           "5MF62bkZ7Uy3UxteONmUBV"    ,
                           "2WRFD9WczJ975X2K1Y9YVs"    ,
                           "7FxmsmphMyy09gdqGHeqFC"    ,
                           "2QsZVnbWVSjKMXK6K3uRBL"    ,
                           "1xNcBAoUw8Hz6LqK2jt4Ff"    ,
                           "4ZrEjG3Vef85NTve8ptC9Q"    ,
                           "2Mpj1Ul5OFPyyP4wB62Rvi"    ,
                           "7FWuzwapuKHTEyDJIcQOw3"    ,
                           "7iL6o9tox1zgHpKUfh9vuC"    ,
                           "7Lf7oSEVdzZqTA0kEDSlS5"    ,
                           "70VjMtwhm3Q2HBQeJnPfmh"    ,
                           "3EDS89HeAhHiZKlljciK0a"    ,
                           "7bVeIwMoakhx9SzB0NMn98"    ,
                           "2Ozc0me9PV5vlt8cokwdvI"    ,
                           "6W2Ef5Ph6ILTUAedoQ3QIv"    ,
                           "3y4KY2HvTEkFLrkHfIPWAl"    ,
                           "45sdD9GjryujVOcRJ4YQRQ"    ,
                           "3afv9TL8ixr4T9VbiKnrwe"    ,
                           "0ijhkvBpA7OBlY4clWSUZw"    ,
                           "5FQ2oC15Omm9sdBZVQTPjw"    ,
                           "16MJqq0vEuW6GRX6faetTm"    ,
                           "1RKUoGiLEbcXN4GY4spQDx"    ,
                           "60a0Rd6pjrkxjPbaKzXjfq"    ,
                           "7JKEA8xYDoFp4q0QBW2PGg"    ,
                           "3E7ZwUMJFqpsDOJzEkBrQ7"    ,
                           "1OutzYv6YiN93lrT3pJsWR"    ,
                           "6Sy9BUbgFse0n0LPA5lwy5"    ,
                           "2nLtzopw4rPReszdYBJU6h"    ,
                           "2cTOee6bTauDFK1QuDS1BD"    ,
                           "5zflsn7VI8qyvzrowMoTgF"    ,
                           "5eek2X5459T1HoYJk2CKXv"    ,
                           "7BXToqZFtclAj6mshYWena"    ,
                           "4TsmezEQVSZNNPv5RJ65Ov"    ,
                           "76MdMwQ4yiw1wIbA16sOrA"    ,
                           "497Fkp3gRiGrRMoqBTDudr"    ,
                           "6zsk6uF3MxfIeHPlubKBvR"    ,
                           "7kwiwQhWRBSP1PJv4ZFJUK"    ,
                           "0d28khcov6AiegSCpG5TuT"    ,
                           "0F2BxpbxH8Yc3pLub48hrb"    ,
                           "70ludZZEUJy1aFVkPI0Kpi"    ,
                           "2Za2mUwmQoSxWPscaY2vxl"    ,
                           "6bS7DqTuzrpkluB7boWmw2"    ,
                           "10Nmj3JCNoMeBQ87uw5j8k"    ,
                           "3kZoay4ANo86ehb6s4RwS9"    ,
                           "7LK7dQtymjmIBM8O7wSeTp"    ,
                           "6ZyNjT2hYvfV5PuW84dp1E"    ,
                           "4oY2T9ur7Ll5b2kpBlcWcb"    ,
                           "6rxEjkoar48SssZePbtb2x"    ,
                           "18lq8FwQ94jlSk95PTM7Mr"    ,
                           "4NeOWqHmlrGRuBvsLJC9rL"    ,
                           "4y6c5vMzKKM3KsMbHtjKx5"    ,
                           "1vcxF91pWs9uNwDROuiCPB"    ,
                           "5W3cjX2J3tjhG8zb6u0qHn"    ,
                           "7f1Dmr246cJ9uQYdbplTbh"    ,
                           "4ZCLM74MYhUy80TPiaAuee"    ,
                           "2aEuA8PSqLa17Y4hKPj5rr"    ,
                           "3BZGi1yUqQyCNC868AqUGG"    ,
                           "77nF1t4qesuOJRd8lbIzNX"    ,
                           "1bki22ZoLCkqb0QIJ5PtJF"    ,
                           "29wJiSQcze8HEmxkUQykyp"    ,
                           "5zWZ9iNevP0397xB3jWV2z"    ,
                           "0GGxVTb0UwDwdaKNjBdCn3"    ,
                           "2V2pxcEfn5zs79sE7qcewA"    ,
                           "1NCuYqMc8hKMb4cpNTcJbD"    ,
                           "480dDrqG7LO6qDaphHeXlM"    ,
                           "3G0ENKW9vzV0SuYKaWFflI"    ,
                           "6miUySWi347iIJyz7ETo6m"    ,
                           "3Z2tPWiNiIpg8UMMoowHIk"    ,
                           "1db0gbTSKdRQum8VlbNkiO"    ,
                           "2EnZ9bpgUtLgKkRFehp8xS"    ,
                           "0e3yhVeNaTfKIWQRw9U9sY"    ,
                           "4QT3YKobBj4BI7xCYRLr9u"    ,
                           "4LFwNJWoj74Yd71fIr1W8x"    ,
                           "41Laec0pItedzpw2D8HWYp"    ,
                           "1eyq8cjUQ2daFthW2PC2GM"    ,
                           "6JNJERZGJwDVgkmbohBw7u"    ,
                           "6wpGqhRvJGNNXwWlPmkMyO"    ,
                           "07ABETRdek3ACMpRPvQuaT"    ,
                           "1cy5US2dffz6QGBAIzOGkq"    ,
                           "36lkJSDyMEZoWTqtRj8Q8q"    ,
                           "63nVsCAdxu9OdeRhe58wiE"    ,
                           "78TnMTAFmWUWWCgNXR7D3K"    ,
                           "65vEK65KeqeH11s3Ym8BWO"    ,
                           "7DFawVSjI88xR9mjnWwURg"    ,
                           "0LIEDX1qDrcsFbWCUsYJmR"    ,
                           "0IWtEFQBwRHaMXZQtGEVcM"    ,
                           "6sn3FHCq2csvNkq2h9Au8V"    ,
                           "7blHIRcL3J68cOZx1zpGHh"    ,
                           "42l1eOB0qSkTxHdEZEhqem"    ,
                           "1JLn8RhQzHz3qDqsChcmBl"    ,
                           "4rcHWl68ai6KvpXlc8vbnE"    ,
                           "2oiMNaVCul7qmMzpRStjCg"    ,
                           "0ZfM5XfJTtFPhOxAERRnNY"    ,
                           "0k7UryJJnIcGkdgnXIpE2K"    ,
                           "4S1VYqwfkLit9mKVY3MXoo"    ,
                           "0qi4b1l0eT3jpzeNHeFXDT"    ,
                           "19wadMw1A8XejDV4p5wMt1"    ,
                           "6xepovPqjvrkEw9Y5AMmTm"    ,
                           "0GTK6TesV108Jj5D3MHsYb"    ,
                           "05fHQeRbCSjKVS6z0WbQKJ"    ,
                           "1GeNWyZtCHbcp3ZWp8GTOO"    ,
                           "3wfujdbamR3Z46F4xav7LM"    ,
                           "0YMFcrMtBowDdD5bPz0cgy"    ,
                           "2R7858bg0GHuBBxjTyOL7N"    ,
                           "4ZpXHlV2vQVfPXUvbDSZ92"    ,
                           "0kzSooCGpuphLwn8iTuO9h"    ,
                           "2x45xqISlmmDJqxOqr8BuS"    ,
                           "7Ewz6bJ97vUqk5HdkvguFQ"    ,
                           "18AXbzPzBS8Y3AkgSxzJPb"    ,
                           "0qgrrDnUUhyxpxbBznUnzg"    ,
                           "0YPXkQthLWrhNGoKTbwCJ8"    ,
                           "65E62rOSbm7SZbAMYjNTJq"    ,
                           "5vmRQ3zELMLUQPo2FLQ76x"    ,
                           "7tLtIZclwLWk54PFAyDv5T"    ,
                           "6HA97v4wEGQ5TUClRM0XLc"    ,
                           "0Z7O8GMQShj9TJrm2yX1R6"    ,
                           "0tKjVEJlX3IZ5L1rEJc5hh"    ,
                           "7INi4pMPG4IE0Smx5y4KVf"    ,
                           "2yzPBlE5UXK2sqvnNM9QQ0"    ,
                           "3nQuDlaVZApyrG6tdsETe0"    ,
                           "3fVSMbeq8tY3G85yxcJwRU"    ,
                           "0CzeAbfKFnxnWjwo5iYiCG"    ,
                           "3ir8K4Cba553mOjsl8ZCJ0"    ,
                           "1h22h211rde6dDCeW2hXpN"    ,
                           "41OIyMJsSFMjdjZjL4tHEx"    ,
                           "0Cp7pkYwl4WCGRHhrfcsrg"    ,
                           "1RSy7B2vfPi84N80QJ6frX"    ,
                           "6eDYgjKl4vUgRusxb7THDu"    ,
                           "3lIpkjFnRxJ6Uvm8DgtgfV"    ,
                           "7FwBtcecmlpc1sLySPXeGE"    ,
                           "45r7mbXRbpFAYZavAoX6tk"    ,
                           "5WwqdeavrQrbeAMDxGawse"    ,
                           "2PFIZFcGry0po3ZfRZkzKc"    ,
                           "04N18CfIbOJPnVLGOKgJNB"    ,
                           "1QLyDdhB9gmxbGv0K1kFyT"    ,
                           "5MoDQWMDMaAGDEiWsJfeCi"    ,
                           "3RMeOetCdXttthQK0clPuz"    ,
                           "1YQCRXscu8xE74BVVMUCRr"    ,
                           "1Qrdlkgg9I4J7r3P4kZNwr"    ,
                           "57bgtoPSgt236HzfBOd8kj"    ,
                           "4cVHMHgmWgudD399ZdhQ3L"    ,
                           "7HKez549fwJQDzx3zLjHKC"    ,
                           "4gvea7UlDkAvsJBPZAd4oB"    ,
                           "6PMDILZiYo4YzMBbE0dGK9"    ,
                           "4d6eqRtpDX7tydHJGDZUBQ"    ,
                           "5hRXW7bDPwj08jTI74N3gg"    ,
                           "7aS418hRnOnYrXeyrZilwk"    ,
                           "5C0LFQARavkPpn7JgA4sLk"    ,
                           "17CPezzLWzvGfpZW6X8XT0"    ,
                           "5dRQUolXAVX3BbCiIxmSsf"    ,
                           "6VQyQHqEiDLG5cAPjoBPL9"    ,
                           "24K5er7fAl8bNeF5H8nMAU"    ,
                           "5RGpMPjCdBdPxznDurjijE"    ,
                           "0Uqs7ilt5kGX9NzFDWTBrP"    ,
                           "4ih3dyFZoeTdaeJW9mPbOI"    ,
                           "0JXXm3RqxU8EKzX4P8M0n3"    ,
                           "4xGuK7FsXuZwHCCuNnPzbD"    ,
                           "3ldG6XCLDXxWg1N6XhrSKo"    ,
                           "79RUMZfMNMpqZnswovvTqv"    ,
                           "4V5m0jq1GnOl9R6MT2rcRj"    ,
                           "1H5VQuShs4qfwBXyHF0PeH"    ,
                           "2wz5weI4PREzpexKfrKgwv"    ,
                           "1poBO3pO6fkqPYG6n8J5cX"    ,
                           "71Cid4UeolaHRzdbmMDAVb"    ,
                           "4XZwpHpscrMkbpQPqjnwRJ"    ,
                           "6HdM7gzXVgcpepv276raog"    ,
                           "6hkdMs3DqEdG0rIkhvB9oC"    ,
                           "3Q8PSzpMJknr3rzuVwDYrR"    ,
                           "3UPBOL5UtCZmJRwioMkfLD"    ,
                           "12BbMJsJi65mxneq6c9Lm7"    ,
                           "4RADreHMvMkZwsPgPr9z5c"    ,
                           "3QRM0qZB7oMYavveH0iEqx"    ,
                           "5jVJAojK3LFKETjI2gYb8O"    ,
                           "4UutvpXhqzToPI8oNc4C2F"    ,
                           "6WK9dVrRABMkUXFLNlgWFh"    ,
                           "1kTuAuDVotqoGiUEKpbxHH"    ,
                           "3vZO25GdYuqFrR1kzZADnp"    ,
                           "221LRlPHPuevgE1tuUlof9"    ,
                           "1di1BEgJYzPvXUuinsYJGP"    ,
                           "48UPSzbZjgc449aqz8bxox"    ,
                           "5PQmSHzWnlgG4EBuIqjac2"    ,
                           "7tHYA0eEH6dAAzMurBNvT9"    ,
                           "3QHONiXGMGU3z68mQInncF"    ,
                           "6lbme14HiDWYmGiw1I2Dv6"    ,
                           "6PwbVXIomkvk4YcafiOc6i"    ,
                           "4sutLmjkVKRN6pOAMo2joC"    ,
                           "0hrBpAOgrt8RXigk83LLNE"    ,
                           "0ofMkI3jzmGCElAOgOLeo3"    ,
                           "3u5N55tHf7hXATSQrjBh2q"    ,
                           "5QRAfvKPyQpwt897Jc0glg"    ,
                           "0nLiqZ6A27jJri2VCalIUs"    ,
                           "24fQpRwKFkC3Fe8QtvvrNw"    ,
                           "4QOXPy2nuInZBz4wXQqpEv"    ,
                           "1EM23A621Z0QyTlWKu7T1l"    ,
                           "4fXGWiVhlOLdhwRDP6pIFG"    ,
                           "4IYKjN1DrYzxKXt0umJqsG"    ,
                           "4fBkJ3DTCPKWUBBAtMdimK"    ,
                           "4wYCe9tSmUolNU4WmJKbZy"    ,
                           "029l68p4fPYZeAgJ5c60zR"    ,
                           "62R1MRux3R0v2cngA2xdJn"    ,
                           "6L89mwZXSOwYl76YXfX13s"    ,
                           "2ahnofp2LbBWDXcJbMaSTu"    ,
                           "3d9DChrdc6BOeFsbrZ3Is0"    ,
                           "31bf9SEOppLU6lQ85d8om6"    ,
                           "31AOj9sFz2gM0O3hMARRBx"    ,
                           "1Dr1fXbc2IxaK1Mu8P8Khz"    ,
                           "3ovjw5HZZv43SxTwApooCM"    ,
                           "3WSyYBhLZRLbQo2tJgFvSR"    ,
                           "6qlpXtA29VcxCNgLWR5IWx"    ,
                           "1f3yAtsJtY87CTmM8RLnxf"    ,
                           "72qwRwnHNGCnn8sFlVOwr4"    ,
                           "3x4yV0hW5Ve3TKhFkXSqFn"    ,
                           "6EsBn1Md8C5YdbCzvwvZq8"    ,
                           "40B86SINGhkk1T0kZ47JsX"    ,
                           "3ptdPgclNeffhYA0aY1Nw7"    ,
                           "6sHsXIJoEN5JpdkGMQDJxt"    ,
                           "69mFxANpGyq9s69LqH3d9G"    ,
                           "3zjZaGqcepRo80Btq4C1x0"    ,
                           "0MKGH8UMfCnq5w7nG06oM5"    ,
                           "5LGqFIVBf3ZUeFBpc87CFS"    ,
                           "2LjiPAQOVazT8sRyXL3XRs"    ,
                           "65OXGbKBQ8gUyJvUd0jNpf"    ,
                           "76D5nfZbYzZYfUZKGy73jy"    ,
                           "47TqCCnEliDp8NRDyIQoQq"    ,
                           "4BggEwLhGfrbrl7JBhC8EC"    ,
                           "57iDDD9N9tTWe75x6qhStw"    ,
                           "3ixTiPABjqkBKPocxq6oIe"    ,
                           "1M2nd8jNUkkwrc1dgBPTJz"    ,
                           "0smyCrJiibi2uwCiq5R1vj"    ,
                           "6e8Ou0wiqAzIpWb2eSxll8"    ,
                           "18fr7t1FKDUiOg8DXxiZwL"    ,
                           "0U9TKK9GYryei6Vn45TEdH"    ,
                           "6XQz4HwNIQZ652JFa7putY"    ,
                           "3XKIUb7HzIF1Vu9usunMzc"    ,
                           "7woW97CfcWaKtuC6W5BP2K"    ,
                           "2IZZqH4K02UIYg5EohpNHF"    ,
                           "4wtR6HB3XekEengMX17cpc"    ,
                           "1Q0p30HuN1ADMX2CmPzIvO"    ,
                           "3MjUtNVVq3C8Fn0MP3zhXa"    ,
                           "4ACxa9buEUnOdYEoPcnMpi"    ,
                           "4EchqUKQ3qAQuRNKmeIpnf"    ,
                           "6ZLGthToczpvnL5Eoy6yrY"    ,
                           "6J6RWKCPN5RFKHUKEUFjxS"    ,
                           "4yCaS5irbjklpxuMqcGYqo"    ,
                           "0AQHfKjzky28rf5ytfBANJ"    ,
                           "5EYdTPdJD74r9EVZBztqGG"    ,
                           "6jUyYHDikmw9WltPojSR37"    ,
                           "6e40mgJiCid5HRAGrbpGA6"    ,
                           "1UI0l2L66HJ9AtoEOlHzv4"    ,
                           "2syWojRQnAHSAEG8YbcdlV"    ,
                           "3a9TMd2Yrza6HXqqlfMtfy"    ,
                           "5StvAhgmgCOpCPHHNfS8bx"    ,
                           "7EVk9tRb6beJLTHrg6AkY9"    ,
                           "6YZdkObH88npeKrrkb8Ggf"    ,
                           "45sGyAtAxD6efaN0bJAFgh"    ,
                           "4Jv7lweGIUOFQ7Oq2AtAh9"    ,
                           "6kBXZ8j8IuJeRjb6kV6fol"    ,
                           "46NBoIAHrmR7qcUGCIFEjR"    ,
                           "1A8j067qyiNwQnZT0bzUpZ"    ,
                           "5tf1VVWniHgryyumXyJM7w"    ,
                           "5TW4B4Bh0NREh2gPWAn4fM"    ,
                           "3JvKfv6T31zO0ini8iNItO"    ,
                           "5YPMEOJ58kfl56VHxTgwx3"    ,
                           "2qwifa9QMCecIjrUCTguLP"    ,
                           "1pjvlYOMIg1NhGQbM6iwrY"    ,
                           "6b3b7lILUJqXcp6w9wNQSm"    ,
                           "13qqdlSeF8FcxsRyapDMZ0"    ,
                           "7nKBxz47S9SD79N086fuhn"    ,
                           "0rHVd8h0cFwgLgPFem6S60"    ,
                           "0DBTrH6kBbF8CzNVcu5MQR"    ,
                           "61UQzeiIluhpzpMdY4ag3q"    ,
                           "6RwUhWOoRECbpM9FBh13Z2"    ,
                           "4J7CKHCF3mdL4diUsmW8lq"    ,
                           "3RiPr603aXAoi4GHyXx0uy"    ,
                           "5fnA9mkIfScSqHIpeDyvck"    ,
                           "7gHs73wELdeycvS48JfIos"    ,
                           "0R11Ilma4jIB5LrM7XwWXC"    ,
                           "3Uoe0ZdEy9lLrXj1HhXx9H"    ,
                           "2CPqh63wRVscbceKcPxwvv"    ,
                           "1rIKgCH4H52lrvDcz50hS8"    ,
                           "5aJhuze13LOoLthmiG8YIA"    ,
                           "4I2ENHg65RuKifEHdD0kMu"    ,
                           "6IQPONuERifb4i4Syhmbq6"    ,
                           "1ixphys4A3NEXp6MDScfih"    ,
                           "2RhKxrhti1jd1Krzh968Cb"    ,
                           "51tUT1gHE30GQPhn1agudM"    ,
                           "6oJflQkp7lFXOQce4wPTAW"    ,
                           "1Nivqu7wynKsgguBmgC6Vw"    ,
                           "2Foc5Q5nqNiosCNqttzHof"    ,
                           "3c8iiZGfEammKJuWTErE5x"    ,
                           "1rFMYAZxBoAKSzXI54brMu"    ,
                           "57Em2VvHxGlN9bLtfRIsg4"    ,
                           "2KrHwwnKAfSDdOStftigJm"    ,
                           "78zc6DT7A2ccehmIqef9mT"    ,
                           "22mek4IiqubGD9ctzxc69s"    ,
                           "5Sf3GyLEAzJXxZ5mbCPXTu"    ,
                           "1cm7v7dBQDjewVTYlqjUX6"    ,
                           "6KZmDucZFfvxGJkrHInbix"    ,
                           "1zi7xx7UVEFkmKfv06H8x0"    ,
                           "2iJuuzV8P9Yz0VSurttIV5"    ,
                           "1I8tHoNBFTuoJAlh4hfVVE"    ,
                           "7o1Pm9jpH0wFpN5g793Lnq"    ,
                           "3jPp0oUSbkvB34xMZ74R0h"    ,
                           "5MhsZlmKJG6X5kTHkdwC4B"    ,
                           "5nIrdpo8eXQU3YgZelEXkd"    ,
                           "46aIq2GKW7Vr6i4g2Vvycd"    ,
                           "0gb1J5UrTpzaU1s3nupgCd"    ,
                           "63CSozvYUEudPp12679UVF"    ,
                           "4qqArAiTPueDxIp7cf87h7"    ,
                           "412luShbmlgqqgYFStIB1s"    ,
                           "4q6dqyGM25sKFU8nYAGRe4"    ,
                           "6k1I9gABiasGZiWWAosAEb"    ,
                           "0tDC3KJPPu5eonGTtCURpq"    ,
                           "6ksRossV4vKsXntCCZbhaM"    ,
                           "69zxj1EFDfAouZu9JDmQld"    ,
                           "3nhmni2lW0t0eVBXEQAAyF"    ,
                           "1QIH1q9WuS64eVIOSfcByA"    ,
                           "2YWjW3wwQIBLNhxWKBQd16"    ,
                           "1oHxIPqJyvAYHy0PVrDU98"    ,
                           "023H4I7HJnxRqsc9cqeFKV"    ,
                           "275a9yzwGB6ncAW4SxY7q3"    ,
                           "591nHHHzZl1NLt9PMKpinM"    ,
                           "52gvlDnre9craz9dKGObp8"    ,
                           "0azC730Exh71aQlOt9Zj3y"    ,
                           "4VTRlB4KVaNfm7ZbMOKLNT"    ,
                           "0JiVRyTJcJnmlwCZ854K4p"    ,
                           "1HOlb9rdNOmy9b1Fakicjo"    ,
                           "69uxyAqqPIsUyTO8txoP2M"    ,
                           "3MOECVkNshqHYTPt5DZcdN"    ,
                           "2FiSTH0GYpIioUgjfzMIja"    ,
                           "4b2tcjrG1qUkSdsqEFP2dB"    ,
                           "3BE0getU08uXas8ZjULABA"    ,
                           "0VgkVdmE4gld66l8iyGjgx"    ,
                           "0e7ipj03S05BNilyu5bRzt"    ,
                           "7KM7AeGDIWKxrMN7E4ljRA"    ,
                           "0vbtURX4qv1l7besfwmnD8"    ,
                           "5UqCQaDshqbIk3pkhy4Pjg"    ,
                           "16Ah4QqH4mgYVXqfC4mdSd"    ,
                           "0k6DnZMLoEUH8NGD5zh2SE"    ,
                           "30BsewEJZPxfuLNAlZPFje"    ,
                           "05SBRd4fXgn8FX7bf8BCAE"    ,
                           "0wsXdby1T3PWLauIkGUZzg"    ,
                           "5knuzwU65gJK7IF5yJsuaW"    ,
                           "72TFWvU3wUYdUuxejTTIzt"    ,
                           "4VrWlk8IQxevMvERoX08iC"    ,
                           "1vvNmPOiUuyCbgWmtc6yfm"    ,
                           "1qFEiLRxy0ydnbnzrrqDJO"    ,
                           "6no1mklq4BJBg7KJ6Dly7N"    ,
                           "0lYBSQXN6rCTvUZvg9S0lU"
        
]
    
    
    
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
