import UIKit
import AppLogin
import AppHome
import Combine

public class MainViewController: UIViewController {
    
    private let viewModel: MainViewModel
    
    private var homeViewController: HomeViewController?
    private var loginViewController: LoginViewController?
    
    private let makeHomeViewController: () -> HomeViewController
    private let makeLoginViewController: () -> LoginViewController
    
    private var subscriptions = Set<AnyCancellable>()
    
    required init?(coder: NSCoder) { return nil }
    init(
        viewModel: MainViewModel,
        homeViewControllerFactory: @escaping () -> HomeViewController,
        loginViewControllerFactory: @escaping () -> LoginViewController
    ) {
        self.viewModel = viewModel
        self.makeHomeViewController = homeViewControllerFactory
        self.makeLoginViewController = loginViewControllerFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        observeState()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            print("changed state")
            viewModel.signedIn()
        }
    }
    
    private func goToHome() {
        self.homeViewController = makeHomeViewController()
        self.navigationController?.present(homeViewController!, animated: true)
    }
    
    func goToLogin() {
        self.loginViewController = makeLoginViewController()
        self.navigationController?.present(loginViewController!, animated: true)
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
    
    func subscribe(to publisher: AnyPublisher<MainViewState, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let strongSelf = self else { return }
                strongSelf.stateAction(state)
            }
            .store(in: &subscriptions)
    }
    
    func observeState() {
        let publisher = viewModel.$state.removeDuplicates().eraseToAnyPublisher()
        subscribe(to: publisher)
    }
}
