//
//  UserInforVC.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 27/10/20.
//

import UIKit

protocol UserInforVCDelegate: class {
    func itemInforVC(_ itemInforVC: UIViewController, showSafariForProfile user: User)
    func itemInforVC(showFollowersOf user: User)
}

class UserInforVC: UIViewController {
    
    //MARK: - Global Variables
    private var username             : String!

    private var headerView           : UIView       = UIView()
    private var itemContainerViewOne : UIView       = UIView()
    private var itemContainerViewTwo : UIView       = UIView()
    private var dateLabel            : GFBodyLabel  = GFBodyLabel(textAlignment: .center)
    
    weak var delegate                : FollowersListVCDelegate!
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("Required Initialization")
    }

    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureContainerView()
        getUserInfor()
    }
    
    //MARK: - configure View Controller
    private func configureViewController() {
        self.view.backgroundColor           = .systemBackground
        navigationItem.rightBarButtonItem   = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewControler))
        navigationItem.leftBarButtonItem    = UIBarButtonItem(image: SFSymnbols.thumbUpFavorite, style: .done, target: self, action: #selector(favoriteUser))
    }
    
    //MARK: -- Dismiss View Controller
    @objc func dismissViewControler() {
        dismiss(animated: true) {
            self.view = nil
        }
    }
    
    //MARK: -- Favorite User
    @objc func favoriteUser() {
        NetworkManager.shared.downloadUser(username: self.username) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                let favorite = Favorite(login: user.login, avatar_url: user.avatarUrl)
                PersistanceManager.updatingWith(favorite: favorite, categoryType: .add) { [weak self] (error) in
                    guard let self = self else { return }
                    guard let error = error else {
                        self.presentGFAlertOnMainThread(alertTitle: "Saved Successfully", body: "You have favorited this guy successfully. Congratulation 🎉", buttonTitle: "Hoorayy")
                        return
                    }
                    self.presentGFAlertOnMainThread(alertTitle: "Already Favorited", body: error.rawValue, buttonTitle: "Ok")
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(alertTitle: "Something went wrong", body: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    //MARK: - Get user infor
    private func getUserInfor() {
        NetworkManager.shared.downloadUser(username: username) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(user: user)}
            case . failure(let error):
                self.presentGFAlertOnMainThread(alertTitle: "Something went wrong", body: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    //MARK: -- configure Ui Elements
    func configureUIElements(user: User) {
        self.add(childVC: GFHeaderUserInforVC(user: user), into: self.headerView)
        
        let profileItemVC                              = GFItemProfileVC(user: user)
        profileItemVC.bodyUserInforProps.delegate      = self
        self.add(childVC: profileItemVC, into: self.itemContainerViewOne)
        
        let followersItemVC                            = GFItemFollowersVC(user: user)
        followersItemVC.bodyUserInforProps.delegate    = self
        self.add(childVC: followersItemVC, into: self.itemContainerViewTwo)
    }
    

    //MARK: - Add childVC into the ContainerView
    func add(childVC: UIViewController, into containerView: UIView) {
        self.addChild(childVC)
        containerView.addSubview(childVC.view)
        
        childVC.view.frame  = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    //MARK: - Configure Header View
    func configureContainerView() {
        let padding : CGFloat                    = 20
        let arrayOfContainerViews: Array<UIView> = [headerView, itemContainerViewOne, itemContainerViewTwo, dateLabel]
        
        // Universal Configuration
        self.view.addSubViews(views: headerView, itemContainerViewOne, itemContainerViewTwo, dateLabel)
        arrayOfContainerViews.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding),
                view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            headerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            
            itemContainerViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            itemContainerViewOne.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.27),
            
            itemContainerViewTwo.topAnchor.constraint(equalTo: itemContainerViewOne.bottomAnchor, constant: 16),
            itemContainerViewTwo.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.27),
            
            dateLabel.topAnchor.constraint(equalTo: itemContainerViewTwo.bottomAnchor, constant: 4),
            dateLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
        ])
    }
}

//MARK: Extension
extension UserInforVC: UserInforVCDelegate {

    // Show Profile's Safari
    func itemInforVC(_ itemInforVC: UIViewController, showSafariForProfile user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            self.presentGFAlertOnMainThread(alertTitle: "Invalid URL",
                                            body: "There was something wrong with the URL. Please try again 😢",
                                            buttonTitle: "OK")
            return
        }
        
        self.openSafariWebBrowser(url: url)
    }
    
    // Show the followers Collection View
    // Dismiss the current VC
    func itemInforVC(showFollowersOf user: User) {
        delegate.userInforVC(self, didReceivedUsername: user.login)
    }
}
