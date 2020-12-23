//
//  GFItemSuperClassVC.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 30/10/20.
//

import UIKit

class GFItemSuperClassVC: UIViewController {

    let stackView       = UIStackView()
    let itemViewOne     = GFChildItemView()
    let itemViewTwo     = GFChildItemView()
    let actionButton    = GFButton()
    
    var user            : User!
    weak var delegate   : UserInforVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubViews(views: stackView, actionButton)
        
        configureViewController()
        addViewsToStackView()
        configureUILayouts()
        configureActionButton()
    }
    
    //MARK: Initializer
    init(user: User!) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Configure VC
    private func configureViewController() {
        view.backgroundColor    = .systemFill
        view.layer.cornerRadius = 18
        
    }
    
    
    //MARK: - add subViews to stackView
    private func addViewsToStackView() {
        stackView.addArrangedSubViews(views: [itemViewOne, itemViewTwo])
        stackView.distribution  = .equalSpacing
        stackView.axis          = .horizontal
    }
    
    //MARK: - configure UILayouts
    
    private func configureUILayouts() {
        stackView.translatesAutoresizingMaskIntoConstraints     = false
        
        let padding: CGFloat                                    = 20.0
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
        ])
    }
    
    //MARK: Configure Action Button
    func configureActionButton() {
        actionButton.addTarget(self, action: #selector(didTappedActionButton), for: .touchUpInside)
    }
    
    @objc func didTappedActionButton() { return }

}
