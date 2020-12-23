//
//  UIHelper.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 23/10/20.
//

import UIKit

enum UIHelper {
    
    //MARK: -- Custom Flow Layout
    static func customViewFlowLayout(in view: UIView) -> UICollectionViewFlowLayout{
        
        let minimumInteritemSpacing: CGFloat    = 6
        let padding: CGFloat                    = 16
        let minimumLineSpacing: CGFloat         = 8
        let availableSpace                      = view.bounds.width - minimumInteritemSpacing * 2 - padding * 2
        let itemWidth: CGFloat                  = availableSpace / 3
        let itemHeight: CGFloat                 = itemWidth + 20
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize                 = .init(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing  = minimumInteritemSpacing
        layout.sectionInset             = .init(top: padding, left: padding, bottom: padding, right: padding)
        layout.minimumLineSpacing       = minimumLineSpacing
        
        return layout
    }
}
