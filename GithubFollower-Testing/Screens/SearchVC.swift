//
//  SearchVC.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 15/10/20.
//

import UIKit

class SearchVC: UIViewController {
    
    //MARK: - Global Variables
    let logoImageView: UIImageView!     = UIImageView()
    let usernameTextField: UITextField! = GFTextField()
    let searchingButton: UIButton!      = GFButton(title: "Search", backgroundColor: .systemGreen)
    var isUsernameEmpty: Bool {
        return usernameTextField.text!.isEmpty
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureLogoImageView()
        configureUsernameTextField()
        configureSearchingButton()
        dismissKeyboard()
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    
    // Second Solution
    func dismissKeyboard(){
        let tap = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    // MARK: Push FollowersListVC
    @objc func pushFollowersListVC () {
        guard !isUsernameEmpty else {
            presentGFAlertOnMainThread(alertTitle: "Empty Username",
                                       body: "There is nothing to do with the empty username, please add something for it 😃",
                                       buttonTitle: "Ok")
            return
        }
        
        let followerListVC          = FollowersListVC(username: usernameTextField.text!)
        navigationController?.pushViewController(followerListVC, animated: true)
        
        self.usernameTextField.text?.removeAll()
    }
    
    
    // MARK: - Configure Image View
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image                                     = AssestImages.ghLogo
        
        //Set Constraints
        let configureTopAnchorConstant : CGFloat  = DeviceTypes.iPhone8_Zoomed || DeviceTypes.iPhoneSEGen2_Zoomed || DeviceTypes.iPhoneSEGen2_Standard ? 20 : 80
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: configureTopAnchorConstant),
            logoImageView.widthAnchor.constraint(equalToConstant: 220),
            logoImageView.heightAnchor.constraint(equalToConstant: 220),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Configure Text Field
    func configureUsernameTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self // assign the delegate of view in to the uitextfield => it will recognize the usernameTextFieldDelegate
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    // MARK: - Configure Button
    func configureSearchingButton() {
        view.addSubview(searchingButton)
        
        searchingButton.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            searchingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            searchingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchingButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - Extension
extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersListVC()
        view.endEditing(true) // dismiss the keyboard
        return true
    }
}
