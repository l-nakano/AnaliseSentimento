import Foundation

final class TwittsViewModel: ObservableObject {
    @Published var userTwitts: [UserTwitt]
    @Published var twitterUser: TwitterUser
    
    private var twittsService = TwittsService()
    
    init() {
        userTwitts = []
        twitterUser = TwitterUser()
    }
    
    func getTwittsFromUser(_ user: String) {
        twittsService.fetchUserTwittsFrom(user: user) { twitts in
            self.userTwitts = twitts
        }
    }
    
    func clearTwitts() {
        userTwitts = []
        twitterUser = TwitterUser()
    }
}
