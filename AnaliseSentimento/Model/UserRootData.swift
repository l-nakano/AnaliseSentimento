import Foundation

struct UserRootResponse: Decodable {
    let data: TwitterUser?
    let errors: [UserFetchErrors]?
}

struct UserFetchErrors: Decodable {
    private enum CodingKeys: String, CodingKey {
        case resourceType = "resource_type"
        case resourceID = "resource_id"
        case value = "value"
        case detail = "detail"
        case title = "title"
        case parameter = "parameter"
        case type = "type"
    }
    
    let resourceType: String
    let resourceID: String
    let value: String
    let detail: String
    let title: String
    let parameter: String
    let type: String
    
    init() {
        resourceType = ""
        resourceID = ""
        value = ""
        detail = ""
        title = ""
        parameter = ""
        type = ""
    }
}
