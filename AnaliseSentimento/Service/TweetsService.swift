import Alamofire
import Foundation

final class TweetsService {
    func fetchUserTweetsFrom(user: String, completion: @escaping ([UserTweet]) -> Void) {
        let endpoint = TweetsEndpoint.fromUser(user)
        let url = endpoint.url
        let headers = endpoint.headers
//        let encodedURL = "from:\(user)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
//        let url = "https://api.twitter.com/2/tweets/search/recent?query=\(encodedURL)"
//        let headers: HTTPHeaders = ["Authorization": "Bearer AAAAAAAAAAAAAAAAAAAAAOv1UQEAAAAA3MLr1C7mtA7pquHZJnk5mGLWXug%3DelLUznFpVNW7BuuSBLuODqmO1DFrlCq8eYWj56i5zvGd6E9fLu"]
        AF.request(url, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success:
                    print("Fetch Tweets Validation Successful")
                case let .failure(error):
                    fatalError("Error Fetching Tweets: \(error)")
                }
            }
            .responseDecodable(of: RootResponse.self) { response in
                guard let userTweets = response.value else { return }
                completion(userTweets.data)
            }
    }
}
