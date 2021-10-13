//
//  String + Height.swift
//  VKFeedNews
//
//  Created by Mikhail Ivanov on 13.10.2021.
//  Copyright © 2021 Mikhail Ivanov. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        
        return ceil(size.height)
    }
}
