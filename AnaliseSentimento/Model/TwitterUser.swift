import Foundation
import UIKit

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
    let username: String
    let id: String
    let description: String?
    
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

extension TwitterUser {
    func formattedDate() -> String {
        let isoFormatter = DateFormatter()
        isoFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        isoFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        isoFormatter.locale = Locale(identifier: "en_US_POSIX")
        let isoDate = isoFormatter.date(from: self.createdAt)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/y"
        formatter.locale = Locale(identifier: "pt-br")
        return formatter.string(from: isoDate!)
    }
}
