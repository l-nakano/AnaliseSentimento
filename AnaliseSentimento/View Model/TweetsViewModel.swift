import Foundation

class TweetsViewModel: ObservableObject {
    @Published var userTweets: [UserTweet]
    
    private var tweetsService = TweetsService()
    
    init() {
        userTweets = []
    }
    
    func getTweetsFromUser(_ user: String) {
        tweetsService.fetchUserTweetsFrom(user: user) { tweets in
            self.userTweets = tweets
        }
    }
}
