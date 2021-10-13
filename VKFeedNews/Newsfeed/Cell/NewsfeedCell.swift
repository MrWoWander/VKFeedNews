//
//  NewsfeedCell.swift
//  VKFeedNews
//
//  Created by Mikhail Ivanov on 13.10.2021.
//  Copyright © 2021 Mikhail Ivanov. All rights reserved.
//

import Foundation
import UIKit

protocol FeedCellViewModel {
    var iconURLString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var comments: String? { get }
    var likes: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var photoAttachment: FeedCellPhotoAttachmentViewModel? { get }
    var sizes: FeedCellSizes { get }
}

protocol FeedCellSizes {
    var postLabelFrame: CGRect { get }
    var attachmentFrame: CGRect { get }
    var bottomViewFrame: CGRect { get }
    var totalHeight: CGFloat { get }
}

protocol FeedCellPhotoAttachmentViewModel {
    var photoURLString: String? { get }
    var width: Int { get }
    var height: Int { get }
}

class NewsfeedCell: UITableViewCell {
    
    static let reuseId = "NewsfeedCell"
    
    @IBOutlet weak var iconImage: WebImageView! {
        didSet {
            iconImage.layer.cornerRadius = iconImage.frame.width / 2
            iconImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var cardView: UIView! {
        didSet {
            cardView.layer.cornerRadius = 10
            cardView.clipsToBounds = true
            
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var postImageView: WebImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        selectionStyle = .none
    }
    
    func set(viewMode: FeedCellViewModel) {
        iconImage.set(imageURL: viewMode.iconURLString)
        nameLabel.text = viewMode.name
        dateLabel.text = viewMode.date
        postLabel.text = viewMode.text
        likesLabel.text = viewMode.likes
        commentsLabel.text = viewMode.comments
        sharesLabel.text = viewMode.shares
        viewsLabel.text = viewMode.views
        
        postLabel.frame = viewMode.sizes.postLabelFrame
        
        if let photoAttachment = viewMode.photoAttachment {
            postImageView.set(imageURL: photoAttachment.photoURLString)
            postImageView.frame = viewMode.sizes.attachmentFrame
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
        
        bottomView.frame = viewMode.sizes.bottomViewFrame
    }
    
}
