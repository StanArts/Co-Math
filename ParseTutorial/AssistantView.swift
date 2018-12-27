//
//  AssistantView.swift
//  CompetitiveMath
//
//  Created by Stanimir on 5/7/18.
//  Copyright © 2018 Stan Arts. All rights reserved.
//

import UIKit

class AssistantView: UIViewController {

    @IBOutlet var Back: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Back.layer.cornerRadius = 10
        Back.setTitleColor(UIColor.white, for: .normal)
        Back.layer.shadowRadius = 5
        Back.layer.shadowOffset = CGSize(width: 1, height: 0)
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
