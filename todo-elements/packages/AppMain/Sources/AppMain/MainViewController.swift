import UIKit
import AppLogin
import AppHome
import Combine
import AppUtils

public class MainViewController: UIViewController {
    
    private let observer: Observer
    private var subscriptions = Set<AnyCancellable>()
    
    private var homeViewController: HomeViewController?
    private var loginViewController: LoginViewController?
    
    private let makeHomeViewController: () -> HomeViewController
    private let makeLoginViewController: () -> LoginViewController
    
    required init?(coder: NSCoder) { return nil }
    init(
        observer: Observer,
        homeViewControllerFactory: @escaping () -> HomeViewController,
        loginViewControllerFactory: @escaping () -> LoginViewController
    ) {
        self.observer = observer
        self.makeHomeViewController = homeViewControllerFactory
        self.makeLoginViewController = loginViewControllerFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        observer.startObserving()
    }
    
    private func goToHome() {
        self.homeViewController = makeHomeViewController()
        navigationController?.pushViewController(homeViewController!, animated: false)
    }
    
    func goToLogin() {
        self.loginViewController = makeLoginViewController()
        navigationController?.pushViewController(loginViewController!, animated: false)
    }
    
    func stateAction(_ state: MainViewState) {
        switch state {
        case .launching:
            view.backgroundColor = .cyan
        case .home:
            goToHome()
        case .login:
            goToLogin()
        }
    }
}

extension MainViewController: MainObserverResponder {
    func navigationState(state: MainViewState) {
        stateAction(state)
    }
}
