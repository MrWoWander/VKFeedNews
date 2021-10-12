//
//  AuthViewController.swift
//  VKFeedNews
//
//  Created by Mikhail Ivanov on 12.10.2021.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var goToVKButton: UIButton! {
        didSet {
            goToVKButton.titleLabel?.adjustsFontSizeToFitWidth = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func goToVKAuth(_ sender: UIButton) {
        print(#function)
    }

}
