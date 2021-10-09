import SwiftUI

@main
struct AnaliseSentimentoApp: App {
    @StateObject var tweetsViewModel = TweetsViewModel()
    
    var body: some Scene {
        WindowGroup {
            UserTweetsView(tweetsViewModel: tweetsViewModel)
        }
    }
}
