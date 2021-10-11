import SwiftUI

struct UserTwittsView: View {
    @ObservedObject var twittsViewModel: TwittsViewModel
    
    var body: some View {
        Group {
            if twittsViewModel.userTwitts.count == 0 {
                noTwittsMessage
            } else {
                userAndTwitts
            }
        }
        .onAppear {
            twittsViewModel.getTwittsFromUser(twittsViewModel.twitterUser.username)
            twittsViewModel.getProfileImage()
        }
        .onDisappear {
            twittsViewModel.clearTwitts()
        }
    }
    
    var noTwittsMessage: some View {
        Text("Usuário sem twitts recentes!")
            .foregroundColor(.gray)
    }
    
    var userAndTwitts: some View {
        VStack(spacing: 8) {
            profile
            countryAndDate
            description
            twittsList
        }.frame(width: UIScreen.main.bounds.width * 0.9)
    }
    
    var profile: some View {
        VStack {
            HStack {
                Image(uiImage: twittsViewModel.userProfileImage)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.width * 0.2)
                Text(twittsViewModel.twitterUser.name)
                    .font(.largeTitle)
            }.padding(.top, 20)
            Text("@" + twittsViewModel.twitterUser.username)
                .font(.title2)
        }
    }
    
    var countryAndDate: some View {
        HStack {
            addTextWithImage(systemName: "mappin.circle", text: twittsViewModel.twitterUser.location)
                .font(.title3)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            addTextWithImage(systemName: "calendar.circle", text: twittsViewModel.twitterUser.formattedDate())
                .font(.title3)
        }
    }
    
    var description: some View {
        VStack {
            if let text = twittsViewModel.twitterUser.description {
                Text(text)
                    .lineLimit(nil)
                    .frame(width: UIScreen.main.bounds.width * 0.9)
            }
        }
    }
    
    var twittsList: some View {
        List(twittsViewModel.userTwitts) { twitt in
            HStack {
                Text(twitt.text)
                Spacer()
                Text(String(twitt.getSentimentScore()))
            }
        }.padding(.top, 20)
    }
    
    func addTextWithImage(systemName: String, text: String?) -> some View {
        return HStack {
            if text != nil {
                Image(systemName: systemName)
                Text(text!)
            }
        }
    }
}

struct UserTwittsView_Previews: PreviewProvider {
    static var previews: some View {
        UserTwittsView(
            twittsViewModel: TwittsViewModel())
    }
}
