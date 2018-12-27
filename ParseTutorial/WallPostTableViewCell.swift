//
//  WallPostTableViewCell.swift
//  Competitive Math version 1.2.1
//
//  Created by Stanimir on 3/7/18.
//  Copyright © 2018 StanArts. All rights reserved.
//
import UIKit

final class WallPostTableViewCell: PFTableViewCell {
  
  // MARK: - IBOutlets
  @IBOutlet weak var postImage: PFImageView!
  @IBOutlet weak var createdByLabel: UILabel!
  @IBOutlet weak var commentLabel: UILabel!
  @IBOutlet weak var progressView: UIProgressView!
}
