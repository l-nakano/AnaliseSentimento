import Alamofire
import Foundation

final class UserService {
    func fetchUser(_ user: String, completion: @escaping ([UserTwitt]) -> Void) {
        let endpoint = TwittsEndpoint.fromUser(user)
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
            .responseDecodable(of: TwittRootResponse.self, queue: .main) { response in
                guard let userTweets = response.value else { return }
                completion(userTweets.data)
            }
    }
}
