//
//  UserInforVC.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 27/10/20.
//

import UIKit

protocol UserInforVCDelegate: AnyObject {
    func userInforVC(_ userInforVC: UIViewController, didReceivedUsername username: String)
}

class UserInforVC: UIViewController {
    
    //MARK: - Global Variables
    private var username             : String!

    private var headerView           : UIView       = UIView()
    private var itemContainerViewOne : UIView       = UIView()
    private var itemContainerViewTwo : UIView       = UIView()
    private var dateLabel            : GFBodyLabel  = GFBodyLabel(textAlignment: .center)
    
    private var scrollView           : UIScrollView!
    private var contentView          : UIView!
    
    weak var delegate                : UserInforVCDelegate!
    
    
    //MARK: Init
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
        configureScrollView()
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
        NetworkManager.shared.getUser(username: self.username) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                let favorite = Favorite(login: user.login, avatar_url: user.avatarUrl)
                PersistenceManager.update(favorite: favorite, with: .add) { [weak self] (error) in
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
        NetworkManager.shared.getUser(username: username) { [weak self] (result) in
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
        
        let profileItemVC                              = GFBodyProfileUserInforVC(user: user, delegateTarget: self)
        self.add(childVC: profileItemVC, into: self.itemContainerViewOne)
        
        let followersItemVC                            = GFBodyFollowersUserInforVC(user: user, delegateTarget: self)
        self.add(childVC: followersItemVC, into: self.itemContainerViewTwo)
        
        dateLabel.text                                 = user.createdAt.convertToMonthYearString()
    }
    

    //MARK: - Add childVC into the ContainerView
    func add(childVC: UIViewController, into containerView: UIView) {
        self.addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame  = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    //MARK: - Configure Scroll View
    func configureScrollView() {
        scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        
        let configureDevice = DeviceTypes.iPhoneSEGen2_Standard || DeviceTypes.iPhoneSEGen2_Zoomed || DeviceTypes.iPhone8_Zoomed
        scrollView.showsVerticalScrollIndicator = configureDevice
        scrollView.isScrollEnabled = configureDevice
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        contentView = UIView()
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 700),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    
    
    //MARK: - Configure Header View
    func configureContainerView() {
        let padding : CGFloat                    = 20
        let arrayOfContainerViews: Array<UIView> = [headerView, itemContainerViewOne, itemContainerViewTwo, dateLabel]
        
        // Universal Configuration
        self.contentView.addSubViews(views: headerView, itemContainerViewOne, itemContainerViewTwo, dateLabel)
        arrayOfContainerViews.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            ])
        }
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemContainerViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 22),
            itemContainerViewOne.heightAnchor.constraint(equalToConstant: 180),
            
            itemContainerViewTwo.topAnchor.constraint(equalTo: itemContainerViewOne.bottomAnchor, constant: 22),
            itemContainerViewTwo.heightAnchor.constraint(equalToConstant: 180),
            
            dateLabel.topAnchor.constraint(equalTo: itemContainerViewTwo.bottomAnchor, constant: 16),
        ])
    }
}


//MARK: Extension
extension UserInforVC: GFBodyProfileUserInforVCDelegate {
    
    func profileUserInforVC(_ profileUserInforVC: GFBodyProfileUserInforVC, willGetProfileOf user: User) {
        guard let urlProfile = URL(string: user.htmlUrl) else { return }
        self.openSafariWebBrowser(url: urlProfile)
    }
}


extension UserInforVC: GFBodyFollowersUserInforVCDelegate {
    
    func followersUserInforVC(_ followersUserInforVC: GFBodyFollowersUserInforVC, willGetFollowersOf user: User) {
        delegate.userInforVC(self, didReceivedUsername: user.login)
        dismissViewControler()
    }
}
