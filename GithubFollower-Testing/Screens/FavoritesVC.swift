//
//  FavoritesVC.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 14/11/20.
//

import UIKit

class FavoritesVC: UIViewController, GFLoadable {
    var loadableProperties: GFLoadableProperties = GFLoadableProperties()
    
    //MARK: Variables
    var favorites: [Favorite] = []
    
    //MARK: Table View Components
    var tableView = UITableView()
    
    
    //MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        getFavorites()
    }
    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    private func configureViewController() {
        title                       = "Favorites"
        self.view.backgroundColor   = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    //MARK: Configure Table View
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame           = view.bounds
        tableView.backgroundColor = .systemBackground
        tableView.rowHeight       = 80.0
        tableView.separatorStyle  = .none
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseIdentifier)
        tableView.dataSource      = self
        tableView.delegate        = self
    }
    //MARK: Get Favorites
    private func getFavorites() {
        PersistanceManager.retrieveFavorites { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success( let favorites):
                if favorites.isEmpty {
                    self.showEmptyState(message: "No Favorites", in: self.view)
                } else {
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            
            case .failure(let error):
                self.presentGFAlertOnMainThread(alertTitle: "Something went wrong", body: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
   
}

extension FavoritesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        
        let destVC = FollowersListVC(username: favorite.login)
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        PersistanceManager.updatingWith(favorite: favorite, categoryType: .remove) { [weak self](error) in
            guard let self = self else { return }
            guard let error = error else {
                self.presentGFAlertOnMainThread(alertTitle: "Removed Successfully", body: "\(favorite.login) has been defavorited.😢 ", buttonTitle: "Ok")
                return
            }
            
            self.presentGFAlertOnMainThread(alertTitle: "Something went wrong", body: error.rawValue, buttonTitle: "Ok")
        }
        
    }
}

extension FavoritesVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseIdentifier, for: indexPath) as! FavoriteCell
        cell.setDataForCell(favorite: favorites[indexPath.row])
        cell.setSelected(true, animated: true)
        
        return cell
    }
    
    
}
