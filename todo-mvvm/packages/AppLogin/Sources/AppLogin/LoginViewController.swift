import UIKit
import Combine
import AppHome
import ViewCode

public class LoginViewController: UIViewController {
    private let viewModel: LoginViewModel
    
    private var homeViewController: HomeViewController?
    private let makeHomeViewController: () -> HomeViewController
    
    private var subscriptions = Set<AnyCancellable>()
    
    private lazy var field: UITextField = {
        let field = UITextField()
        field.borderStyle = .line
        return field
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("next", for: .normal)
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    required init?(coder: NSCoder) { return nil }
    init(
        viewModel: LoginViewModel,
        homeViewControllerFactory: @escaping () -> HomeViewController
    ) {
        self.viewModel = viewModel
        self.makeHomeViewController = homeViewControllerFactory
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    public override func viewDidLoad() {
        observeState()
    }
    
    @objc
    private func buttonTap() {
        viewModel.tapButton(field.text ?? "")
    }
    
    private func stateAction(_ state: LoginViewState) {
        switch state {
        case .error:
            view.backgroundColor = .red
        case .success:
            view.backgroundColor = .green
            goToHome()
        case .empty:
            view.backgroundColor = .gray
        }
    }
    
    private func subscribe(to publisher: AnyPublisher<LoginViewState, Never>) {
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
    
    private func goToHome() {
        self.homeViewController = makeHomeViewController()
        self.navigationController?.pushViewController(homeViewController!, animated: true)
    }
}

extension LoginViewController: ViewCode {
    public func setSubviews() {
        view.addSubview(stack)
        stack.addArrangedSubview(UIView())
        stack.addArrangedSubview(field)
        stack.addArrangedSubview(button)
        stack.addArrangedSubview(Spacer(size: 250, orientation: .height))
    }
    
    public func setConstraints() {
        stack.setAnchorsEqual(to: view)
        field.size(height: 60, width: 200)
        button.size(height: 80, width: 200)
    }
}
