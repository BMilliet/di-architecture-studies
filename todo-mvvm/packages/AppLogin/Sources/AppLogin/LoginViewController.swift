import UIKit
import AppHome

public class LoginViewController: UIViewController {
    private let viewModel: LoginViewModel
    
    private var homeViewController: HomeViewController?
    private let makeHomeViewController: () -> HomeViewController
    
    required init?(coder: NSCoder) { return nil }
    init(
        viewModel: LoginViewModel,
        homeViewControllerFactory: @escaping () -> HomeViewController
    ) {
        self.viewModel = viewModel
        self.makeHomeViewController = homeViewControllerFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        view.backgroundColor = .green
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            goToHome()
        }
    }
    
    private func goToHome() {
        self.homeViewController = makeHomeViewController()
        self.navigationController?.pushViewController(homeViewController!, animated: true)
    }
}
