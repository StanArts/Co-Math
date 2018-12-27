//
//  RegisterViewController.swift
//  Competitive Math version 1.2.1
//
//  Created by Stanimir on 3/7/18.
//  Copyright © 2018 StanArts. All rights reserved.
//

import UIKit

final class RegisterViewController: UIViewController {
  
  // MARK: - Segue Identifiers
  fileprivate enum Segue {
    static let tableViewWallSegue = "SignupSuccesfulTable"
  }
  
  // MARK: - IBOutlets
  @IBOutlet weak var userTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
}

// MARK: - IBActions
private extension RegisterViewController {
  
  @IBAction func signUpPressed(_ sender: AnyObject) {
    let user = PFUser()
    user.username = userTextField.text
    user.password = passwordTextField.text
    user.signUpInBackground { [unowned self] succeeded, error in
      guard succeeded == true else {
        self.showErrorView(error)
        return
      }
      // Successful registration, display the wall
      self.performSegue(withIdentifier: Segue.tableViewWallSegue, sender: nil)
    }
  }
}
