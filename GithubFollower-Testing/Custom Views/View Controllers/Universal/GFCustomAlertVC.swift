//
//  GFCustomAlertVC.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 18/10/20.
//

import UIKit









class GFCustomAlertVC: UIViewController {
    
    //MARK: - Global Variables
    let containerView           = GFAlertContainerView(frame: .zero)
    let actionButton            = GFButton(title: "ok", backgroundColor: .systemPink)
    let titleLabel              = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let errorMesssageLabel      = GFBodyLabel(textAlignment: .center)
    
    var textForTitle: String?
    var textForBody: String?
    var textForButton: String?
    var paddingComponents: CGFloat = 20.0
    
    init(textForTitle: String, textForBody: String, textForButton: String) {
        super.init(nibName: nil, bundle: nil)
        self.textForBody    = textForBody
        self.textForTitle   = textForTitle
        self.textForButton  = textForButton
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.75)
        
        configureContainerView()
        configureTitleLabel()
        configureButton()
        configureBodyLabel()
    }
    
    //MARK: Configured Container View
    func configureContainerView() {
        view.addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 220),
            containerView.widthAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    //MARK: Configured Title Label
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        
        titleLabel.text = textForTitle ?? "Something went wrong"
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: paddingComponents),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -paddingComponents),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: paddingComponents),
            titleLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
    }
    
    //MARK: Configured Button
    func configureButton() {
        containerView.addSubview(actionButton)
        
        actionButton.setTitle(textForButton ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissByActionButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -paddingComponents),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -paddingComponents),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: paddingComponents),
            actionButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.2),
        ])
        
    }
    
    //MARK: Configured Body Label
    func configureBodyLabel() {
        containerView.addSubview(errorMesssageLabel)
        
        errorMesssageLabel.numberOfLines    = 0
        errorMesssageLabel.text             = textForBody ?? "Unable to complete request"
        
        NSLayoutConstraint.activate([
            errorMesssageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            errorMesssageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -8),
            errorMesssageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -paddingComponents),
            errorMesssageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: paddingComponents),
        ])
        
    }
    
    //MARK: - Dismiss the alertview
    @objc func dismissByActionButton() {
        dismiss(animated: true)
    }
}
