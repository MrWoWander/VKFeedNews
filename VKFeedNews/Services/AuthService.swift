//
//  AuthService.swift
//  VKFeedNews
//
//  Created by Mikhail Ivanov on 11.10.2021.
//

import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: class {
    func authServiceSholdShow(_ viewController: UIViewController)
    func authServiceSingUp()
    func authServiceDidSignInFail()
}

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appID = "7972897"
    private let vkSdk: VKSdk
    
    weak var delegate: AuthServiceDelegate?
    
    var token: String? {
        return VKSdk.accessToken().accessToken
    }
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appID)
        super.init()
        print("AuthService " + #function)
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeUpSession() {
        let scope = [VK_PER_WALL, VK_PER_FRIENDS]
        
        VKSdk.wakeUpSession(scope) {[delegate] state, error in
            switch state {
            case .authorized:
                delegate?.authServiceSingUp()
            case .initialized:
                VKSdk.authorize(scope, with: VKAuthorizationOptions.init(rawValue: 2))
            default:
                delegate?.authServiceDidSignInFail()
            }
        }
    }
    
    // MARK: VKSdkDelegate
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            self.delegate?.authServiceSingUp()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
    // MARK: VKSdkUIDelegate
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        self.delegate?.authServiceSholdShow(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
