//
//  NewsfeedCellLayoutCalculator.swift
//  VKFeedNews
//
//  Created by Mikhail Ivanov on 13.10.2021.
//  Copyright © 2021 Mikhail Ivanov. All rights reserved.
//

import Foundation
import UIKit

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
}

struct Sizes: FeedCellSizes {
    var postLabelFrame: CGRect
    var attachmentFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
}

struct Constants {
    static let topViewHeight: CGFloat = 36
    
    static let cardInsert = UIEdgeInsets(top: 0,
                                         left: 8,
                                         bottom: 12,
                                         right: 8)
    
    static let postLabelInsert = UIEdgeInsets(top: 8 + Constants.topViewHeight,
                                              left: 8,
                                              bottom: 8,
                                              right: 8)
    
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
        
        let cardViewWidth = screenWidth - (Constants.cardInsert.left - Constants.cardInsert.right)
        
        // MARK: Работа с postLabelFrame
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsert.left,
                                                    y: Constants.postLabelInsert.top),
                                    size: .zero)
        
        if let text = postText,
           !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsert.left - Constants.postLabelInsert.right
            let height = text.height(width: width, font: Constants.postLabelFont)
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        return Sizes.init(postLabelFrame: postLabelFrame,
                          attachmentFrame: .zero,
                          bottomViewFrame: .zero,
                          totalHeight: 300)
    }
}
