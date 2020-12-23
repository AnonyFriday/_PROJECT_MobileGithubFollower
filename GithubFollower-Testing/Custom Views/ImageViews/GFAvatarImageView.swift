//
//  GFAvatarImageView.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 20/10/20.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Set Avatar Followers
    /// setImage
    /// - Parameter avatarUrl: avatarUrl
    func setAvatarImage(avatarUrl: String) {
        NetworkManager.shared.fetchingAvatarFollowers(avatarUrl: avatarUrl) { [weak self] (imageData) in
            guard let self = self else { return }
            self.image = imageData
            return
        }
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        clipsToBounds                             = true
        layer.cornerRadius                        = 10
        image                                     = AssestImages.avatarPlaceholder
    }
    
    
}
