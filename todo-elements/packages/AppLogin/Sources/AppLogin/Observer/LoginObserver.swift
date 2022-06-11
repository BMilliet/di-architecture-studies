import Foundation
import Combine
import AppUtils

final class LoginObserver: Observer {
    
    let state: AnyPublisher<LoginViewState, Never>
    var loginViewControllerStateSubscription: AnyCancellable?
    
    weak var eventReponder: LoginObserverResponder? {
        willSet { if newValue == nil { stopObserving() } }
    }
    
    public init(appState: AnyPublisher<LoginViewState, Never>) {
        self.state = appState
    }
    
    func startObserving() {
        assert(self.eventReponder != nil)
        
        guard let _ = self.eventReponder else {
            return
        }
        
        if isObserving { return }
        
        subscribeToMainViewState()
    }
    
    func stopObserving() {
        loginViewControllerStateSubscription = nil
    }
    
    private func subscribeToMainViewState() {
        loginViewControllerStateSubscription =
        state
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] state in
                self?.received(state: state)
            }
    }
    
    private var isObserving: Bool {
        return (loginViewControllerStateSubscription != nil)
    }
    
    private func received(state: LoginViewState) {
        eventReponder?.render(newState: state)
    }
}
