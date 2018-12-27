//
//  Menu.swift
//  TransitionsDemo
//
//  Created by Stanimir on 5/7/18.
//  Copyright © 2018 Meng To. All rights reserved.
//

import UIKit

class Menu: UIViewController {

    @IBOutlet var lblMenu: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lblMenu.transform = CGAffineTransform(rotationAngle: -0.33)
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
