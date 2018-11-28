//
//  PermissionViewController.swift
//  BattleOfHeroes
//
//  Created by Mark on 11/21/18.
//  Copyright © 2018 Mark. All rights reserved.
//

import UIKit
import SpotifyLogin
import Alamofire
import AVFoundation


class PermissionViewController: UIViewController {
    var loginButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let button = SpotifyLoginButton(viewController: self,
                                        scopes: [.streaming,
                                                 .userReadTop,
                                                 .playlistReadPrivate,
                                                 .userLibraryRead])
        
        self.view.addSubview(button)
        self.loginButton = button
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SpotifyLogin.shared.getAccessToken { [weak self] (token, error) in
            print("Spotify Token: \(token)")
            if(token != nil) {
                GameManagement.sharedInstance.spotifyToken = token
                self?.loginButton?.removeFromSuperview()
            } else {
                SpotifyLogin.shared.logout()
            }      
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        loginButton?.center = self.view.center
    }
}
