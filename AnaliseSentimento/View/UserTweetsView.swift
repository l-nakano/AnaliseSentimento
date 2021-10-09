// NLTagger

import SwiftUI

struct UserTweetsView: View {
    @ObservedObject var tweetsViewModel: TweetsViewModel
    
    var body: some View {
        List(tweetsViewModel.userTweets) { tweet in
            Text(tweet.text)
        }
        .onAppear {
            tweetsViewModel.getTweetsFromUser("EstudanteRata")
        }
    }
}

struct UserTweetsView_Previews: PreviewProvider {
    static var previews: some View {
        UserTweetsView(tweetsViewModel: TweetsViewModel())
    }
}
