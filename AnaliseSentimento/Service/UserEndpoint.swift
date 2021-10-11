import Foundation
import Alamofire

struct UserEndpoint {
    private var scheme: String = "https"
    private var host: String = "api.twitter.com/2"
    private var path: String = "/users/by/username"
    private var user: String
    private var userFields: String
}

extension UserEndpoint {
    var url: String {
        return scheme + "://" + host + path + user + userFields
    }
    
    var headers: HTTPHeaders {
        return ["Authorization": ProcessInfo.processInfo.environment["BEARER_TOKEN"]!]
    }
    
    static func fromUser(_ user: String, createdAt: Bool = false, location: Bool = false, description: Bool = false) -> Self {
        return UserEndpoint(user: "/\(user)",
                            userFields: "?user.fields=profile_image_url\(createdAt ? ",created_at" : "")\(location ? ",location" : "")\(description ? ",description" : "")")
    }
}
