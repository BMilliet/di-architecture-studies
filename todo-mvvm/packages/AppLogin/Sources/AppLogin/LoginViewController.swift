import UIKit

public class LoginViewController: UIViewController {
    private let viewModel: LoginViewModel
    
    required init?(coder: NSCoder) { return nil }
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        view.backgroundColor = .green
    }
}
