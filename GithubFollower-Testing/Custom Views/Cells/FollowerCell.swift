//
//  FollowerCell.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 20/10/20.
//

import UIKit


class FollowerCell: UICollectionViewCell {
    // Reusable Identifier
    static var reuseIdCell: String {
        return String(describing: self)
    }
    
    // Variables
    let avatarImageView     = GFAvatarImageView(frame: .zero)
    var usernameTitleLabel  = GFTitleLabel(textAlignment: .center, fontSize: 16)
    let padding: CGFloat    = 10.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(follower: Follower) {
        self.usernameTitleLabel.text       = follower.login
        self.avatarImageView.setAvatarImage(avatarUrl: follower.avatarUrl)
    }
  
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(avatarImageView)
        addSubview(usernameTitleLabel)
        
        NSLayoutConstraint.activate([
            //MARK: - Set Contraints ImageView
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            //MARK: - Set Contraints Title
            usernameTitleLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
            usernameTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
        ])
    }
}
