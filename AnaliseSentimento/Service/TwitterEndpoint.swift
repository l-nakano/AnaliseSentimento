import Foundation
import Alamofire

struct TwitterEndpoint {
    var path: String
    var queryItems: [URLQueryItem]
    
    static func twitterUser(_ user: String) -> Self {
        return  TwitterEndpoint(path: "/users/by/username/\(user)", queryItems: [URLQueryItem(name: "user.fields", value: "profile_image_url,created_at,location,description")])
    }
    
    static func userTwitts(from user: String) -> Self {
        return  TwitterEndpoint(path: "/tweets/search/recent", queryItems: [URLQueryItem(name: "query", value: "from:\(user)")])
    }
}

extension TwitterEndpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.twitter.com"
        components.path = "/2" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components \(components)")
        }
        
        return url
    }
    
    var headers: HTTPHeaders {
        let apiToken = Bundle.main.infoDictionary?["BEARER_TOKEN"] as? String
        return ["Authorization": "Bearer \(apiToken!)"]
    }
}
