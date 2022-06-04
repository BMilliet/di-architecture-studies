import Foundation

enum LoginViewState {
    case empty, error, success
}

final class LoginViewModel {
    @Published public private(set) var state: LoginViewState = .empty
    
    func tapButton(_ text: String) {
        if text == "123" {
            success()
        } else {
            error()
        }
    }
    
    private func success() {
        state = .success
    }
    
    private func error() {
        state = .error
    }
}
