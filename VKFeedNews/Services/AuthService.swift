//
//  AuthService.swift
//  VKFeedNews
//
//  Created by Mikhail Ivanov on 11.10.2021.
//

import Foundation
import VK_ios_sdk

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appID = "7972897"
    private let vkSdk: VKSdk
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appID)
        super.init()
        print("AuthService " + #function)
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    // MARK: VKSdkDelegate
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
    // MARK: VKSdkUIDelegate
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
