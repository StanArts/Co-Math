//
//  InGame.swift
//  Competitive Math version 1.2.1
//
//  Created by Stanimir on 3/7/18.
//  Copyright © 2018 StanArts. All rights reserved.
//

import UIKit

struct Question {
    
    let Image: String
    let TextQuestion: String
    let PosibleAnswers: [String]
    let CorrectAnswers: Int
    var WrongAnswers: Int
    var isAnswered: Bool
}

class InGame: UIViewController {

    var myCollectionView: UICollectionView!
    var QuestionsSource = [Question]()
    var score: Int = 0
    var currentQuestionNumber = 1
    
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        super.viewDidLoad()
        self.title = "Competitive Math"
        self.view.backgroundColor=UIColor.white
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        myCollectionView = UICollectionView(frame: CGRect(x: 1, y: 1, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: layout)
        myCollectionView.delegate = self as? UICollectionViewDelegate
        myCollectionView.dataSource = self as? UICollectionViewDataSource
        myCollectionView.register(InGameCell.self, forCellWithReuseIdentifier: "Cell")
        myCollectionView.showsHorizontalScrollIndicator = false
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        myCollectionView.backgroundColor = UIColor.white
        myCollectionView.isPagingEnabled = true
        
        self.view.addSubview(myCollectionView)
        
        let task1 = Question(Image: "que1", TextQuestion: "Solve the equation!", PosibleAnswers: ["2", "12", "8", "6"], CorrectAnswers: 1, WrongAnswers: -1, isAnswered: false)
        let task2 = Question(Image: "que2", TextQuestion: "Solve the equation!", PosibleAnswers: ["9", "19", "10", "19.2"], CorrectAnswers: 3, WrongAnswers: -1, isAnswered: false)
        let task3 = Question(Image: "que3", TextQuestion: "Solve the equation!", PosibleAnswers: ["7", "5", "4", "8"], CorrectAnswers: 2, WrongAnswers: -1, isAnswered: false)
        
        QuestionsSource = [task1, task2, task3]
        
        setupViews()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return QuestionsSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! InGameCell
        cell.question = QuestionsSource[indexPath.row]
        cell.delegate = self as InGameCellDelegate
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setQuestionNumber()
    }
    
    func setQuestionNumber() {
        let x = myCollectionView.contentOffset.x
        let w = myCollectionView.bounds.size.width
        let currentPage = Int(ceil(x/w))
        if currentPage < QuestionsSource.count {
            QuestionsNumber.text = "Question: \(currentPage + 1) / \(QuestionsSource.count)"
            currentQuestionNumber = currentPage + 1
        }
    }
    
    @objc func PreviousNextAction(sender: UIButton) {
        if sender == Next && currentQuestionNumber == QuestionsSource.count {
            let r = FinalPage()
            r.score = score
            r.totalScore = QuestionsSource.count
            self.navigationController?.pushViewController(r, animated: false)
            return
        }
        
        let collectionBounds = self.myCollectionView.bounds
        var contentOffset: CGFloat = 0
        if sender == Next {
            contentOffset = CGFloat(floor(self.myCollectionView.contentOffset.x + collectionBounds.size.width))
            currentQuestionNumber += currentQuestionNumber >= QuestionsSource.count ? 0 : 1
        } else {
            contentOffset = CGFloat(floor(self.myCollectionView.contentOffset.x - collectionBounds.size.width))
            currentQuestionNumber -= currentQuestionNumber <= 0 ? 0 : 1
        }
        self.moveToFrame(contentOffset: contentOffset)
        QuestionsNumber.text = "Question: \(currentQuestionNumber) / \(QuestionsSource.count)"
    }
    
    func moveToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.myCollectionView.contentOffset.y ,width : self.myCollectionView.frame.width,height : self.myCollectionView.frame.height)
        self.myCollectionView.scrollRectToVisible(frame, animated: true)
    }
    
    func setupViews() {
        myCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        myCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        myCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        myCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.view.addSubview(Previous)
        Previous.heightAnchor.constraint(equalToConstant: 50).isActive = true
        Previous.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        Previous.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        Previous.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        self.view.addSubview(Next)
        Next.heightAnchor.constraint(equalTo: Previous.heightAnchor).isActive = true
        Next.widthAnchor.constraint(equalTo: Previous.widthAnchor).isActive = true
        Next.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        Next.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        self.view.addSubview(QuestionsNumber)
        QuestionsNumber.heightAnchor.constraint(equalToConstant: 20).isActive = true
        QuestionsNumber.widthAnchor.constraint(equalToConstant: 150).isActive = true
        QuestionsNumber.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        QuestionsNumber.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80).isActive = true
        QuestionsNumber.text = "Question: \(1) / \(QuestionsSource.count)"
        
        self.view.addSubview(lblScore)
        lblScore.heightAnchor.constraint(equalTo: QuestionsNumber.heightAnchor).isActive = true
        lblScore.widthAnchor.constraint(equalTo: QuestionsNumber.widthAnchor).isActive = true
        lblScore.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        lblScore.bottomAnchor.constraint(equalTo: QuestionsNumber.bottomAnchor).isActive = true
        lblScore.text = "Score: \(score) / \(QuestionsSource.count)"
    }
    
    let Previous: UIButton = {
        let back = UIButton()
        back.setTitle("< Previous", for: .normal)
        back.setTitleColor(UIColor.white, for: .normal)
        back.backgroundColor=UIColor.blue
        back.translatesAutoresizingMaskIntoConstraints=false
        back.addTarget(self, action: #selector(PreviousNextAction), for: .touchUpInside)
        return back
    }()
    
    let Next: UIButton = {
        let next = UIButton()
        next.setTitle("Next >", for: .normal)
        next.setTitleColor(UIColor.white, for: .normal)
        next.backgroundColor=UIColor.red
        next.translatesAutoresizingMaskIntoConstraints=false
        next.addTarget(self, action: #selector(PreviousNextAction), for: .touchUpInside)
        return next
    }()
    
    let QuestionsNumber: UILabel = {
        let qnumber = UILabel()
        qnumber.text = "0 / 0"
        qnumber.textColor=UIColor.gray
        qnumber.textAlignment = .left
        qnumber.font = UIFont.systemFont(ofSize: 16)
        qnumber.translatesAutoresizingMaskIntoConstraints=false
        return qnumber
    }()
    
    let lblScore: UILabel = {
        let score = UILabel()
        score.text = "0 / 0"
        score.textColor=UIColor.gray
        score.textAlignment = .right
        score.font = UIFont.systemFont(ofSize: 16)
        score.translatesAutoresizingMaskIntoConstraints=false
        return score
    }()
}

extension InGame: InGameCellDelegate {
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
