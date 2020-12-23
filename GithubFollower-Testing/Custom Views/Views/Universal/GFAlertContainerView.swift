//
//  GFAlertContainerView.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 23/11/20.
//

import UIKit

class GFAlertContainerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.borderWidth                           = 1.5
        layer.cornerRadius                          = 20
        layer.borderColor                           = UIColor.white.cgColor
        backgroundColor                             = .systemBackground
        translatesAutoresizingMaskIntoConstraints   = false
    }
}
