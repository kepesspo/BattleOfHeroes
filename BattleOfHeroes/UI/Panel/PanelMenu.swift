//
//  PanelMenu.swift
//  BattleOfHeroes
//
//  Created by Mark on 4/12/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import UIKit
import Panels

class PanelMenu: UIViewController, UIScrollViewDelegate, Panelable {
    @IBOutlet var headerHeight: NSLayoutConstraint!
    @IBOutlet var headerPanel: UIView!
    @IBOutlet weak var pageScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var gameDetailsBtn: UIButton!
    
    var slides:[Slide] = []
    var roomName = UserDefaults.standard.string(forKey: UserDefaultsKeys.roomName)
    var roomPass = UserDefaults.standard.string(forKey: UserDefaultsKeys.roomPass)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeForNotification(name: .updateGameIsSpectate, selector: #selector(createSlidesForSpac))
        subscribeForNotification(name: .updateGameIsAll, selector: #selector(createSlides))
        self.view.addBlurBackgroundToMenu()
        curveTopCornersToMenuView()
        self.view.layoutIfNeeded()
        
        NetworkSevice.sharedInstance.getGameRunning { (error, value) in
            if value == 1 {
                self.removeScrollViewElements()
                self.slides = self.createSlidesForSpac()
                self.setupSlideScrollView(slides: self.slides)
                self.pageScrollView.delegate = self
                self.pageControl.numberOfPages = self.slides.count
                self.pageControl.currentPage = 0
                self.view.bringSubviewToFront(self.pageControl)
                self.nextButton.layer.cornerRadius = 10
                GameManagement.sharedInstance.selectedSpac = 4
                GameManagement.sharedInstance.isSpactate = true
                self.triggeredGameMode()
            } else {
                self.removeScrollViewElements()
                self.slides = self.createSlides()
                self.setupSlideScrollView(slides: self.slides)
                self.pageScrollView.delegate = self
                self.pageControl.numberOfPages = self.slides.count
                self.pageControl.currentPage = 0
                self.view.bringSubviewToFront(self.pageControl)
                self.nextButton.layer.cornerRadius = 10
                GameManagement.sharedInstance.selectedSpac = 0
                GameManagement.sharedInstance.isSpactate = false
                 self.triggeredGameMode()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc func createSlidesForSpac() -> [Slide] {
        let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide5.gameModeTitle.text = "Megfigyelő"
        slide5.gameModeDescription.text = "Az megfigyelő jaták mod arra való hogy nyomon tudjátok követni a játék állását igy megkönnyitve a játékot."
        slide5.actionBtn.setTitle("Kiválaszt", for: .normal)
        slide5.actionBtn.tag = 4
        slide5.actionBtn.isHidden = false
        slide5.actionBtn.layer.cornerRadius = 10
        slide5.actionBtn.addTarget(self, action: #selector(sliderButtonAction), for: .touchUpInside)
        
        return [slide5]
    }
    
    @objc func createSlides() -> [Slide] {
        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.gameModeTitle.text = "Egyszerű"
        slide1.gameModeDescription.text = "Az egyszerű játéknál Nem tudsz válogatni a játékok közül hanem minden játék fog szerepelni. Illetve az egyéb beállítási lehetőségeket sem fogod tudni alkalmazni."
        slide1.actionBtn.setTitle("Kiválaszt", for: .normal)
        slide1.actionBtn.tag = 0
        slide1.actionBtn.isHidden = false
        slide1.actionBtn.layer.cornerRadius = 10
        slide1.actionBtn.addTarget(self, action: #selector(sliderButtonAction), for: .touchUpInside)
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.gameModeTitle.text = "Összetett"
        slide2.gameModeDescription.text = "Az összetett játéknál ki tudod válogatni a játékok közül a neked megfelelőt és azokat személyre tudod szabni. Illetve az egyéb beállításokban van lehetőséged plusz funkciók bekapcsolására."
        slide2.actionBtn.setTitle("Kiválaszt", for: .normal)
        slide2.actionBtn.tag = 1
        slide2.actionBtn.isHidden = false
        slide2.actionBtn.layer.cornerRadius = 10
        slide2.actionBtn.addTarget(self, action: #selector(sliderButtonAction), for: .touchUpInside)
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.gameModeTitle.text = "Csata"
        slide3.gameModeDescription.text = "A csata játékban 2 játékos vehet részt és előre megadott játékosokkal tudnak játszani. Aki elősszőr eléri a 10 pontot az fog győzni."
        slide3.actionBtn.setTitle("Kiválaszt", for: .normal)
        slide3.actionBtn.tag = 2
        slide3.actionBtn.isHidden = false
        slide3.actionBtn.layer.cornerRadius = 10
        slide3.actionBtn.addTarget(self, action: #selector(sliderButtonAction), for: .touchUpInside)
        
        let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.gameModeTitle.text = "Előző Játék"
        slide4.gameModeDescription.text = "Az előző játék opcióval a már elkezdett játékot tudjátok folytatni."
        slide4.actionBtn.setTitle("Kiválaszt", for: .normal)
        slide4.actionBtn.tag = 3
        slide4.actionBtn.isHidden = true
        slide4.actionBtn.layer.cornerRadius = 10
        slide4.actionBtn.addTarget(self, action: #selector(sliderButtonAction), for: .touchUpInside)
        
        let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide5.gameModeTitle.text = "Megfigyelő"
        slide5.gameModeDescription.text = "Az megfigyelő játék mód arra való hogy nyomon tudjátok követni a játék állását így megkönnyítve a játékot."
        slide5.actionBtn.setTitle("Kiválaszt", for: .normal)
        slide5.actionBtn.tag = 4
        slide5.actionBtn.isHidden = false
        slide5.actionBtn.layer.cornerRadius = 10
        slide5.actionBtn.addTarget(self, action: #selector(sliderButtonAction), for: .touchUpInside)

        return [slide1, slide2, slide3, slide4, slide5]
    }
    
    @objc func sliderButtonAction(sender: UIButton!) {
        print("Button Clicked")
        switch sender.tag {
        case 0:
            print("Egyszerű")
            GameManagement.sharedInstance.selectedMode = 0
            nextButton.setTitle("Mehet", for: .normal)
            titleText.text = "Egyszerű"
            nextButton.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.8666666667, blue: 0.8745098039, alpha: 1)
            postNotification(name: .gameModeChanged)
        case 1:
            print("Összetett")
            GameManagement.sharedInstance.selectedMode = 1
            nextButton.setTitle("Beállitás", for: .normal)
            titleText.text = "Összetett"
            nextButton.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.8666666667, blue: 0.8745098039, alpha: 1)
            postNotification(name: .gameModeChanged)
        case 2:
            print("Csata")
            GameManagement.sharedInstance.selectedMode = 2
            nextButton.setTitle("Mehet", for: .normal)
            nextButton.backgroundColor = #colorLiteral(red: 0.7269999981, green: 0.8669999838, blue: 0.875, alpha: 1)
            titleText.text = "Csata"
            postNotification(name: .gameModeChanged)
        case 3:
            print("Prev Game")
            GameManagement.sharedInstance.selectedMode = 3
            nextButton.setTitle("Mehet", for: .normal)
            titleText.text = "Prev Game"
            nextButton.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.8666666667, blue: 0.8745098039, alpha: 1)
            postNotification(name: .gameModeChanged)
        case 4:
            print("Spactate")
            GameManagement.sharedInstance.selectedMode = 4
            nextButton.setTitle("Adatok Mutatása", for: .normal)
            titleText.text = "Megfigyelő"
            nextButton.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.8666666667, blue: 0.8745098039, alpha: 1)
            postNotification(name: .gameModeChanged)
        default:
            print("Default")
        }
        print("Selected item \(GameManagement.sharedInstance.selectedMode)")
    }
    
    
    func triggeredGameMode() {
        if GameManagement.sharedInstance.selectedSpac == 4 {
            nextButton.setTitle("Adatok Mutatása", for: .normal)
            titleText.text = "Megfigyelő"
            nextButton.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.8666666667, blue: 0.8745098039, alpha: 1)
            GameManagement.sharedInstance.selectedMode = 4
        } else {
            nextButton.setTitle("Mehet", for: .normal)
            titleText.text = "Egyszerű"
            nextButton.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.8666666667, blue: 0.8745098039, alpha: 1)
//            GameManagement.sharedInstance.selectedMode = 0
        }
    }
    
    @IBAction func gameButtonAction(_ sender: Any) {
        switch GameManagement.sharedInstance.selectedMode {
        case 0:
            NetworkSevice.sharedInstance.getPlayerList { (error) in
                if error == nil {
                    print("No error")
                } else {
                    print("Error")
                }
            }
            GameManagement.sharedInstance.chosenGames = GameManagement.sharedInstance.getGames()
            showLoaderView()
            loadAllGameData { [weak self] in
                self?.dissmissLoaderView()
            }
        case 1:
            NetworkSevice.sharedInstance.getPlayerList { (error) in
                if error == nil {
                    print("No error")
                } else {
                    print("Error")
                }
            }
            let setUpVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SetUpGameViewController") as! SetUpGameViewController
            self.navigationController?.pushViewController(setUpVc, animated: true)
        case 2:
            if GameManagement.sharedInstance.battlePlayer.count < 2 {
                let alert = UIAlertController(title: "Hiba", message: "Válasz ki két játékost aki csatázik egymással", preferredStyle: .alert)
                let okBtn = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okBtn)
                self.present(alert, animated: true, completion: nil)
            } else {
                GameManagement.sharedInstance.battleGameRun = true
                let battleGames = GameManagement.sharedInstance.getBattleGames()
                GameManagement.sharedInstance.chosenGames = battleGames
                NetworkSevice.sharedInstance.playerList = GameManagement.sharedInstance.battlePlayer
                
                self.showLoaderView()
                self.loadAllGameData { [weak self] in
                    self?.dissmissLoaderView()
                }
                
            }
        case 3:
            print("Prev Game")
        case 4:
            let scorePopVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScoreViewController") as! ScoreViewController
            scorePopVC.modalPresentationStyle = .overFullScreen
            self.present(scorePopVC, animated: true, completion: nil)
        default:
            print("Def switch")
        }
        
        if GameManagement.sharedInstance.selectedMode == 4 {
            print("No game Start")
        } else {
            if GameManagement.sharedInstance.selectedMode == 2 && GameManagement.sharedInstance.battlePlayer.count > 2  {
                NetworkSevice.sharedInstance.gameRunning(isRun: true) { (error) in
                    if error == nil {
                        print("Lock Screen for other player")
                    } else {
                        print("Error Lock Screen for other player ")
                    }
                }
            }  else if GameManagement.sharedInstance.selectedMode == 0 ||
                GameManagement.sharedInstance.selectedMode == 1 ||
                GameManagement.sharedInstance.selectedMode == 3 {
                NetworkSevice.sharedInstance.gameRunning(isRun: true) { (error) in
                    if error == nil {
                        print("Lock Screen for other player")
                    } else {
                        print("Error Lock Screen for other player ")
                    }
                }
                
            } else {
                print("No Battle Player")
            }
        }
    }

    
    
    func loadAllGameData(completion: (() -> Void)?) {
        var remainingCompletions = 0
        var errors = ""
        
        for game in GameManagement.sharedInstance.chosenGames {
            if game.downloadsData {
                remainingCompletions += 1
            }
        }
        
        let returnedBlock: ((_ error: Error?) -> Void) = { error in
            errors.append("\(error?.localizedDescription ?? "")\n")
            if remainingCompletions == 0 {
                completion?()
            } else {
                remainingCompletions -= 1
            }
            
        }
        
        for game in GameManagement.sharedInstance.chosenGames {
            switch game.name {
            case "Ki Vagyok Én":
                NetworkSevice.sharedInstance.getFamousPersons { (error) in
                    returnedBlock(error)
                    if error == nil {
                        print("Minden rendben. famous person sikeresen letöltödőt.")
                    }
                }
            case "Igaz Hamis":
                NetworkSevice.sharedInstance.getTrueOrFalse { (error) in
                    returnedBlock(error)
                    if error == nil {
                        print("Minden rendben. Igaz Hamis kérdések sikeresen letöltödőt.")
                    }
                }
            case "Én még soha":
                NetworkSevice.sharedInstance.getHaveIEverNever { (error) in
                    returnedBlock(error)
                    if error == nil {
                        print("Minden rendben. Én még soha kérdések sikeresen letöltödőt.")
                    }
                }
            case "Zene Felismerés":
                
                NetworkSevice.sharedInstance.getSongs { (error) in
                    returnedBlock(error)
                    if error == nil {
                        print("Minden rendben. Minden zene sikeresen letöltödőt.")
                    }
                }
            case "Anagramma":
                NetworkSevice.sharedInstance.getAnagrammaWord { (error) in
                    returnedBlock(error)
                    if error == nil {
                        print("Minden rendben. Minden Anagramma sikeresen letöltödőt.")
                    }
                }
            default:
                print("Nem kell letölteni semit.")
                
            }
        }
        returnedBlock(nil)
    }
    
    func removeScrollViewElements() {
        let subViews = self.pageScrollView.subviews
        for subview in subViews{
            subview.removeFromSuperview()
        }
    }
    
    func showLoaderView() {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoaderViewController") as! LoaderViewController
        popOverVC.modalPresentationStyle = .overFullScreen
        if let topController = UIApplication.topViewController() {
            topController.present(popOverVC, animated: true, completion: nil)
            
        }
    }
    
    func dissmissLoaderView() {
        if let topController = UIApplication.topViewController() {
            topController.dismiss(animated: true, completion: {
                if GameManagement.sharedInstance.selectedMode == 0 {
                    self.startNormalGame()
                } else {
                    self.startBattleGame()
                }
                
            })
        }
        
    }
    
    @IBAction func gameDetailsAction(_ sender: Any) {
        let alert = UIAlertController(title: "Szoba Adatok", message: "Szoba név: \(roomName!) \n Szoba jelszó: \(roomPass!)", preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "OK", style: .default, handler: nil)
        let resetScore = UIAlertAction(title: "Reset Score", style: .destructive) { (alert) in
            NetworkSevice.sharedInstance.resetPlayerData(players: NetworkSevice.sharedInstance.playerList, competionBlock: { (error) in
                if error == nil {
                    print("Reseted Player Score")
                } else {
                    print(error?.localizedDescription)
                }
            })
        }
        let resetData = UIAlertAction(title: "Develop", style: .default, handler: nil)
        alert.addAction(resetScore)
        //alert.addAction(resetData)
        alert.addAction(okBtn)
        if let topController = UIApplication.topViewController() {
            topController.present(alert, animated: true, completion: nil)
        }
    }
    
    func startBattleGame() {
        GameManagement.sharedInstance.groupDrinksAllow = false
        GameManagement.sharedInstance.randomPictogramAllow = false
        GameManagement.sharedInstance.showBonusView = false
        GameManagement.sharedInstance.drininkCounterView = false
        GameManagement.sharedInstance.selectedMode = 2
        let gameVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        self.present(gameVc, animated: true, completion: nil)
    }
    
    func startNormalGame() {
        GameManagement.sharedInstance.groupDrinksAllow = false
        GameManagement.sharedInstance.randomPictogramAllow = false
        GameManagement.sharedInstance.showBonusView = false
        GameManagement.sharedInstance.drininkCounterView = false
        let gameVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        self.present(gameVc, animated: true, completion: nil)
    }
    
    func setupSlideScrollView(slides : [Slide]) {
        pageScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        pageScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: 200)
        pageScrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            pageScrollView.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let _: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let _: CGFloat = currentVerticalOffset / maximumVerticalOffset
    }
}

extension UIView {
    func addBlurBackgroundToMenu() {
        self.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: self.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: self.widthAnchor),
            ])
        
    }
}

extension UIViewController {
    func curveTopCornersToMenuView() {
        let path = UIBezierPath(roundedRect: self.view.bounds,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: 30, height: 0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.view.bounds
        maskLayer.path = path.cgPath
        self.view.layer.mask = maskLayer
    }
}
