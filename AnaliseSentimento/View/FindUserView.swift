import SwiftUI

struct FindUserView: View {
    @ObservedObject var userViewModel: UserViewModel
    
    @StateObject var twittsViewModel = TwittsViewModel()
    
    @State private var user = ""
    @State private var showingUserTwitts = false
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Digite o usuário", text: $user)
                Button(action: {
                    verifyTwitterUser()
                },
                       label: { Text("Procurar") })
            }
        }.sheet(isPresented: $showingUserTwitts) {
            UserTwittsView(twittsViewModel: twittsViewModel)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Usuário não encontrado!"),
                  message: Text("O nome \(user) não é um usuário do Twitter."),
                  dismissButton: .default(Text("Ok"), action: { user = "" }))
        }
    }
    
    func verifyTwitterUser() {
        userViewModel.getTwitterUser(user) { foundUser in
            if foundUser {
                twittsViewModel.twitterUser = userViewModel.twitterUser
                showingUserTwitts.toggle()
            }
            else {
                showingAlert.toggle()
            }
        }
    }
}

struct FindUserView_Previews: PreviewProvider {
    static var previews: some View {
        FindUserView(userViewModel: UserViewModel())
    }
}
