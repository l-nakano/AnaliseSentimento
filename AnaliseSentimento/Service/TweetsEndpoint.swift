import Foundation
import Alamofire

struct TweetsEndpoint {
    private var scheme: String = "https"
    private var host: String = "api.twitter.com/2"
    private var path: String = "/tweets/search/recent"
    private var query: String = "?query="
    private var queryItems: String
}

extension TweetsEndpoint {
    var url: String {
        return scheme + "://" + host + path + query + queryItems.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var headers: HTTPHeaders {
        return ["Authorization": "Bearer AAAAAAAAAAAAAAAAAAAAAOv1UQEAAAAA3MLr1C7mtA7pquHZJnk5mGLWXug%3DelLUznFpVNW7BuuSBLuODqmO1DFrlCq8eYWj56i5zvGd6E9fLu"]
    }
    
    static func fromUser(_ user: String) -> Self {
        return TweetsEndpoint(queryItems: "from:\(user)")
    }
}
