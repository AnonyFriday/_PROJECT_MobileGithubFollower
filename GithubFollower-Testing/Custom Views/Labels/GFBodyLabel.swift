//
//  GFBodyLabel.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 18/10/20.
//

import UIKit

class GFBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        font                                        = UIFont.preferredFont(forTextStyle: .body)
        textColor                                   = .label // will modify it later
        translatesAutoresizingMaskIntoConstraints   = false
        adjustsFontSizeToFitWidth                   = true
        minimumScaleFactor                          = 0.75
        lineBreakMode                               = .byWordWrapping
        
    }

}
