import SwiftUI

struct UserTwittsView: View {
    @ObservedObject var twittsViewModel: TwittsViewModel
    
    var body: some View {
        List(twittsViewModel.userTwitts) { twitt in
            HStack {
                Text(twitt.text)
                Spacer()
                Text(String(twitt.getSentimentScore()))
            }
        }
        .onAppear {
            twittsViewModel.getTwittsFromUser("Cristiano")
        }
    }
}

struct UserTwittsView_Previews: PreviewProvider {
    static var previews: some View {
        UserTwittsView(twittsViewModel: TwittsViewModel())
    }
}
