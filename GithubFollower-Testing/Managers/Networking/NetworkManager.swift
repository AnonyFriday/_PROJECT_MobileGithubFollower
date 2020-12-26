
import UIKit

/// Singleton Design Pattern
class NetworkManager {
    static var shared           = NetworkManager()
    private let baseUrl         = "https://api.github.com/users/"
    private var imageCache      = NSCache<NSString, UIImage>()
    
    private init() { return }
    
    
    // MARK: Get Followers
    func downloadFollowers(username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        requestDynamicData(.getFollowers(from: username, page: page), modelType: [Follower].self) { (result) in
            switch result {
            case .success(let followers):
                completed(.success(followers))
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    
    // MARK: Fetching Avatar Followers
    func fetchingAvatarFollowers(avatarUrl: String, completed: @escaping (UIImage?) -> Void) -> Void {
        requestStaticAvatarImage(endpoint: .getImage(from: avatarUrl)) { (image) in
            completed(image)
        }
    }
    
    
    // MARK: Download User
    func downloadUser(username: String, completed: @escaping (Result<User, GFError>) -> Void) {
        requestDynamicData(.getUser(from: username), modelType: User.self) { (result) in
            switch result {
            case .success(let user):
                completed(.success(user))
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    
    
    
    
    /*********************************************************Private Section*******************************************************************************/
    //MARK: - Request Dynamic Data
    fileprivate func requestDynamicData<T: Codable>(_ endpoint: EndpointManager,
                                        modelType: T.Type,
                                        completed: @escaping (Result<T,GFError>) -> Void) {
        guard let url = endpoint.url else {
            completed(.failure(.invalidUsername))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                
                completed(.failure(.invalidData))
                return
            }
            
            guard let response        = response as? HTTPURLResponse,
                response.statusCode == 200
            else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder                     = JSONDecoder()
                decoder.keyDecodingStrategy     = .convertFromSnakeCase
                decoder.dateDecodingStrategy    = .iso8601
                let data                        = try decoder.decode(T.self, from: data)
                
                completed(.success(data))
        
            } catch {
                completed(.failure(.invalidData))
            }
        }.resume()
    }
    
    
    //MARK: Request Static Data
    func requestStaticAvatarImage<T: UIImage>(endpoint: EndpointManager,
                                         completed: @escaping (T?) -> Void) {
        
        guard let staticUrl = endpoint.staticUrl else {
            completed(nil)
            return
        }
        
        let keyCache = NSString(string: staticUrl.absoluteString)
        
        if let image = CacheManager.getImageFromKey(keyCache) {
            completed(image as? T)
        } else {
            URLSession.shared.dataTask(with: staticUrl) { (data, response, error) in
                guard error == nil,
                      let response = response as? HTTPURLResponse,
                      response.statusCode   == 200,
                      let data = data
                else {
                    completed(nil)
                    return
                }
                
                guard let image = UIImage(data: data) else {
                    completed(nil)
                    return
                }
                
                completed(image as? T)
            }.resume()
        }
           
        
        
        
    }
}



































