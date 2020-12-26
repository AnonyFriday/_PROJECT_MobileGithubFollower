//
//  FollowersListVC.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 17/10/20.
//

import UIKit



class FollowersListVC: UIViewController, GFLoadable {
    
    //MARK: - Protocol Endpoint
    var loadableProperties: GFLoadableProperties = GFLoadableProperties()
    
    //MARK: - Global Variables
    var username                : String!
    var followers               : [Follower] = []
    var filteredFollowers       : [Follower] = []
    var currentPage             : Int = 1
    var hasMoreFollowers        : Bool = true
    var isSearching             : Bool = false
    var isLoadingFollowers      : Bool = false
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: - Search Variables
    var searchController        : UISearchController!
    
    //MARK: - CollectionView Variables
    enum SectionCollectionView { case main }
    var collectionView      : UICollectionView!
    var diffableDatasource  : UICollectionViewDiffableDataSource<SectionCollectionView, Follower>!
    var snapShot            : NSDiffableDataSourceSnapshot<SectionCollectionView, Follower>!
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureSearchController()
        configureCollectionView()
        configureDiffableDataSource()
        
        getFollowers(username: username, currentPage: currentPage)
    }
    
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)

    }
    
    
    
    //MARK: - Initializer
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        self.title    = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - cfg ViewController
    private func configureViewController(){
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.prefersLargeTitles  = true
        navigationItem.setRightBarButton(UIBarButtonItem(image: .add, style: .done, target: self, action: #selector(addUserToFavorites)), animated: true)
    }
    
    //MARK: -- configure Add Favorites
    @objc private func addUserToFavorites() {
        showLoadingView()
        NetworkManager.shared.downloadUser(username: username) { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            
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
    
    //MARK: - getFollowers
    func getFollowers(username: String, currentPage: Int) {
        showLoadingView()
        isLoadingFollowers = true
        
        NetworkManager.shared.downloadFollowers(username: username, page: currentPage) { [weak self] (result) in
            guard let self = self else { return } // because self cannot be nil
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                self.updateUI(followers)
            
            case .failure(let errorMessage):
                self.presentGFAlertOnMainThread(alertTitle: "Networking Failed", body: errorMessage.rawValue, buttonTitle: "Ok")
            }
            self.isLoadingFollowers = false
        }
    }
    
    //MARK: -- updateUI
    fileprivate func updateUI(_ followers: ([Follower])) {
        if followers.count < 100 { self.hasMoreFollowers = false }
        
        self.followers.append(contentsOf: followers) // append the followers for each page, not just render 1 page
        
        if self.followers.isEmpty { DispatchQueue.main.async { self.showEmptyState(message: "This user doesn't have any followers! 😭", in: self.view) }}
        
        self.configureDiffableSnapshot(in: self.followers)
        if self.isSearching {
            DispatchQueue.main.async {
                self.updateSearchResults(for: self.searchController)
            }
        }
    }
    
    //MARK: cfg CollectionView
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.customViewFlowLayout(in: view))
        
        view.addSubview(collectionView)
        collectionView.backgroundColor      = .systemBackground
        collectionView.alwaysBounceVertical = true
        
        collectionView.delegate             = self
        
        // Register cell for collection view
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseIdCell)
    }
    
    //MARK: -- cfg Search Controller
    private func configureSearchController() {
        searchController                                            = UISearchController()
        searchController.searchBar.autocapitalizationType           = .none
        searchController.searchBar.autocorrectionType               = .no
        searchController.searchBar.searchTextField.backgroundColor  = .quaternaryLabel
        searchController.searchBar.barTintColor                     = .systemGreen
        searchController.searchBar.placeholder                      = "Search an username"
        searchController.obscuresBackgroundDuringPresentation       = false
        searchController.searchResultsUpdater                       = self
        
        self.navigationItem.searchController                        = searchController
        self.navigationItem.hidesSearchBarWhenScrolling             = false
    }
    
    //MARK: -- cfg Diffable DataSource
    private func configureDiffableDataSource(){
        diffableDatasource = UICollectionViewDiffableDataSource<SectionCollectionView, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseIdCell, for: indexPath) as! FollowerCell
            cell.setData(follower: follower)
            
            return cell
        })
    }
    
    //MARK: -- cfg Diffable Snapshot
    private func configureDiffableSnapshot(in followers: [Follower]) {
        snapShot = NSDiffableDataSourceSnapshot<SectionCollectionView, Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        
        DispatchQueue.main.async { [self] in
            self.diffableDatasource.apply(snapShot, animatingDifferences: true)
        }
    }
    
    
    
}

//MARK: Extension


//MARK: -- UICollectionViewDelegateFlowLayout
extension FollowersListVC: UICollectionViewDelegateFlowLayout {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let tabBarController = tabBarController as? GFTabbarController else { return }
        
        if (scrollView.panGestureRecognizer.translation(in: scrollView).y < 0) {
            tabBarController.setTabbarHidden(hidden: true, animated: true)
        } else {
            tabBarController.setTabbarHidden(hidden: false, animated: true)
        }
    }
    
    // Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSetY         = scrollView.contentOffset.y
        let frameHeight     = scrollView.frame.size.height
        let contentHeight   = scrollView.contentSize.height
        
        // iterate the getFollower calling when it comes to the next page && nextFollower = 100
        if offSetY > contentHeight - frameHeight {
            guard hasMoreFollowers, !isLoadingFollowers else { return }
            currentPage += 1
            getFollowers(username: username, currentPage: currentPage)
        }
    }
    
    // Did Select Item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower = isSearching ? filteredFollowers[indexPath.item] : followers[indexPath.item]
        
        let destVC = UserInforVC(username: follower.login)
        destVC.delegate = self
        
        let navVC = UINavigationController(rootViewController: destVC)
        present(navVC, animated: true)
    }
}


//MARK: -- UISearchResultUpdating
extension FollowersListVC: UISearchResultsUpdating {
    
    // Observe Value Changes at Search Bar
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchQuery = searchController.searchBar.text, !searchQuery.isEmpty else {
            filteredFollowers.removeAll()
            isSearching = false
            configureDiffableSnapshot(in: followers)
            return
        }
        
        filteredFollowers = self.followers.reduce([Follower](), { (acc, curr: Follower) -> [Follower] in
            var acc = acc
            if curr.login.lowercased().contains(searchQuery.lowercased()) { acc.append(curr) }
            return acc
        })
        
        isSearching = true
        configureDiffableSnapshot(in: filteredFollowers)
    }
}

//MARK: -- FollowersListVCDelegate
extension FollowersListVC: UserInforVCDelegate {
    func userInforVC(_ userInforVC: UIViewController, didReceivedUsername username: String) {
    
        followers.removeAll()
        filteredFollowers.removeAll()
        hasMoreFollowers                = true
        currentPage                     = 1
        title                           = username
        self.username                   = username
        
        getFollowers(username: username, currentPage: currentPage)
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
}
