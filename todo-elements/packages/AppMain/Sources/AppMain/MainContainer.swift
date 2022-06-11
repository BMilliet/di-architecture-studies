import AppLogin
import AppHome
import Combine

public final class MainContainer {
    
    public init() {}
    
    public func makeMainViewController() -> MainViewController {
        let observer = makeMainObserver()
        
        let controller = MainViewController(
            observer: observer,
            homeViewControllerFactory: { return self.makeHomeViewController() },
            loginViewControllerFactory: { return self.makeLoginViewController() }
        )
        
        observer.eventReponder = controller
        return controller
    }
    
    func makeHomeViewController() -> HomeViewController {
        let container = HomeContainer()
        return container.makeHomeViewController()
    }
    
    func makeLoginViewController() -> LoginViewController {
        let container = LoginContainer(
            homeViewControllerFactory: { return self.makeHomeViewController() }
        )
        return container.makeLoginViewController()
    }
    
    func makeMainObserver() -> MainObserver {
        return MainObserver(appState: makeAppStatePublisher())
    }
    
    func makeAppStatePublisher() -> AnyPublisher<MainViewState, Never> {
        return Just(MainViewState.login).eraseToAnyPublisher()
    }
}
