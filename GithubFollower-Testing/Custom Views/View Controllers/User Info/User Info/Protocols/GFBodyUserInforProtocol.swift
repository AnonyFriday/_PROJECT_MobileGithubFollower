//
//  GFItemSuperClassVC.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 30/10/20.
//

import UIKit


//MARK: Properties
class GFBodyUserInforProperties {
    
    var user                      : User!
    var actionButton              : GFButton         = GFButton()
    fileprivate var stackView     : UIStackView      = UIStackView()
    fileprivate var itemViewOne   : GFChildItemView  = GFChildItemView()
    fileprivate var itemViewTwo   : GFChildItemView  = GFChildItemView()
}


//MARK: Body User Infor Protocol
protocol GFBodyUserInforProtocol {
    
    var bodyUserInforProps : GFBodyUserInforProperties { get }
    
    init(user: User, delegateTarget: UIViewController)
    
    func configureViewController()
    func configureStackView()
    func configureActionButton()
    
    func loadDataToUI(where currentVC: UIViewController)
    func addActionToUI()
}


//MARK: Extension
extension GFBodyUserInforProtocol where Self: UIViewController {

    //MARK: - LoadDataToUI
    func loadDataToUI(where currentVC: UIViewController) {
        
        switch currentVC {
        case is GFBodyFollowersUserInforVC:
            bodyUserInforProps.actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
            bodyUserInforProps.itemViewOne.setType(type: .followers, with: bodyUserInforProps.user.followers)
            bodyUserInforProps.itemViewTwo.setType(type: .following, with: bodyUserInforProps.user.following)
            
        case is GFBodyProfileUserInforVC:
            bodyUserInforProps.actionButton.set(backgroundColor: .systemPink, title: "Get Profile")
            bodyUserInforProps.itemViewOne.setType(type: .gists, with: bodyUserInforProps.user.publicGists)
            bodyUserInforProps.itemViewTwo.setType(type: .repos, with: bodyUserInforProps.user.publicRepos)
            
        default:
            return
        }
    }
    
    
    //MARK: - Configure VC
    func configureViewController() {
        view.addSubViews(views: bodyUserInforProps.stackView, bodyUserInforProps.actionButton)
        
        view.backgroundColor    = .secondarySystemBackground
        view.layer.cornerRadius = 16
    }
    
    func configureStackView() {
        bodyUserInforProps.stackView.addArrangedSubViews(views:bodyUserInforProps.itemViewOne, bodyUserInforProps.itemViewTwo)
        bodyUserInforProps.stackView.distribution   = .equalSpacing
        bodyUserInforProps.stackView.axis           = .horizontal
        
        bodyUserInforProps.stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding : CGFloat = 20.0
        
        NSLayoutConstraint.activate([
            bodyUserInforProps.stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: padding),
            bodyUserInforProps.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding),
            bodyUserInforProps.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding),
            bodyUserInforProps.stackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.33),
        ])
    }
    
    
    func configureActionButton() {
        bodyUserInforProps.actionButton.translatesAutoresizingMaskIntoConstraints = false
        let padding : CGFloat = 20.0
        
        NSLayoutConstraint.activate([
            bodyUserInforProps.actionButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3),
            bodyUserInforProps.actionButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding),
            bodyUserInforProps.actionButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding),
            bodyUserInforProps.actionButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -padding),
        ])
    }
}


