import UIKit

public class HomeViewController: UIViewController {
    private let viewModel: HomeViewModel
    
    required init?(coder: NSCoder) { return nil }
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        view.backgroundColor = .purple
    }
}
