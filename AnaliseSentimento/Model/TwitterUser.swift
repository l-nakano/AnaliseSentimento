import Foundation

struct TwitterUser: Decodable, Equatable {
    private enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case profileImageUrl = "profile_image_url"
        case name = "name"
        case location = "location"
        case username = "username"
        case id = "id"
        case description = "description"
    }
    
    let createdAt: String
    let profileImageUrl: String
    let name: String
    let location: String?
    var username: String
    let id: String
    let description: String
    
    init() {
        createdAt = ""
        profileImageUrl = ""
        name = ""
        location = ""
        username = ""
        id = ""
        description = ""
    }
}
