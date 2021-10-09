import SwiftUI

struct UserTweetsView: View {
    @ObservedObject var tweetsViewModel: TweetsViewModel
    
    var body: some View {
        List(tweetsViewModel.userTweets) { tweet in
            HStack {
                Text(tweet.text)
                Spacer()
                Text(String(tweet.getSentimentScore()))
            }
        }
        .onAppear {
            tweetsViewModel.getTweetsFromUser("Cristiano")
        }
    }
}

struct UserTweetsView_Previews: PreviewProvider {
    static var previews: some View {
        UserTweetsView(tweetsViewModel: TweetsViewModel())
    }
}
