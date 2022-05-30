import UIKit

public class HomeViewController: UIViewController {
    private let viewModel: HomeViewModel
    
    required init?(coder: NSCoder) { return nil }
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        print("Init!")
    }
    
    public override func viewDidLoad() {
        print("did load")
        view.backgroundColor = .purple
    }
    
    deinit {
        print("deinit!")
    }
}
