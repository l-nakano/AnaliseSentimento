import SwiftUI

@main
struct AnaliseSentimentoApp: App {
    @StateObject var tweetsViewModel = TwittsViewModel()
    
    var body: some Scene {
        WindowGroup {
            UserTwittsView(twittsViewModel: tweetsViewModel)
        }
    }
}
