//
//  GFItemProfileClassVC.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 30/10/20.
//

import UIKit

class GFItemProfileVC: GFItemSuperClassVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    private func configureViewController() {
        itemViewOne.setType(type: .repos, with: user.publicRepos)
        itemViewTwo.setType(type: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPink, title: "Github Profile")
    }
    
    override func didTappedActionButton() {
        delegate.itemInforVC(self, showSafariForProfile: user)
    }
    
}
