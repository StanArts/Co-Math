//
//  ViewController.swift
//  StanArts
//
//  Created by ddfulton on 5/8/17.
//  Copyright (c) 2017. All rights reserved.
//

import UIKit
import Parse

struct QuestionPF {

  var ObjectIDs : [String] = []
  var Question : String!
  var Answers : [String]!
  var Answer : String!
}

class OnlineGame: UIViewController {
  
  var myCollectionViewPF: UICollectionView!
  var QuestionsSource = [PFQuestion]()
  var RandomID = 0
  var Score = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    var ObjectIDQuery = PFObject(className: "Questionssource")
  
    ObjectIDQuery.findObjectsInBackgroundWithBlock({
      (objectsArray : [AnyObject]?, error : NSError? -> Void in)
      
      var ObjectIDs = objectsArray as! [PFObject]
      
      for i in 0..<ObjectIDs.count{
        self.ObjectIDsPublicArray.append(ObjectIDs[i].objectId)
        CallData()
      }
      
      
    })
    
  }
  
  func GetRandomObjectID(){
    
    RandomID = Int(arch4random_uniform(UInt32(ObjectIDs.count)))
  }
  
  func removeQuestion(){
    
    Score ++
    if(PFObjectIDsPublicArray.count>0){
      PFObjectIDsPublicArray.removeAtIndex(RandomID)
      CallData()
    }
  }
  
  func CallData(){
    
    GetRandomObjectID()
    
    if (PFObjectIDsPublicArray.count > 0){
      
      var query : PFQuery = PFQuery(className: "QuestionsandAnswers")
      query.getObjectInBackgroundWithId(ObjectIDsPublicArray[RandomID]){
        (ObjectHolder : PFObject!, error : NSError!) -> Void in
        
        if (error == nil){
          
          self.Question = ObjectHolder["Question"] as! String!
          self.Answers = ObjectHolder["Answers"] as! Array!
          self.Answer = ObjectHolder["Answer"] as! String!
          
          if (self.Answers.count > 0){
            self.QuestionLabel.text = self.Question
            
            self.Button1.setTitle(self.Answers[0], forState : UIControlState.Normal)
            self.Button2.setTitle(self.Answers[1], forState : UIControlState.Normal)
            self.Button3.setTitle(self.Answers[2], forState : UIControlState.Normal)
            self.Button4.setTitle(self.Answers[3], forState : UIControlState.Normal)
            
          }
          
        }
        else{
          
          NSLog("Error. Wrong!")
          
        }
      }
    }
    else{
      
      NSLog("You Scored: \(Score)")
    }
  }
  
  extension OnlineGame: OnlineGameCellDelegate {
    func didChooseAnswer(btnIndex: Int) {
      let centerIndex = getCenterIndex()
      guard let index = centerIndex else { return }
      QuestionsSource[index.item].isAnswered=true
      if QuestionsSource[index.item].CorrectAnswers != btnIndex {
        QuestionsSource[index.item].WrongAnswers = btnIndex
        score -= 1
      } else {
        score += 1
      }
      lblScore.text = "Score: \(score) / \(QuestionsSource.count)"
      myCollectionView.reloadItems(at: [index])
    }
    
    func getCenterIndex() -> IndexPath? {
      let center = self.view.convert(self.myCollectionView.center, to: self.myCollectionView)
      let index = myCollectionView!.indexPathForItem(at: center)
      print(index ?? "index not found")
      return index
    }

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
}
