//
//  GFItemFollowersVC.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 30/10/20.
//

import UIKit

class GFBodyFollowersUserInforVC: UIViewController, GFBodyUserInforProtocol {
       
    //MARK: Variables
    var bodyUserInforProps: GFBodyUserInforProperties = GFBodyUserInforProperties()
    var delegate          : GFBodyFollowersUserInforVCDelegate!
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureViewController()
        configureStackView()
        configureActionButton()
        loadDataToUI(where: self)
        addActionToUI()
    }
    
    
    //MARK: Initializer
    required init(user: User) {
        bodyUserInforProps.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addActionToUI() {
        bodyUserInforProps.actionButton.addTarget(self, action: #selector(didTappedButtonGetFollower), for: .touchUpInside)
    }
    
    @objc func didTappedButtonGetFollower() {
        guard bodyUserInforProps.user.followers != 0 else {
            self.presentGFAlertOnMainThread(alertTitle: "No Followers", body: "\(bodyUserInforProps.user.name ?? "She/He") doesn't have any followers.\nWhat a shame 🥲", buttonTitle: "Ok")
            return
        }
        
        
        delegate.followersUserInforVC(self, willGetFollowersOf: bodyUserInforProps.user)
    }
 
}
