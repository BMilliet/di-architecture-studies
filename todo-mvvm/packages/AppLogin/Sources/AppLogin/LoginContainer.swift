public final class LoginContainer {
    public init() {}
    
    public func makeLoginViewController() -> LoginViewController {
        return LoginViewController(
            viewModel: makeLoginViewModel()
        )
    }
    
    func makeLoginViewModel() -> LoginViewModel {
        return LoginViewModel()
    }
}
