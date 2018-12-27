//
//  WallPicturesViewController.swift
//  Competitive Math version 1.2.1
//
//  Created by Stanimir on 3/7/18.
//  Copyright © 2018 StanArts. All rights reserved.
//
import UIKit

final class WallPicturesViewController: UIViewController {
  
  // MARK: - Properties
  fileprivate lazy var infoLabelFont = UIFont(name: "HelveticaNeue", size: 12)
  fileprivate lazy var commentLabelFont = UIFont(name: "HelveticaNeue", size: 16)
  
  fileprivate lazy var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm dd/MM yyyy"
    return formatter
  }()
  
  // MARK: - IBOutlets
  @IBOutlet weak var wallScroll: UIScrollView!
}

// MARK: - Life Cycle
extension WallPicturesViewController {
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Clean the scroll view
    cleanWall()
    
    // Reload the wall
    getWallImages()
  }
}

// MARK: - IBActions
private extension WallPicturesViewController {
  
  @IBAction func logOutPressed(_ sender: AnyObject) {
    PFUser.logOut()
    _ = navigationController?.popToRootViewController(animated: true)
  }
}

// MARK: - Wall
private extension WallPicturesViewController {
  
  func cleanWall() {
    for subview in wallScroll.subviews {
      subview.removeFromSuperview()
    }
  }
  
  func getWallImages() {
    guard let query = WallPost.query() else {
      return
    }
    
    query.findObjectsInBackground { [unowned self] objects, error in
      guard let objects = objects as? [WallPost] else {
        self.showErrorView(error)
        return
      }
      self.loadWallViews(objects)
    }
  }
  
  func loadWallViews(_ objects: [WallPost]) {
    cleanWall()
    
    // Need to keep a reference to the previous wall view for two reasons
    //
    // 1. It will be required for any future wall views so their topAnchor can be constrainted to the previous bottomAnchor
    // 2. At the end of the loop the bottom anchor for the previous wallView must be constrained to the wallScroll's bottom
    //    anchor. Without this the scroll view could not automatically retrieve its content size from the
    var previousWallView: UIView? = nil
    for wallPost in objects {
      
      let wallView = setupWallView(previousWallView)
      wallPost.image.getDataInBackground { [unowned self] data, error in
        guard let data = data,
          let image = UIImage(data: data) else {
            return
        }
        
        // Setup the image view and add as a sub view to the **wallView**
        let imageView = self.setupImageView(image, wallView: wallView)
        
        // Add the info label (User and creation date) as subview to the **wallView**
        let creationDate = wallPost.createdAt
        let dateString = wallPost.createdAt != nil ? self.dateFormatter.string(from: creationDate!) : "N/A"
        let infoLabel = self.setupInfoLabel(wallPost.user.username, creationDate: dateString, wallView: wallView, imageView: imageView)
        
        // Add the comment label as a subview to the **wallView**
        self.setupCommentLabel(wallPost.comment, wallView: wallView, infoLabel: infoLabel)
      }
      previousWallView = wallView
    }
    
    // Always close out the constraints to the wallScroll bottomAnchor in order for the scrollView to
    // correctly calculate the contentSize variable from the auto layout constraints of its subviews
    previousWallView?.bottomAnchor.constraint(equalTo: wallScroll.bottomAnchor).isActive = true
  }
}

// MARK: - Other Private
private extension WallPicturesViewController {
  
  /**
   Method sets up a **UIView** to act as the **WallPost**'s view
   
   - parameter previousWallView: The previous wall view so the autolayout constraints can be set correctly
   this can be **nil** indicating this is the first wall view
   */
  func setupWallView(_ previousWallView: UIView?) -> UIView {
    let wallView = UIView()
    wallView.translatesAutoresizingMaskIntoConstraints = false
    wallScroll.addSubview(wallView)
    
    // Generate the auto layout constraints required for the wallView
    wallView.heightAnchor.constraint(equalToConstant: 270.0).isActive = true
    wallView.leadingAnchor.constraint(equalTo: wallScroll.leadingAnchor).isActive = true
    wallView.widthAnchor.constraint(equalTo: wallScroll.widthAnchor).isActive = true
    
    // Generate to Y constraint based on if this is the first wallView object or not
    if let previousWallView = previousWallView {
      // Not the first wall view object so utilize the previous wall view objects bottom anchor
      wallView.topAnchor.constraint(equalTo: previousWallView.bottomAnchor).isActive = true
    } else {
      // First wall view object so utilize the wallScroll objects topAnchor
      wallView.topAnchor.constraint(equalTo: wallScroll.topAnchor).isActive = true
    }
    
    return wallView
  }
  
  /**
   Method creates a **UIImageView** with the provided **UIImage** and configures
   the relevant frame and contentMode properties
   
   - parameter image: **UImage** to be displayed in the **WallPost**
   - paramter wallView: **UIView** associated with the wall view this will be the container
   view as well as the view to generate constraints from
   
   - returns: Configured **UIImageView** for the **WallPost**
   */
  func setupImageView(_ image: UIImage, wallView: UIView) -> UIImageView {
    let imageView = UIImageView(image: image)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    wallView.addSubview(imageView)
    
    // Generate the auto layout constraints required for the imageView
    imageView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
    imageView.topAnchor.constraint(equalTo: wallView.topAnchor, constant: 10.0).isActive = true
    imageView.leadingAnchor.constraint(equalTo: wallView.leadingAnchor, constant: 10.0).isActive = true
    imageView.trailingAnchor.constraint(equalTo: wallView.trailingAnchor, constant: 10.0).isActive = true
    
    return imageView
  }
  
  /**
   Method creates and configures the **infoLabel** for the **WallPost**
   
   - parameter username: String username of the person who uploaded the post can be **nil**
   - parameter creationDate: String representation of the post's creation date
   - parameter wallView: **UIView** associated with the wall view this will be the container
   view as well as the view to generate constraints from
   - parameter imageView: used to generate contraints for Y placement inside the wallView
   
   - returns: Configured **UILabel** used for post information
   */
  func setupInfoLabel(_ username: String?, creationDate: String, wallView: UIView, imageView: UIImageView) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    if let username = username {
      label.text = "Uploaded by: \(username), \(creationDate)"
    } else {
      label.text = "Uploaded by: anonymous, \(creationDate)"
    }
    label.font = infoLabelFont
    label.textColor = .white
    label.backgroundColor = .clear
    label.sizeToFit()
    wallView.addSubview(label)
    
    // Generate the auto layout constraints required for the label
    label.leadingAnchor.constraint(equalTo: wallView.leadingAnchor, constant: 10.0).isActive = true
    label.trailingAnchor.constraint(equalTo: wallView.trailingAnchor, constant: 10.0).isActive = true
    label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8.0).isActive = true
    
    return label
  }
  
  /**
   Method creates and configures the **commentLabel** for the **WallPost**
   
   - parameter comment: Comment the user made, can be **nil**
   - parameter wallView: **UIView** associated with the wall view this will be the container
   view as well as the view to generate constraints from
   - parameter infoLabel: used to generate constraints for Y placement inside the wallView
   */
  func setupCommentLabel(_ comment: String?, wallView: UIView, infoLabel: UILabel) {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = comment
    label.font = commentLabelFont
    label.textColor = .white
    label.backgroundColor = .clear
    label.sizeToFit()
    wallView.addSubview(label)
    
    // Generate the auto layout constraints required for the label
    label.leadingAnchor.constraint(equalTo: wallView.leadingAnchor, constant: 10.0).isActive = true
    label.trailingAnchor.constraint(equalTo: wallView.trailingAnchor, constant: 10.0).isActive = true
    label.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 5.0).isActive = true
  }
}
