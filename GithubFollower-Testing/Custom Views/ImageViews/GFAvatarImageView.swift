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

    
    func setAvatarImage(avatarUrl: String) {
        NetworkManager.shared.getAvatarImage(avatarUrl: avatarUrl) { (image) in
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        clipsToBounds                             = true
        layer.cornerRadius                        = 10
        image                                     = AssestImages.avatarPlaceholder
    }
    
    
}
