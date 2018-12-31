//
//  BaseViewController.swift
//  TravelGuide
//
//  Created by Anton Makarov on 31.08.2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import UIKit
import Reachability
import SwiftMessages

class BaseViewController: UIViewController {

    var reachabilityStatus: ((Reachability.Connection) -> ())?
    fileprivate let reachability = Reachability()!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.startReachability()
    }

    func startReachability() {
        self.setupReachability()
    }
    
    func stopReachability() {
        self.reachability.stopNotifier()
    }
    
    func showMessageView(title: String, body: String, theme: Theme = .success, style: SwiftMessages.PresentationStyle = .top) {
        let messageView = MessageView.viewFromNib(layout: .cardView)
        messageView.configureTheme(theme)
        messageView.configureDropShadow()
        messageView.configureContent(title: title, body: body)
        messageView.button?.isHidden = true
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = style
        config.duration = .seconds(seconds: 3)
        //config.presentationContext = .window(windowLevel: UIWindowLevelNormal)
        
        SwiftMessages.show(config: config, view: messageView)
    }
    
    // Private
    // MARK: - Reachability
    private func setupReachability() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reachabilityChanged(note:)),
                                               name: .reachabilityChanged,
                                               object: reachability)
        
        do {
            try self.reachability.startNotifier()
        } catch {
            Logger.error(msg: "Unable to start Notifier")
        }
    }
    
    @objc private func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .none:
            self.showMessageView(title: "Error", body: "Network Unavailable", theme: .error, style: .top)
            Logger.error(msg: "Reachability Changed - Network unavailable")
        default:
            Logger.info(msg: "Reachability Changed - Network available")
        }

        if let status = self.reachabilityStatus {
            status(reachability.connection)
        }        
    }
}
