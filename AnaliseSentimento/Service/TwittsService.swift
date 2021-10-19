import Alamofire
import Foundation

final class TwittsService {
    func fetchUserTwittsFrom(user: String, completion: @escaping ([UserTwitt]) -> Void) {
        let endpoint = TwitterEndpoint.userTwitts(from: user)
        let url = endpoint.url
        let headers = endpoint.headers
        AF.request(url, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success:
                    print("Fetch Twitts Validation Successful")
                case let .failure(error):
                    print("Error Fetching Twitts: \(error)")
                }
            }
            .responseDecodable(of: TwittRootResponse.self, queue: .main) { response in
                guard let userTwitts = response.value else { return }
                completion(userTwitts.data)
            }
    }
    
    func getUserProfileImage(from url: String, completion: @escaping (Data?) -> ()) {
        AF.request(url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success:
                    print("Fetch Profile Image Validation Successful")
                    completion(response.data)
                case let .failure(error):
                    print("Error Fetching Profile Image: \(error)")
                }
            }
    }
}
