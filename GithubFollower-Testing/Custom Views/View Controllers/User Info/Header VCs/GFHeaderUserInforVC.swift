//
//  GFHeaderUserInforVC.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 28/10/20.
//

import UIKit

class GFHeaderUserInforVC: UIViewController {
    
    var avatarImageView     = GFAvatarImageView(frame: .zero)
    var usernameLabel       = GFTitleLabel(textAlignment: .left, fontSize: 34)
    var nameLabel           = GFSecondaryLabel(fontSize: 18)
    var nameImageView       = UIImageView()
    var locationImageView   = UIImageView()
    var locationLabel       = GFSecondaryLabel(fontSize: 18)
    var bioLabel            = GFBodyLabel(textAlignment: .left)
    
    private var user : User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("No initialier")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubViews(views: avatarImageView, usernameLabel, nameImageView, nameLabel,locationLabel,locationImageView,bioLabel)
        
        configureUIElements()
    }
    
    
    //MARK: - Configure UILayouts, Constants
    private func configureUIElements() {
        // Set data
        avatarImageView.setAvatarImage(avatarUrl: user.avatarUrl)
        usernameLabel.text          = user.login
        nameLabel.text              = user.name ?? nil
        nameImageView.image         = user.name != nil
            ? SFSymnbols.haveName
            : SFSymnbols.noName
        
        locationImageView.image     = user.location != nil
            ? SFSymnbols.haveLocation
            : SFSymnbols.noLocation
        
        locationLabel.text          = user.location ?? nil
        bioLabel.text               = user.bio ?? "No Bio Available"
        
        
        // configure UI components
        nameImageView.translatesAutoresizingMaskIntoConstraints     = false
        nameImageView.tintColor         = .secondaryLabel
        nameImageView.contentMode       = .scaleAspectFit
        
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        locationImageView.tintColor     = .secondaryLabel
        locationImageView.contentMode   = .scaleAspectFit
        
        usernameLabel.numberOfLines     = 1
        nameLabel .numberOfLines        = 1
        bioLabel.numberOfLines          = 3
        locationLabel.numberOfLines     = 1
        
        // Set Constraints
        NSLayoutConstraint.activate([
            // Avatar Image
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            avatarImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            
            
            // Username Label
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: -4),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalTo: avatarImageView.heightAnchor, multiplier: 0.42),
            
            
            // Name Image
            nameImageView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 4),
            nameImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            nameImageView.heightAnchor.constraint(equalTo: avatarImageView.heightAnchor, multiplier: 0.27),
            nameImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor, multiplier: 0.27),
            
            
            // Name Label
            nameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor,constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: nameImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nameLabel.lastBaselineAnchor.constraint(equalTo: nameImageView.lastBaselineAnchor),
            
            
            // Location Image
            locationImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            locationImageView.heightAnchor.constraint(equalTo: avatarImageView.heightAnchor, multiplier: 0.27),
            locationImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor, multiplier: 0.27),
            
            
            // Location Label
            locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 8),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            locationLabel.lastBaselineAnchor.constraint(equalTo: locationImageView.lastBaselineAnchor),
            
            
            // Bio Label
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bioLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
    }
    
    


}
