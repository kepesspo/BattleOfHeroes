//
//  MusicRecognizerView.swift
//  BattleOfHeroes
//
//  Created by Mark on 8/12/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import Foundation
import UIKit
import Lottie
import AVFoundation
import Alamofire
import MediaPlayer
import SpotifyLogin


class MusicRecognizerView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var musicRecognizerLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var soundAnimationView: LOTAnimationView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var resultButton: UIButton!
    
    
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    var animationView = LOTAnimationView(name: "4031-voice-recognition")
    var songList = NetworkSevice.sharedInstance.musicRecognizer
    var gameTimer: Timer!
    var playedMusic: Int = 1
    var playerList = NetworkSevice.sharedInstance.playerList

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    func commonInit() {
        Bundle.main.loadNibNamed("MusicRecognizerView", owner: self, options: nil)
        //subscribeForNotification(name: .spotiTokenUpdate, selector: #selector(responseForGameVC), object: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        soundAnimationView.isHidden = true
        songLabel.isHidden = true
        artistLabel.isHidden = true
        coverImageView.isHidden = true
        resultButton.isHidden = true
        self.tap.isEnabled = false
        
        updateUI()
    }
    
    func updateUI() {
        musicRecognizerLabel.text = "Fülelj mert csak 5 másodperced van"
        if let player = GameManagement.sharedInstance.getNextGamePlayer() {
            print("Player: \(player.playerName)")
            GameManagement.sharedInstance.actuallyPlayer = player
            GameManagement.sharedInstance.actuallyPlayedGameCounter = GameManagement.sharedInstance.actuallyPlayedGameCounter + 1
            GameManagement.sharedInstance.actuallyPlayedGameType = #imageLiteral(resourceName: "001-idea.png")
            postNotification(name: .updateGameData)
        }
    }
    
    func startToPlayMusic() {
        MusicRecognizerHelper.helper.startCallMusic { (error, song) in
            if error == nil {
                print("Song Parse Success")
                self.playSoundAnimation()
                self.songLabel.text = song?.name
                self.artistLabel.text = song?.artist
                let mainImageURL =  URL(string: song?.mainImage ?? "")
                let mainImageData = NSData(contentsOf: mainImageURL!)
                let mainImage = UIImage(data: mainImageData! as Data)
                self.coverImageView.image = mainImage
                
                if let prevUrl = song?.previewURL {
                    let url = URL(string: prevUrl)
                    self.downloadFileFromURL(url: url!)
                }
            } else {
                print("Song Parse Denied")
                self.startToPlayMusic()
            }
        }
    }

    @IBAction func playSound(_ sender: Any) {
       startToPlayMusic()
    }
    
    func downloadFileFromURL(url: URL) {
        playButton.isHidden = true
        var downloadTask = URLSessionDownloadTask()
        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: {
            customURL, response, error in
            self.play(url: customURL!)
            
        })
        downloadTask.resume()
    }
    
    
    
    func play(url: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.7) {
                self.animationView.stop()
                self.playButton.isHidden = true
                self.soundAnimationView.isHidden = true
                self.audioPlayer.stop()
                self.resultButton.isHidden = false
            }
        }
        catch{
            print(error)
        }
    }
    
    func playSoundAnimation() {
        soundAnimationView.isHidden = false
        animationView.frame = CGRect(x: (soundAnimationView.frame.width / 2) - 100, y: 0, width: 200, height: 100)
        animationView.loopAnimation = true
        self.soundAnimationView.addSubview(animationView)
        animationView.play()
    }
    
    @IBAction func result(_ sender: Any) {
        songLabel.isHidden = false
        artistLabel.isHidden = false
        coverImageView.isHidden = false
        resultButton.isHidden = true
        self.tap.isEnabled = true
    }
    
}
