import Alamofire
import Foundation

final class TweetsService {
    func fetchUserTweetsFrom(user: String, completion: @escaping ([UserTweet]) -> Void) {
        let endpoint = TweetsEndpoint.fromUser(user)
        let url = endpoint.url
        let headers = endpoint.headers
        AF.request(url, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success:
                    print("Fetch Tweets Validation Successful")
                case let .failure(error):
                    print("Error Fetching Tweets: \(error)")
                }
            }
            .responseDecodable(of: RootResponse.self, queue: .main) { response in
                guard let userTweets = response.value else { return }
                completion(userTweets.data)
            }
    }
}
