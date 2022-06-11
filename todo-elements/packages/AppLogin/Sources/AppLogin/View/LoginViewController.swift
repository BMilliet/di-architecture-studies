import UIKit
import Combine
import AppHome
import ViewCode
import AppUtils

public class LoginViewController: UIViewController {
    
    private let observer: Observer
    private let userInterface: LoginUserInterfaceView
    private let loginAppUseCaseFactory: LoginAppUseCaseFactory
    private var subscriptions = Set<AnyCancellable>()
    
    private var homeViewController: HomeViewController?
    private let makeHomeViewController: () -> HomeViewController
    
    required init?(coder: NSCoder) { return nil }
    init(
        observer: Observer,
        userInterface: LoginUserInterfaceView,
        loginAppUseCaseFactory: LoginAppUseCaseFactory,
        homeViewControllerFactory: @escaping () -> HomeViewController
    ) {
        self.userInterface = userInterface
        self.observer = observer
        self.loginAppUseCaseFactory = loginAppUseCaseFactory
        self.makeHomeViewController = homeViewControllerFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        observer.startObserving()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        observer.stopObserving()
    }
    
    public override func loadView() {
        view = userInterface
        userInterface.setup()
    }
}

extension LoginViewController: LoginIxResponder {
    func login(password: String) {
        loginAppUseCaseFactory.makeLoginAppUseCase(password: password).start()
    }
    
    func goToHome() {
        self.homeViewController = makeHomeViewController()
        self.navigationController?.pushViewController(homeViewController!, animated: true)
    }
}

extension LoginViewController: LoginObserverResponder {
    func render(newState: LoginViewState) {
        userInterface.render(newState: newState)
    }
}
