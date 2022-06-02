import Foundation
import Combine
import AppHome
import AppLogin

public final class MainRouter {
    private let viewModel: MainViewModel
    
    private var homeViewController: HomeViewController?
    private var loginViewController: LoginViewController?
    
    private let makeHomeViewController: () -> HomeViewController
    private let makeLoginViewController: () -> LoginViewController
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(
        viewModel: MainViewModel,
        homeViewControllerFactory: @escaping () -> HomeViewController,
        loginViewControllerFactory: @escaping () -> LoginViewController
    ) {
        self.viewModel = viewModel
        self.makeHomeViewController = homeViewControllerFactory
        self.makeLoginViewController = loginViewControllerFactory
        
        observeState()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            print("changed state")
            //viewModel.signedIn()
            viewModel.notSignedIn()
        }
    }
    
    private func goToHome() {
        self.homeViewController = makeHomeViewController()
        homeViewController?.modalPresentationStyle = .fullScreen
        self.homeViewController?.present(homeViewController!, animated: false)
        //self.navigationController?.pushViewController(homeViewController!, animated: true)
    }
    
    func goToLogin() {
        self.loginViewController = makeLoginViewController()
        //self.navigationController?.pushViewController(loginViewController!, animated: true)
    }
    
    func stateAction(_ state: MainViewState) {
        switch state {
        case .launching:
            print("aa")
        case .home:
            goToHome()
        case .login:
            goToLogin()
        }
    }
    
    private func subscribe(to publisher: AnyPublisher<MainViewState, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let strongSelf = self else { return }
                strongSelf.stateAction(state)
            }
            .store(in: &subscriptions)
    }
    
    private func observeState() {
        let publisher = viewModel.$state.removeDuplicates().eraseToAnyPublisher()
        subscribe(to: publisher)
    }
}
