//
//  AuthViewController.swift
//  VKFeedNews
//
//  Created by Mikhail Ivanov on 12.10.2021.
//

import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!
    
    @IBOutlet weak var goToVKButton: UIButton! {
        didSet {
            let contentInsets = UIEdgeInsets(top: 0,
                                             left: 20,
                                             bottom: 0,
                                             right: 20)
            goToVKButton.contentEdgeInsets = contentInsets
            
            goToVKButton.titleLabel?.adjustsFontSizeToFitWidth = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.authService = AppDelegate.shared().authService
        // Do any additional setup after loading the view.
        
    }
    

    @IBAction func goToVKAuth(_ sender: UIButton) {
        self.authService.wakeUpSession()
    }

}
