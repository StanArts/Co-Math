//
//  MainMenu2.swift
//  CompetitiveMath
//
//  Created by Stanimir on 5/7/18.
//  Copyright © 2018 Stan Arts. All rights reserved.
//

import UIKit

class MainMenu2: UIViewController {

    @IBOutlet var lblWel: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var btnStart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
        lblWel.transform = CGAffineTransform(rotationAngle: -0.16)
        lblTitle.transform = CGAffineTransform(rotationAngle: -0.16)
      
        btnStart.layer.cornerRadius = 10
        btnStart.setTitleColor(UIColor.white, for: .normal)
        btnStart.layer.shadowRadius = 5
        btnStart.layer.shadowOffset = CGSize(width: 1, height: 0)
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
