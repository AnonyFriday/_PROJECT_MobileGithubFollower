//
//  UIStackView+Ext.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 24/11/20.
//

import UIKit

extension UIStackView {
    //MARK: Add views to Stack View
    func addArrangedSubViews(views: [UIView]) {
        views.forEach { (view) in
            self.addArrangedSubview(view)
        }
    }
}
