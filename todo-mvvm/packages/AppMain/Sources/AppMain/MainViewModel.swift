import Combine

final class MainViewModel {
    @Published public private(set) var state: MainViewState = .launching
    
    func notSignedIn() {
        state = .login
    }
    
    func signedIn() {
        state = .home
    }
}