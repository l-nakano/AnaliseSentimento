import Alamofire
import SwiftUI

final class UserService {
    func fetchUser(_ user: String, completion: @escaping (TwitterUser, [UserFetchErrors]) -> Void) {
        let endpoint = UserEndpoint.fromUser(user, createdAt: true, location: true, description: true)
        let url = endpoint.url
        let headers = endpoint.headers
        AF.request(url, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success:
                    print("Fetch User Validation Successful")
                case let .failure(error):
                    print("Error Fetching User: \(error)")
                }
            }
            .responseDecodable(of: UserRootResponse.self, queue: .main) { response in
                guard let twitterUser = response.value else { return }
                completion(twitterUser.data ?? TwitterUser(), twitterUser.errors ?? [UserFetchErrors()])
            }
    }
}
