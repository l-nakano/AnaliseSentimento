import Foundation

final class TwittsViewModel: ObservableObject {
    @Published var userTwitts: [UserTwitt]
    
    private var twittsService = TwittsService()
    
    init() {
        userTwitts = []
    }
    
    func getTwittsFromUser(_ user: String) {
        twittsService.fetchUserTwittsFrom(user: user) { twitts in
            self.userTwitts = twitts
        }
    }
}
