public final class HomeContainer {
    public init() {}
    
    public func makeHomeViewController() -> HomeViewController {
        return HomeViewController(
            viewModel: makeHomeViewModel()
        )
    }
    
    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel()
    }
}
