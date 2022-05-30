import AppLogin
import AppHome

public final class MainContainer {
    public init() {}
    
    public func makeMainViewController() -> MainViewController {
        return MainViewController(
            viewModel: makeMainViewModel(),
            homeViewControllerFactory: { return self.makeHomeViewController() },
            loginViewControllerFactory: { return self.makeLoginViewController() }
        )
    }
    
    func makeMainViewModel() -> MainViewModel {
        return MainViewModel()
    }
    
    func makeHomeViewController() -> HomeViewController {
        let container = HomeContainer()
        return container.makeHomeViewController()
    }
    
    func makeLoginViewController() -> LoginViewController {
        let container = LoginContainer()
        return container.makeLoginViewController()
    }
}
