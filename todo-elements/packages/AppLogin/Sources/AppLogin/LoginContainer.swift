import AppHome
import UIKit

public final class LoginContainer {
    
    private let makeHomeViewController: () -> HomeViewController

    public init(
        homeViewControllerFactory: @escaping () -> HomeViewController
    ) {
        self.makeHomeViewController = homeViewControllerFactory
    }
    
    public func makeLoginViewController() -> LoginViewController {
        return LoginViewController(
            viewModel: makeLoginViewModel(),
            homeViewControllerFactory: makeHomeViewController
        )
    }
    
    func makeLoginViewModel() -> LoginViewModel {
        return LoginViewModel()
    }
}
