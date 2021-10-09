import Foundation

struct RootResponse: Decodable {
    let data: [UserTweet]
    let meta: MetaData
}

struct MetaData: Decodable {
    private enum CodingKeys: String, CodingKey {
        case newestID = "newest_id"
        case oldestID = "oldest_id"
        case resultCount = "result_count"
    }
    
    let newestID: String
    let oldestID: String
    let resultCount: Int
}

struct UserTweet: Decodable, Identifiable {
    let id: String
    let text: String
}
