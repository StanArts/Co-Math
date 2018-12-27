//
//  LoginViewController.swift
//  Competitive Math version 1.2.1
//
//  Created by Stanimir on 3/7/18.
//  Copyright © 2018 StanArts. All rights reserved.
//
import UIKit

final class LoginViewController: UIViewController {
  
  // MARK: - Segue Identifiers
  fileprivate enum Segue {
    static let scrollViewWallSegue = "LoginSuccesful"
    static let tableViewWallSegue = "LoginSuccesfulTable"
  }
  
  // MARK: - IBOutlets
  @IBOutlet weak var userTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
}

// MARK: - Life Cycle
extension LoginViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Check if user exists and logged in
    guard let user = PFUser.current(), user.isAuthenticated else {
      return
    }
    
    performSegue(withIdentifier: Segue.scrollViewWallSegue, sender: nil)
  }
}

// MARK: - IBActions
private extension LoginViewController {
  
  @IBAction func loginTapped(_ sender: AnyObject) {
    guard let username = userTextField.text,
      let password = passwordTextField.text else {
        displayAlertController(NSLocalizedString("Missing Information", comment: ""),
                               message: NSLocalizedString("Username and Password fields cannot be empty. Please enter and try again!", comment: ""))
        return
    }
    
    PFUser.logInWithUsername(inBackground: username, password: password) { [unowned self] user, error in
      guard let _ = user else {
        self.showErrorView(error)
        return
      }
      self.performSegue(withIdentifier: Segue.tableViewWallSegue, sender: nil)
    }
  }
}

// MARK: - Private
private extension LoginViewController {
  
  /**
   Helper method to present a **UIAlertController** to the user
   
   - parameter title: Title for the controller
   - parameter message: Message displayed inside the controller
   */
  func displayAlertController(_ title: String, message: String) {
    let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
    controller.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: ""), style: .cancel))
    present(controller, animated: true)
  }
}
