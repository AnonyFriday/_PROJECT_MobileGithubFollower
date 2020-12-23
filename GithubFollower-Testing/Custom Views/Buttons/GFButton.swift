//
//  GFButton.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 15/10/20.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        //apply the custom in here
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, backgroundColor: UIColor) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        configure()
    }
    
    // MARK: - Configure
    private func configure() {
        self.layer.cornerRadius = 12
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        self.titleLabel?.textColor = .white
    
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: Set Background Color, Title on the fly
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor    = backgroundColor
        self.setTitle(title, for: .normal)
    }

}
