//
//  PersistanceManage.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 9/11/20.
//

import Foundation

enum CategoryType {
    case add, remove
}

fileprivate enum Key {
    static let favorites = "Favorites"
}

enum PersistanceManager {
    static private let defaults = UserDefaults.standard
    
    //MARK: Updating favorites list after configurationg new guy relevant to the crews
    static func updatingWith(favorite: Favorite, categoryType: CategoryType, completed: @escaping (GFError?) -> Void) {
        retrieveFavorites { (result) in
            switch result {
            case .success(let favorites):
                var modifiableFavorites = favorites
                switch categoryType {
                case .add:
                    guard !modifiableFavorites.contains(favorite) else {
                        completed(.alreadyExistinFavorite)
                        return
                    }
                    modifiableFavorites.insert(favorite, at: 0)
                case .remove:
                    modifiableFavorites.removeAll { $0 == favorite }
                }
                completed(save(favorites: modifiableFavorites))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    //MARK: Save the decoded favorites into the local store
    static private func save(favorites: [Favorite]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.setValue(encodedFavorites, forKey: Key.favorites)
            return nil
        } catch {
            return .unableSaveFavorite
        }
    }
    
    
    //MARK: Retrieving the favoritess based on the given key
    static func retrieveFavorites( completed: @escaping (Result<[Favorite], GFError>) -> Void) {
        guard let favorites = defaults.object(forKey: Key.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let decodedFavorites = try decoder.decode([Favorite].self, from: favorites)
            completed(.success(decodedFavorites))
        } catch {
            completed(.failure(.unableGetFavorites))
        }
        
    }
    
    
}
