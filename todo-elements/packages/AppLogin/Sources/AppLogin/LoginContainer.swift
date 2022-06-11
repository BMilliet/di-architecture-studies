import AppHome
import UIKit
import Combine

public final class LoginContainer {
    
    private let makeHomeViewController: () -> HomeViewController

    public init(
        homeViewControllerFactory: @escaping () -> HomeViewController
    ) {
        self.makeHomeViewController = homeViewControllerFactory
    }
    
    public func makeLoginViewController() -> LoginViewController {
        let observer = makeLoginObserver()
        let userInterface = LoginView()
        
        let controller = LoginViewController(
            observer: observer,
            userInterface: userInterface,
            loginAppUseCaseFactory: makeLoginAppUseCaseFactory(),
            homeViewControllerFactory: makeHomeViewController
        )
        
        observer.eventReponder = controller
        userInterface.ixResponder = controller
        
        return controller
    }
    
    private func makeLoginObserver() -> LoginObserver {
        return LoginObserver(appState: makeLoginStatePublisher())
    }
    
    private func makeLoginStatePublisher() -> AnyPublisher<LoginViewState, Never> {
        return Just(LoginViewState.empty).eraseToAnyPublisher()
    }
    
    private func makeLoginAppUseCaseFactory() -> LoginAppUseCaseFactory {
        return LoginAppUseCaseFactory()
    }
}
