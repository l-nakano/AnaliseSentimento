import SwiftUI

@main
struct AnaliseSentimentoApp: App {
//    @StateObject var tweetsViewModel = TwittsViewModel()
    @StateObject var userViewModel = UserViewModel()
    
    var body: some Scene {
        WindowGroup {
//            UserTwittsView(twittsViewModel: tweetsViewModel)
            FindUserView(userViewModel: userViewModel)
        }
    }
}
