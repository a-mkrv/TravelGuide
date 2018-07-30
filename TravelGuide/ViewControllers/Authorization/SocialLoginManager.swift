//
//  SocialLoginManager.swift
//  TravelGuide
//
//  Created by Anton Makarov on 24/04/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import VK_ios_sdk

public class SocialLoginManager: NSObject {
    
    static let sharedInstance = SocialLoginManager()
    
    public typealias FBSuccessBlock = ([String:AnyObject]) -> Void
    public typealias FBErrorBlock = (NSError) -> Void
    
    public typealias VKSuccessBlock = (VKAccessToken?) -> Void
    public typealias VKErrorBlock = (NSError?) -> Void
    
    let VKAppID = "6458228"
    private var VCForVKAuth:UIViewController?
    
    override private init() {
        super.init()
        
        if let VKSdkInstance = VKSdk.initialize(withAppId: VKAppID) {
            VKSdkInstance.register(self)
            VKSdkInstance.uiDelegate = self
        }
    }
}

// Facebook
/////////////////////////////////////////////////////////////////////////////

extension SocialLoginManager {
    
    public func facebookLogInWithReadPermissions(fromViewController: UIViewController!, handler:  FBSuccessBlock?, errorBlock: FBErrorBlock?) {
        
        FBSDKLoginManager().logIn(withReadPermissions: ["email"], from: fromViewController) { (result: FBSDKLoginManagerLoginResult?, error: Error?) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                let graphRequest:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"name, email, picture.type(large)"])
                
                graphRequest.start(completionHandler: { (connection, result, error) -> Void in
                    
                    if let error = error {
                        errorBlock!(error as NSError)
                    } else {
                        let data:[String:AnyObject] = result as! [String : AnyObject]
                        handler!(data)
                    }
                })
            }}
    }
    
    public func isLoggedInFacebook() -> Bool {
        if let _ = FBSDKAccessToken.current() {
            return true
        }
        return false
    }
    
    public func logOutFacebook() {
        FBSDKLoginManager().logOut()
        FBSDKAccessToken.setCurrent(nil)
        FBSDKProfile.setCurrent(nil)
    }
    
    public func currentTokenFacebook() -> FBSDKAccessToken! {
        return FBSDKAccessToken.current()
    }
}

// Vkontakte (VK)
/////////////////////////////////////////////////////////////////////////////

extension SocialLoginManager: VKSdkUIDelegate, VKSdkDelegate {

    public func vkontakteLogInWithReadPermissions(fromViewController: UIViewController!, handler: VKSuccessBlock?, errorBlock: VKErrorBlock?) {
        
        VCForVKAuth = fromViewController
        
        let permissions = ["email"]
        VKSdk.wakeUpSession(permissions) { (VKstate, VKerror) -> Void in
            switch VKstate {
            case .initialized:
                VKSdk.authorize(permissions, with: .disableSafariController)
                break
            case .authorized:
                if let token = VKSdk.accessToken(), let handler = handler {
                    handler(token)
                }
                break
            default:
                if let error = errorBlock {
                    error(VKerror as NSError?)
                }
            }
        }
    }
    
    public func isLoggedInVK() -> Bool {
        if let _ = VKSdk.accessToken() {
            return true
        }
        return false
    }
    
    public func logOutVK() {
        VKSdk.forceLogout()
    }
    
    public func currentTokenVK() -> VKAccessToken? {
        return VKSdk.accessToken()
    }
    
    
    //MARK: SDK - VKSdkUIDelegate, VKSdkDelegate
    public func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        Logger.info(msg: "vkSdkAccessAuthorizationFinished")
    }
    
    public func vkSdkUserAuthorizationFailed() {
        Logger.error(msg: "vkSdkUserAuthorizationFailed")
    }
    
    public func vkSdkShouldPresent(_ controller: UIViewController!) {
        guard let vc = VCForVKAuth else {
            return
        }
        
        vc.present(controller, animated: true, completion: nil)
    }
    
    public func vkSdkNeedCaptchaEnter(_ captchaError: VKError) {
        guard let vc = VCForVKAuth else {
            return
        }
        
        let captchaViewController = VKCaptchaViewController.captchaControllerWithError(captchaError)
        vc.present(captchaViewController!, animated: true, completion: nil)
    }
}


