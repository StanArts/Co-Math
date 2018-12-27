//
//  ViewController.swift
//  Competitive Math version 1.2.1
//
//  Created by Stanimir on 3/7/18.
//  Copyright © 2018 StanArts. All rights reserved.
//

import UIKit

class MainMenu: UIViewController {

    
    @IBOutlet var StartButton: UIButton!
    
    @IBOutlet var OnlineGame: UIButton!
    
    @IBOutlet var SocialMedia: UIButton!
    
    @IBOutlet var About: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Main Menu"
    
    StartButton.layer.cornerRadius = 5
    StartButton.setTitleColor(UIColor.white, for: .normal)
    StartButton.layer.shadowColor = UIColor.gray.cgColor
    StartButton.layer.shadowRadius = 32
    StartButton.layer.shadowOpacity = 10
    StartButton.layer.shadowOffset = CGSize(width: 0, height: 0)
      
    OnlineGame.layer.cornerRadius = 5
    OnlineGame.setTitleColor(UIColor.white, for: .normal)
    OnlineGame.layer.shadowColor = UIColor.gray.cgColor
    OnlineGame.layer.shadowRadius = 32
    OnlineGame.layer.shadowOpacity = 10
    OnlineGame.layer.shadowOffset = CGSize(width: 0, height: 0)
      
    SocialMedia.layer.cornerRadius = 5
    SocialMedia.setTitleColor(UIColor.white, for: .normal)
    SocialMedia.layer.shadowColor = UIColor.gray.cgColor
    SocialMedia.layer.shadowRadius = 32
    SocialMedia.layer.shadowOpacity = 10
    SocialMedia.layer.shadowOffset = CGSize(width: 0, height: 0)
  
    About.layer.cornerRadius = 5
    About.setTitleColor(UIColor.white, for: .normal)
    About.layer.shadowColor = UIColor.gray.cgColor
    About.layer.shadowRadius = 32
    About.layer.shadowOpacity = 10
    About.layer.shadowOffset = CGSize(width: 0, height: 0)
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

