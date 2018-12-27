//
//  UploadImageViewController.swift
//  Competitive Math version 1.2.1
//
//  Created by Stanimir on 3/7/18.
//  Copyright © 2018 StanArts. All rights reserved.
//

import UIKit

final class UploadImageViewController: UIViewController {
  
  // MARK: - Properties
  var username: String?
  
  // MARK: - IBOutlets
  @IBOutlet weak var imageToUpload: UIImageView!
  @IBOutlet weak var commentTextField: UITextField!
  @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
}

// MARK: - IBActions
extension UploadImageViewController {
  
  @IBAction func selectPicturePressed(_ sender: AnyObject) {
    // Open a UIImagePickerController to select the picture
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = .photoLibrary
    present(imagePicker, animated: true)
  }
  
  @IBAction func sendPressed(_ sender: AnyObject) {
    commentTextField.resignFirstResponder()
    
    // Disable the send button until we are ready
    navigationItem.rightBarButtonItem?.isEnabled = false
    
    loadingSpinner.startAnimating()
    
    guard let uploadImage = imageToUpload.image,
      let pictureData = UIImagePNGRepresentation(uploadImage),
      let file = PFFile(name: "image", data: pictureData) else {
        return
    }
    
    file.saveInBackground({ [unowned self] succeeded, error in
      guard succeeded == true else {
        self.showErrorView(error)
        return
      }
      self.saveWallPost(file)
      }, progressBlock: { percent in
        print("Uploaded: \(percent)%")
    })
  }
}

// MARK: - Private
private extension UploadImageViewController {
  
  func saveWallPost(_ file: PFFile) {
    guard let currentUser = PFUser.current() else {
      return
    }
    
    let wallPost = WallPost(image: file, user: currentUser, comment: commentTextField.text)
    wallPost.saveInBackground { [unowned self] succeeded, error in
      if succeeded {
        _ = self.navigationController?.popViewController(animated: true)
      } else if let error = error {
        self.showErrorView(error)
      }
    }
  }
}

// MARK: - UINavigationControllerDelegate
extension UploadImageViewController: UINavigationControllerDelegate {
}

// MARK: - UIImagePickerControllerDelegate
extension UploadImageViewController: UIImagePickerControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
    // Place the image in the imageview
    imageToUpload.image = image
    picker.dismiss(animated: true, completion: nil)
  }
}
