//
//  FinalPage.swift
//  Competitive Math version 1.2.1
//
//  Created by Stanimir on 3/7/18.
//  Copyright © 2018 StanArts. All rights reserved.
//

import UIKit

class FinalPage: UIViewController {
  
  var score: Int?
  var totalScore: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.hidesBackButton = true
    
    setupViews()
  }
  
  func showRating() {
    var rating = ""
    var color = UIColor.black
    guard let sc = score, let tc = totalScore else { return }
    let s = sc * 100 / tc
    if s < 10 {
      rating = "Better luck next time :)"
      color = UIColor.darkGray
    }  else if s < 40 {
      rating = "Average"
      color = UIColor.blue
    } else if s < 60 {
      rating = "Great! But try for more next time ;)"
      color = UIColor.yellow
    } else if s < 80 {
      rating = "Excellent"
      color = UIColor.red
    } else if s <= 100 {
      rating = "There is no one like you!"
      color = UIColor.orange
    }
    Rating.text = "\(rating)"
    Rating.textColor = color
  }
  
  @objc func btnRestartAction() {
    self.navigationController?.popToRootViewController(animated: true)
  }
  
  func setupViews() {
    self.view.addSubview(Title)
    Title.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
    Title.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    Title.widthAnchor.constraint(equalToConstant: 250).isActive = true
    Title.heightAnchor.constraint(equalToConstant: 80).isActive = true
    
    self.view.addSubview(lblScore)
    lblScore.topAnchor.constraint(equalTo: Title.bottomAnchor, constant: 0).isActive = true
    lblScore.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    lblScore.widthAnchor.constraint(equalToConstant: 150).isActive = true
    lblScore.heightAnchor.constraint(equalToConstant: 60).isActive = true
    lblScore.text = "\(score!) / \(totalScore!)"
    
    self.view.addSubview(Rating)
    Rating.topAnchor.constraint(equalTo: lblScore.bottomAnchor, constant: 40).isActive = true
    Rating.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    Rating.widthAnchor.constraint(equalToConstant: 150).isActive = true
    Rating.heightAnchor.constraint(equalToConstant: 60).isActive = true
    showRating()
    
    self.view.addSubview(Restart)
    Restart.topAnchor.constraint(equalTo: Rating.bottomAnchor, constant: 40).isActive = true
    Restart.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    Restart.widthAnchor.constraint(equalToConstant: 150).isActive = true
    Restart.heightAnchor.constraint(equalToConstant: 50).isActive = true
    Restart.addTarget(self, action: #selector(btnRestartAction), for: .touchUpInside)
  }
  
  let Title: UILabel = {
    let title = UILabel()
    title.text = "You scored: "
    title.textColor=UIColor.darkGray
    title.textAlignment = .center
    title.font = UIFont.systemFont(ofSize: 46)
    title.numberOfLines=2
    title.translatesAutoresizingMaskIntoConstraints = false
    return title
  }()
  
  let lblScore: UILabel = {
    let score = UILabel()
    score.text = "0 / 0"
    score.textColor=UIColor.black
    score.textAlignment = .center
    score.font = UIFont.boldSystemFont(ofSize: 24)
    score.translatesAutoresizingMaskIntoConstraints = false
    return score
  }()
  
  let Rating: UILabel = {
    let rat = UILabel()
    rat.text = "Very good!"
    rat.textColor=UIColor.black
    rat.textAlignment = .center
    rat.font = UIFont.boldSystemFont(ofSize: 24)
    rat.translatesAutoresizingMaskIntoConstraints = false
    return rat
  }()
  
  let Restart: UIButton = {
    let res = UIButton()
    res.setTitle("Try again!", for: .normal)
    res.setTitleColor(UIColor.white, for: .normal)
    res.backgroundColor = UIColor.red
    res.layer.cornerRadius = 5
    res.clipsToBounds = true
    res.translatesAutoresizingMaskIntoConstraints = false
    return res
  }()
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
