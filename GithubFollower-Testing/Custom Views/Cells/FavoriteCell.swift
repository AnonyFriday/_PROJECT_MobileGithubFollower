//
//  FavoritesCell.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 14/11/20.
//

import UIKit

class FavoriteCell: UITableViewCell {

    //MARK: Default
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: Variables
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    private var avatarImageView = GFAvatarImageView(frame: .zero)
    private var usernameTitle   = GFTitleLabel(textAlignment: .left, fontSize: 32)
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Set Data For The Cell
    func setDataForCell(favorite: Favorite) {
        usernameTitle.text       = favorite.login
        avatarImageView.setAvatarImage(avatarUrl: favorite.avatar_url)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8.0, left: 20.0, bottom: 8.0, right: 20.0))
    }
    
    //MARK: Configure
    private func configure() {
        contentView.addSubViews(views: avatarImageView, usernameTitle)
        accessoryType = .disclosureIndicator
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),
            
            usernameTitle.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            usernameTitle.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            usernameTitle.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20.0),
        ])
    }

}
