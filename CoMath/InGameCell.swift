//
//  InGameCell.swift
//  Competitive Math version 1.2.1
//
//  Created by Stanimir on 3/7/18.
//  Copyright © 2018 StanArts. All rights reserved.
//

import UIKit

protocol InGameCellDelegate: class {
    func didChooseAnswer(btnIndex: Int)
}
class InGameCell: UICollectionViewCell {
    
    var Button1: UIButton!
    var Button2: UIButton!
    var Button3: UIButton!
    var Button4: UIButton!
    var ButtonsArray = [UIButton]()
    
    weak var delegate: InGameCellDelegate?
    
    var question: Question? {
        didSet {
            guard let unseenQuestion = question else { return }
            imgView.image = UIImage(named: unseenQuestion.Image)
            QuestionLabel.text = unseenQuestion.TextQuestion
            Button1.setTitle(unseenQuestion.PosibleAnswers[0], for: .normal)
            Button2.setTitle(unseenQuestion.PosibleAnswers[1], for: .normal)
            Button3.setTitle(unseenQuestion.PosibleAnswers[2], for: .normal)
            Button4.setTitle(unseenQuestion.PosibleAnswers[3], for: .normal)
            
            if unseenQuestion.isAnswered {
                ButtonsArray[unseenQuestion.CorrectAnswers].backgroundColor=UIColor.green
                if unseenQuestion.WrongAnswers >= 0 {
                    ButtonsArray[unseenQuestion.WrongAnswers].backgroundColor=UIColor.red
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        ButtonsArray = [Button1, Button2, Button3, Button4]
    }
    
    @objc func btnOptionAction(sender: UIButton) {
        guard let unwrappedQue = question else { return }
        if !unwrappedQue.isAnswered {
            delegate?.didChooseAnswer(btnIndex: sender.tag)
        }
    }
    
    override func prepareForReuse() {
        Button1.backgroundColor = UIColor.cyan
        Button2.backgroundColor = UIColor.cyan
        Button3.backgroundColor = UIColor.cyan
        Button4.backgroundColor = UIColor.cyan
    }
    
    func setupViews() {
        addSubview(imgView)
        imgView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        imgView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imgView.heightAnchor.constraint(equalTo: imgView.widthAnchor).isActive = true
        
        addSubview(QuestionLabel)
        QuestionLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor).isActive = true
        QuestionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        QuestionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        QuestionLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        let btnWidth: CGFloat = 150
        let btnHeight: CGFloat = 50
        Button1 = getButton(tag: 0)
        addSubview(Button1)
        NSLayoutConstraint.activate([Button1.topAnchor.constraint(equalTo: QuestionLabel.bottomAnchor, constant: 20),
                                     Button1.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -10),
                                     Button1.widthAnchor.constraint(equalToConstant: btnWidth),
                                     Button1.heightAnchor.constraint(equalToConstant: btnHeight)])
        Button1.addTarget(self, action: #selector(btnOptionAction), for: .touchUpInside)
        
        Button2 = getButton(tag: 1)
        addSubview(Button2)
        NSLayoutConstraint.activate([Button2.topAnchor.constraint(equalTo: Button1.topAnchor),
                                     Button2.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 10),
                                     Button2.widthAnchor.constraint(equalToConstant: btnWidth),
                                     Button2.heightAnchor.constraint(equalToConstant: btnHeight)])
        Button2.addTarget(self, action: #selector(btnOptionAction), for: .touchUpInside)
        
        Button3 = getButton(tag: 2)
        addSubview(Button3)
        NSLayoutConstraint.activate([Button3.topAnchor.constraint(equalTo: Button1.bottomAnchor, constant: 20),
                                     Button3.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -10),
                                     Button3.widthAnchor.constraint(equalToConstant: btnWidth), Button3.heightAnchor.constraint(equalToConstant: btnHeight)])
        Button3.addTarget(self, action: #selector(btnOptionAction), for: .touchUpInside)
        
        Button4 = getButton(tag: 3)
        addSubview(Button4)
        NSLayoutConstraint.activate([Button4.topAnchor.constraint(equalTo: Button3.topAnchor),
                                     Button4.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 10),
                                     Button4.widthAnchor.constraint(equalToConstant: btnWidth),
                                     Button4.heightAnchor.constraint(equalToConstant: btnHeight)])
        Button4.addTarget(self, action: #selector(btnOptionAction), for: .touchUpInside)
    }
    
    func getButton(tag: Int) -> UIButton {
        let btn=UIButton()
        btn.tag = tag
        btn.setTitle("Option", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.white
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.darkGray.cgColor
        btn.layer.cornerRadius = 5
        btn.clipsToBounds=true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }
    
    let imgView: UIImageView = {
        let i = UIImageView()
        i.image = #imageLiteral(resourceName: "que1")
        i.image = #imageLiteral(resourceName: "que2")
        i.image = #imageLiteral(resourceName: "que3")
        i.contentMode = .scaleAspectFit
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    } ()
    
    let QuestionLabel: UILabel = {
        let tbox = UILabel()
        tbox.text = "Select one of the answer options!"
        tbox.textColor=UIColor.black
        tbox.textAlignment = .center
        tbox.font = UIFont.systemFont(ofSize: 16)
        tbox.numberOfLines = 4
        tbox.translatesAutoresizingMaskIntoConstraints = false
        return tbox
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }}
