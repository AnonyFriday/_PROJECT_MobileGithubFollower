//
//  GFTextField.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 15/10/20.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    private func configure() {
        #if DEBUG
        text = "sallen0400"
        #endif
        
        translatesAutoresizingMaskIntoConstraints = false
        
        // text
        textColor                       = .label // the color of text
        tintColor                       = .label // the indicator
        textAlignment                   = .center
        font                            = UIFont.preferredFont(forTextStyle: .title2) // font of the textfield
        adjustsFontSizeToFitWidth       = true
        minimumFontSize                 = 15
        autocorrectionType              = .no
        clearButtonMode                 = .always
        autocapitalizationType          = .none
        returnKeyType                   = .done // modify the presence
        
        // background
        backgroundColor                 = .tertiarySystemBackground
        
        // border
        layer.borderWidth               = 2
        layer.borderColor               = UIColor.systemGray3.cgColor
        layer.cornerRadius              = 12
        
        // placeholder
        placeholder                     = "Enter an username"
    }
}
