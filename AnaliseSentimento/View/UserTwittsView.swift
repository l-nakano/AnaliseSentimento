import SwiftUI

struct UserTwittsView: View {
    @ObservedObject var twittsViewModel: TwittsViewModel
    
    var body: some View {
        HStack {
            if twittsViewModel.userTwitts.count == 0 {
                Text("Usuário sem twitts recentes!")
                    .foregroundColor(.gray)
            } else {
                List(twittsViewModel.userTwitts) { twitt in
                    HStack {
                        Text(twitt.text)
                        Spacer()
                        Text(String(twitt.getSentimentScore()))
                    }
                }
            }
        }
        .onAppear {
            twittsViewModel.getTwittsFromUser(twittsViewModel.twitterUser.username)
        }
        .onDisappear {
            twittsViewModel.clearTwitts()
        }
    }
}

struct UserTwittsView_Previews: PreviewProvider {
    static var previews: some View {
        UserTwittsView(
            twittsViewModel: TwittsViewModel())
    }
}
