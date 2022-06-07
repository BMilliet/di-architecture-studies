import Combine

enum MainViewState {
    case launching, login, home
}

final class MainViewModel {
    @Published public private(set) var state: MainViewState = .launching
    
    func validateState() {
        notSignedIn()
        //signedIn()
    }
    
    private func notSignedIn() {
        state = .login
    }
    
    private func signedIn() {
        state = .home
    }
}
