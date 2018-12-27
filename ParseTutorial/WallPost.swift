//
//  WallPost.swift
//  Competitive Math version 1.2.1
//
//  Created by Stanimir on 3/7/18.
//  Copyright © 2018 StanArts. All rights reserved.
//

import Foundation

final class WallPost: PFObject {
  
  // MARK: - Properties
  @NSManaged var image: PFFile
  @NSManaged var user: PFUser
  @NSManaged var comment: String?
  
  // MARK: - Initializers
  init(image: PFFile, user: PFUser, comment: String?) {
    super.init()
    self.image = image
    self.user = user
    self.comment = comment
  }
  
  // Required otherwise the application crashes
  override init() {
    super.init()
  }
  
  // MARK: - Overridden
  override class func query() -> PFQuery<PFObject>? {
    let query = PFQuery(className: WallPost.parseClassName())
    query.includeKey("user")
    query.order(byDescending: "createdAt")
    return query
  }
}

// MARK: - PFSubclassing
extension WallPost: PFSubclassing {
  
  static func parseClassName() -> String {
    return "WallPost"
  }
}
