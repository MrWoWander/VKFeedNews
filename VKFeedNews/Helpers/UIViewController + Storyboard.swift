//
//  UIViewController + Storyboard.swift
//  VKFeedNews
//
//  Created by Mikhail Ivanov on 12.10.2021.
//

import Foundation
import UIKit

extension UIViewController {
    class func loadFromStoryboard<T: UIViewController>(name storyboard: String) -> T? {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        return storyboard.instantiateInitialViewController() as? T
    }
}
