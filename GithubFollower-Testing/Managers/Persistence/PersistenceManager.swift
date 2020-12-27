//
//  PersistenceManger.swift
//  GithubFollower-Testing
//
//  Created by Vu Kim Duy on 27/12/20.
//

import Foundation

fileprivate enum Key {
    static let favorite = "favorite"
}

enum Category {
    case add, delete
}

protocol Storable  {
    
    static func update(favorite: Favorite, with option: Category, completed: @escaping(GFError?) -> Void)
    static func retrieveFavorites(completed: @escaping (Result<[Favorite], GFError>) -> Void )
}

enum PersistenceManager: Storable{
    fileprivate static var defaults : UserDefaults = UserDefaults.standard
    
    fileprivate static func save(favorites: [Favorite]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            
            defaults.setValue(encodedFavorites, forKey: Key.favorite)
            return nil
        } catch {
            return .alreadyExistinFavorite
        }
    }
    
    static func update(favorite: Favorite, with option: Category, completed: @escaping (GFError?) -> Void) {
        retrieveFavorites { (result) in
            switch result {

            case .success(var favorites):
                switch option {
                
                case .add:
                    if !favorites.contains(where: { $0 == favorite}) {
                        favorites.append(favorite)
                    } else {
                        completed(.alreadyExistinFavorite)
                    }
                case .delete:
                    favorites.removeAll { $0 == favorite }
                }
                
                completed(save(favorites: favorites))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Favorite], GFError>) -> Void) {
        guard let favorites = defaults.value(forKey: Key.favorite) as? Data else {
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
