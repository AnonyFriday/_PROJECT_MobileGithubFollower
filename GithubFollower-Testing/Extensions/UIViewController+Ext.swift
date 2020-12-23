//
//  ViewController+Ext.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 18/10/20.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
    
    //MARK: - Show AlertVC
    func presentGFAlertOnMainThread(alertTitle: String, body: String!, buttonTitle:String) {
        DispatchQueue.main.async {
            let customAlert = GFCustomAlertVC(textForTitle: alertTitle, textForBody: body, textForButton: buttonTitle)
            customAlert.modalTransitionStyle    = .crossDissolve
            customAlert.modalPresentationStyle  = .overFullScreen
            self.present(customAlert, animated: true)
        }
    }
    
    
    //MARK: - Show Safari based on Url
    func openSafariWebBrowser(url: URL) {
        let safari                          = SFSafariViewController(url: url)
        safari.preferredControlTintColor    = .systemGreen
        present(safari, animated: true)
    }
    
}

