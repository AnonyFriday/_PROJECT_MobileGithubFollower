


import UIKit

/// Singleton Design Pattern
class NetworkManager {
    static var shared       = NetworkManager()
    private let baseUrl     = "https://api.github.com/users/"
    private var imageCache               = NSCache<NSString, UIImage>()
    
    private init() { return }
    
    // MARK: Get Followers
    /// - Parameters:
    ///   - username: username on github
    ///   - page: current page of followers list
    ///   - completionHandler: handle result given back from the server, then consider each case to deal with
    func downloadFollowers(username: String, page:Int, completionHandler: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completionHandler(.failure(.invalidUsername))
            return
        }
        
        // Handlering the response back from server
        getGHResponse(url: url, modelType: [Follower].self) { result in
            switch result {
            case .success(let followers):
                completionHandler(.success(followers))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    // MARK: Fetching Avatar Followers
    /// - Parameters:
    ///   - avatarUrl: avatarUrl
    ///   - completed: closure handlie the cached image
    /// - Returns: Void
    func fetchingAvatarFollowers(avatarUrl: String, completed: @escaping (UIImage) -> Void) -> Void {
        
        let keyCache = NSString(string: avatarUrl)
        if let cachedImage = imageCache.object(forKey: keyCache) {
            completed(cachedImage)
            return
        }
        
        else {
            guard let url = URL(string: avatarUrl) else { return }
            
            URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
                guard let self = self else { return }
                
                guard error == nil,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200,
                      let data = data
                else { return }
                
                guard let image = UIImage(data: data) else { return }
                
                self.imageCache.setObject(image, forKey: keyCache)
                
                DispatchQueue.main.async {
                    completed(image)
                    return
                }
            }.resume()
        }
        
    }
    
    
    // MARK: Download User
    /// - Parameters:
    ///   - username: username
    ///   - completed: return the closure which handles the result
    func downloadUser(username: String, completed: @escaping (Result<User, GFError>) -> Void) {
        let endPoint = baseUrl + "\(username)"
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        getGHResponse(url: url, modelType: User.self) { (result) in
            switch result {
            case .success(let user):
                completed(.success(user))
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    
    //MARK: - Private Section
    private func getGHResponse<T: Codable>(url: URL, modelType: T.Type, completed: @escaping (Result<T, GFError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completed(.failure(.invalidUsername))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy     = .convertFromSnakeCase
                decoder.dateDecodingStrategy    = .iso8601
                let result = try decoder.decode(modelType, from: data)
                completed(.success(result))
                
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}



































