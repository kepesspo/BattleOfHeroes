//
//  MusicRecognizerHelper.swift
//  BattleOfHeroes
//
//  Created by Mark on 4/26/19.
//  Copyright © 2019 Mark. All rights reserved.
//

import Foundation
import SpotifyLogin
import UIKit
import MDCCommon
import Alamofire

class MusicRecognizerHelper {
    static var helper: MusicRecognizerHelper = {
        return MusicRecognizerHelper()
    }()
    
    typealias JSONStandard = [String : AnyObject]
    var tokenForSpotify : HTTPHeaders = HTTPHeaders()
    var songList = NetworkSevice.sharedInstance.musicRecognizer
    var songObject : Song?
    var searchURL : String = ""
    
    
    func startCallMusic(completionBlock: @escaping(_ error : Error?, _ song: Song?) -> Void) {
        if GameManagement.sharedInstance.spotifyToken == nil {
            updateSpotifyToken()
        } else {
            let header = addSpotifyToken()
            let randomIndex = Int(arc4random_uniform(UInt32(songList.count)))
            if let year = Int(songList[randomIndex].releaseDate.prefix(4)) {
                print(year)
                if GameManagement.sharedInstance.allowedYears.contains(year) {
                    searchURL = "https://api.spotify.com/v1/tracks/\(songList[randomIndex].id)"
                    print(searchURL)
                    callAlamo(url: searchURL, header: tokenForSpotify) { (error,song) in
                        if error == nil {
                            print("No error")
                            completionBlock(nil,song)
                        } else {
                            completionBlock(MyError.runtimeError("Error to parse Music"),nil)
                        }
                    }
                }
            }
        }
    }
    
    func addSpotifyToken() -> HTTPHeaders {
        if let token = GameManagement.sharedInstance.spotifyToken {
            let headers: HTTPHeaders = [
                "Authorization" : "Bearer \(token)"]
            tokenForSpotify = headers
            return headers
        }
        return HTTPHeaders()
    }
    
    func updateSpotifyToken() {
        if let topController = UIApplication.topViewController() {
            SpotifyLoginPresenter.login(from: topController , scopes:
                [.streaming,
                 .userReadTop,
                 .playlistReadPrivate,
                 .userLibraryRead])
        }
    }
    
    
    func callAlamo(url : String, header : HTTPHeaders, completionBlock: @escaping(_ error : Error?, _ song: Song?) -> Void) {
        NetworkSevice.sharedInstance.getSongJson(url: url, headers: header) { (error, response) in
            if error != nil {
                print("header file error")
            } else {
                self.parseData(JSONData: response as! Data, completionBlock: { (error, song) in
                    if error == nil {
                        completionBlock(nil,song)
                    } else {
                        completionBlock(error,nil)
                    }
                })
                
            }
        }
    }
    
    func parseData(JSONData : Data, completionBlock: @escaping(_ error : Error?, _ song : Song?) -> Void) {
        var image: String?
        do {
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
            if let expiredToken = readableJSON["error"] {
                print("expired Token")
                MusicRecognizerHelper.helper.updateSpotifyToken()
                return
            }
            if let songPreviewUrl = readableJSON["preview_url"] ,
                let songName = readableJSON["name"] {
                
                guard let url = songPreviewUrl as? String else {
                    completionBlock(MyError.runtimeError("Parse Data -> Url error"), nil)
                    return
                }
                let song = songName as! String
                
                if let album = readableJSON["album"] as? JSONStandard {
                    if let images = album["images"] as? [JSONStandard] {
                        let imageData = images[0]
                        let imageString = imageData["url"] as! String
                        image = imageString
                    }
                }
                
                if let artistGroup = readableJSON["artists"] as? [JSONStandard] {
                    if let artists = artistGroup[0] as? JSONStandard {
                        let artist = artists["name"] as! String
                        songObject = Song(mainImage: image ?? "", name: song, previewURL: url, artist: artist)
                        completionBlock(nil, songObject)
                    }
                }
            }
        }
        catch {
            print(error)
        }
    }
}
