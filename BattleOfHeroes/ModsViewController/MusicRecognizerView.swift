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


class MusicRecognizerView: GameView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var gameInLevelLabel: UILabel!
    @IBOutlet weak var musicRecognizerLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var soundAnimationView: LOTAnimationView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var resultButton: UIButton!
    
    
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    var animationView = LOTAnimationView(name: "sound_visualizer")
    
    var songList = GameManagement.sharedInstance.songTrackIDList
    var gameTimer: Timer!
    var playedMusic: Int = 1
    var songObject : Song?
    
    var tokenForSpotify : HTTPHeaders = HTTPHeaders()
    typealias JSONStandard = [String : AnyObject]
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    func commonInit() {
        if let token = GameManagement.sharedInstance.spotifyToken {
            let headers: HTTPHeaders = [
                "Authorization" : "Bearer \(token)"]
            tokenForSpotify = headers
        }
        
        subscribeForNotification(name: .addCounterValue, selector: #selector(updateLevelCounterUI), object: nil)
        Bundle.main.loadNibNamed("MusicRecognizerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        updateLevelCounterUI()
        
        soundAnimationView.isHidden = true
        songLabel.isHidden = true
        artistLabel.isHidden = true
        coverImageView.isHidden = true
        resultButton.isHidden = true
        
        let randomIndex = Int(arc4random_uniform(UInt32(songList.count)))
        
        var searchURL : String = "https://api.spotify.com/v1/tracks/\(songList[randomIndex])"
        print(searchURL)
        print(tokenForSpotify)
        callAlamo(url: searchURL, header: tokenForSpotify)
        
    }
    
    
    func callAlamo(url : String, header : HTTPHeaders) {
        NetworkSevice.sharedInstance.getSongJson(url: url, headers: header) { (error, response) in
            if error != nil {
                print("header file error")
            } else {
                self.parseData(JSONData: response as! Data)
            }
        }
        
        
    }
    
    func parseData(JSONData : Data) {
        do {
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
            if let songPreviewUrl = readableJSON["preview_url"] ,
                let songName = readableJSON["name"] {
                
                let url = songPreviewUrl as! String
                let song = songName as! String
                
                if let artistGroup = readableJSON["artists"] as? [JSONStandard] {
                    if let artists = artistGroup[0] as? JSONStandard {
                        let artist = artists["name"] as! String
                        songObject = Song(mainImage: "", name: song, previewURL: url, artist: artist)
                    }
                    
                }
                
            }
        }
        catch{
            print(error)
        }
        
        
    }
    
    
    @objc func updateLevelCounterUI() {
        gameInLevelLabel.text = self.levelCounter
        musicRecognizerLabel.text = "Fülelj mert csak 5 másodperced van"
    }
    
    
    
    @IBAction func playSound(_ sender: Any) {
        playSoundAnimation()
        songLabel.text = songObject?.name ?? "Nincs song name"
        artistLabel.text = songObject?.artist ?? "Nincs artist"
        if let prevUrl = songObject?.previewURL {
            let url = URL(string: prevUrl)
            downloadFileFromURL(url: url!)
        }
    }
    
    func downloadFileFromURL(url: URL) {
        self.playButton.isHidden = true
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
        animationView.frame = CGRect(x: (soundAnimationView.frame.width / 2) - 65, y: 0, width: 130, height: 100)
        animationView.loopAnimation = true
        self.soundAnimationView.addSubview(animationView)
        animationView.play()
    }
    
    @IBAction func result(_ sender: Any) {
        songLabel.isHidden = false
        artistLabel.isHidden = false
        coverImageView.isHidden = false
        resultButton.isHidden = true
    }
    
}
