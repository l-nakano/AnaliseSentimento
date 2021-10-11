import SwiftUI

final class TwittsViewModel: ObservableObject {
    @Published var userTwitts: [UserTwitt]
    @Published var twitterUser: TwitterUser
    
    var userProfileImage = UIImage()
    
    private var twittsService = TwittsService()
    
    init() {
//        userTwitts = []
        userTwitts = [UserTwitt(id: "101010", text: "Twitt de teste")]
        twitterUser = TwitterUser()
    }
    
    func getTwittsFromUser(_ user: String) {
        twittsService.fetchUserTwittsFrom(user: user) { twitts in
            self.userTwitts = twitts
        }
    }
    
    func updateTwitterUser(_ user: TwitterUser) {
        twitterUser = user
    }
    
    func clearTwitts() {
        userTwitts = []
        twitterUser = TwitterUser()
    }
    
    func getProfileImage() {
        print("Download Started")
        twittsService.getUserProfileImage(from: twitterUser.profileImageUrl) { data in
            guard let data = data else { return }
            DispatchQueue.main.async() {
                self.userProfileImage = UIImage(data: data)!
            }
        }
    }
}
