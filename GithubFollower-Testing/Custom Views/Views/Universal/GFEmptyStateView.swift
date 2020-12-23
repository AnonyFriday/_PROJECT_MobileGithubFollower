//
//  GFEmptyStateView.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 24/10/20.
//

import UIKit

class GFEmptyStateView: UIView {
    
    //MARK: Variables
    var messageLabel            = GFTitleLabel(textAlignment: .center, fontSize: 30)
    var placeholderImageView    = UIImageView()
    
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(message: String, in view: UIView) {
        self.init(frame: view.bounds)
        messageLabel.text = message
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: General Configure
    private func configure() {
        configureMessageLabel()
        configurePlaceHolderImageView()
    }
    
    //MARK: Configure Message Label
    private func configureMessageLabel() {
        self.addSubview(messageLabel)
        
        //Label
        messageLabel.numberOfLines  = 0
        messageLabel.textColor      = .secondaryLabel
        
        let configureConstraint : CGFloat = DeviceTypes.iPhoneSEGen2_Zoomed || DeviceTypes.iPhone8_Zoomed ? -100 : -200
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: configureConstraint),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
        ])
    }
    
    //MARK: Configure Placeholder ImageView
    private func configurePlaceHolderImageView() {
        self.addSubview(placeholderImageView)
        backgroundColor             = .systemBackground
        
        //ImageView
        placeholderImageView.image                                     = AssestImages.emptyStatelogo
        placeholderImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let configureTrailingAnchorConstant : CGFloat = DeviceTypes.iPhoneSEGen2_Zoomed || DeviceTypes.iPhone8_Zoomed ? 140 : 200
        NSLayoutConstraint.activate([
            placeholderImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: configureTrailingAnchorConstant),
            placeholderImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 20),
            placeholderImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            placeholderImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3)
        ])
    }
}
