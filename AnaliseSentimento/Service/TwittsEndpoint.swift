import Foundation
import Alamofire

struct TwittsEndpoint {
    private var scheme: String = "https"
    private var host: String = "api.twitter.com/2"
    private var path: String = "/tweets/search/recent"
    private var query: String = "?query="
    private var queryItems: String
}

extension TwittsEndpoint {
    var url: String {
        return scheme + "://" + host + path + query + queryItems.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var headers: HTTPHeaders {
        let apiToken = Bundle.main.infoDictionary?["BEARER_TOKEN"] as? String
        return ["Authorization": "Bearer \(apiToken!)"]
    }
    
    static func fromUser(_ user: String) -> Self {
        return TwittsEndpoint(queryItems: "from:\(user)")
    }
}
