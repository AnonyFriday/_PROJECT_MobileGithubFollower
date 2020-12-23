//
//  GFChildItemView.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 30/10/20.
//

import UIKit

enum ItemTypeInfo: String {
    case repos      = "Public Repos"
    case gists      = "Public Gists"
    case following  = "Following"
    case followers  = "Followers"
    
    func getType() -> (title: String, symbol: UIImage?){
        switch self {
        case .repos:
            return (self.rawValue, SFSymnbols.repos)
        case .gists:
            return (self.rawValue, SFSymnbols.gists)
        case .following:
            return (self.rawValue, SFSymnbols.following)
        case .followers:
            return (self.rawValue, SFSymnbols.followers)
        }
    }
}

class GFChildItemView: UIView {
    
    let symbolImageView = UIImageView()
    let typeLabel       = GFTitleLabel(textAlignment: .left, fontSize: 18)
    let countLabel      = GFTitleLabel(textAlignment: .center, fontSize: 18)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addSubViews(views: symbolImageView, typeLabel, countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints       = false
        symbolImageView.contentMode     = .scaleAspectFit
        symbolImageView.tintColor       = .label
        
        typeLabel.numberOfLines         = 1
        countLabel.numberOfLines        = 1
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            symbolImageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            
            typeLabel.topAnchor.constraint(equalTo: symbolImageView.topAnchor),
            typeLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 10),
            typeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            typeLabel.lastBaselineAnchor.constraint(equalTo: symbolImageView.lastBaselineAnchor),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4.0),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 25),
            
        ])
    }
    
    func setType(type: ItemTypeInfo, with count: Int) {
        let data                = type.getType()
        symbolImageView.image   = data.symbol
        typeLabel.text          = data.title
        countLabel.text         = String(count)
    }
    
    
    
    

   

}
