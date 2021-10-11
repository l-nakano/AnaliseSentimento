import SwiftUI

struct FindUserView: View {
    @ObservedObject var userViewModel: UserViewModel
    
    @StateObject var twittsViewModel = TwittsViewModel()
    
    @State private var user = ""
    @State private var showingUserTwitts = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        Color.init(UIColor(named: "FindUserColor")!)
            .ignoresSafeArea()
            .overlay(entireView)
    }
    
    var entireView: some View {
        VStack {
            title
            description
            searchField
        }.sheet(isPresented: $showingUserTwitts) {
            UserTwittsView(twittsViewModel: twittsViewModel)
        }
        .frame(width: UIScreen.main.bounds.width * 0.9)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Usuário não encontrado ou inválido!"),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("Ok"), action: { user = "" }))
        }
    }
    
    var title: some View {
        Text("Sentimômetro")
            .font(.largeTitle)
            .bold()
            .foregroundColor(.primary)
            .padding([.top, .bottom], 100)
    }
    
    var description: some View {
        Text("Descubra qual o sentimento dos posts dos usuário do Twitter")
            .font(.title3)
            .italic()
            .multilineTextAlignment(.center)
    }
    
    var searchField: some View {
        VStack(alignment: .leading, spacing: 0) {
            Spacer()
            HStack {
                TextField("Digite o nome do usuário", text: $user)
                    .padding(5)
                    .background(Color.white)
                    .cornerRadius(10)
                    .onReceive(user.publisher.collect()) {
                        self.user = String($0.prefix(UsernameValidation().maxChars))
                    }
                Button(action: {
                    verifyTwitterUser()
                },
                       label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.primary)
                })
            }
            Text("Exemplo: Cristiano")
                .font(.footnote)
            Spacer()
        }
    }
    
    func verifyTwitterUser() {
        if user.contains(where: { !UsernameValidation().allowedChars.contains($0) }) {
            alertMessage = "O nome do usuário contém caracteres inválidos.\nCaracteres válidos: A-Z, a-z, 0-9, _"
            showingAlert.toggle()
        } else {
            userViewModel.getTwitterUser(user) { foundUser in
                if foundUser {
                    twittsViewModel.updateTwitterUser(userViewModel.twitterUser)
                    showingUserTwitts.toggle()
                }
                else {
                    alertMessage = "O nome \(user) não é um usuário do Twitter"
                    showingAlert.toggle()
                }
            }
        }
    }
}

struct FindUserView_Previews: PreviewProvider {
    static var previews: some View {
        FindUserView(userViewModel: UserViewModel())
    }
}
