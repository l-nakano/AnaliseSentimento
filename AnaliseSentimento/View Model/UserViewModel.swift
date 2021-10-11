import Foundation

final class UserViewModel: ObservableObject {
    @Published var twitterUser: TwitterUser
    
    private var userService = UserService()
    
    init() {
        twitterUser = TwitterUser()
    }
    
    func getTwitterUser(_ user: String, completion: @escaping (Bool) -> Void) {
        userService.fetchUser(user) { user, error in
            if user.name == "" {
                print(error.first!.detail)
                completion(false)
            } else {
                self.twitterUser = user
                completion(true)
            }
        }
    }
}
