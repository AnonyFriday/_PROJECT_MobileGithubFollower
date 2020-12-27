

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    
    func getFollowers(username: String, page: Int, completed: @escaping (Result<[Follower],GFError>) -> Void) {
        requestDynamicUrl(endpoint: .getFollowers(username: username, page: page), modelType: [Follower].self) { (result) in
            
            switch result {
            case .success(let followers):
                completed(.success(followers))
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    
    func getUser(username: String, completed: @escaping (Result<User,GFError>) -> Void) {
        requestDynamicUrl(endpoint: .getUser(username: username), modelType: User.self) { (result) in
            
            switch result {
            case .success(let user):
                completed(.success(user))
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    
    func getAvatarImage(avatarUrl: String, completed: @escaping (UIImage?) -> Void) {
        requestStaticAvatarUrl(endpoint: .getAvatarImage(avatarUrl: avatarUrl)) { (image) in
            completed(image)
        }
    }
    
}


extension NetworkManager {
    fileprivate func requestDynamicUrl<T: Codable>(endpoint: EndpointManager,
                                                modelType: T.Type,
                                                completed: @escaping(Result<T,GFError>) -> Void) {
        guard let url = endpoint.urlGithub else {
            completed(.failure(.invalidUsername))
            return
        }
        
    
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                completed(.failure(.invalidUsername))
                return
            }
            
            
            guard let response        = response as? HTTPURLResponse,
                  response.statusCode == 200
            else {
                completed(.failure(.invalidResponse))
                return
            }
            
            
            guard let data            = data else {
                completed(.failure(.invalidData))
                return
            }
            
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                decoder.keyDecodingStrategy  = .convertFromSnakeCase
                let decodedData              = try decoder.decode(T.self, from: data)
                completed(.success(decodedData))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
    }
    
    fileprivate func requestStaticAvatarUrl(endpoint: EndpointManager, completed: @escaping(UIImage?) -> Void) {
        guard let url = endpoint.urlAvatarImage else {
            completed(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data
            else {
                completed(nil)
                return
            }
            
            guard let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            completed(image)
        }
    }
}
