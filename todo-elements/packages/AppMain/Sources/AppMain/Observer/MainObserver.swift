import Foundation
import Combine
import AppUtils

final class MainObserver: Observer {
    
    let state: AnyPublisher<MainViewState, Never>
    var mainViewControllerStateSubscription: AnyCancellable?
    
    weak var eventReponder: MainObserverResponder? {
        willSet {
            if newValue == nil { stopObserving() }
        }
    }
    
    public init(appState: AnyPublisher<MainViewState, Never>) {
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
        mainViewControllerStateSubscription = nil
    }
    
    private func subscribeToMainViewState() {
        mainViewControllerStateSubscription =
        state
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] state in
                self?.received(state: state)
            }
    }
    
    private var isObserving: Bool {
        return (mainViewControllerStateSubscription != nil)
    }
    
    private func received(state: MainViewState) {
        eventReponder?.navigationState(state: state)
    }
}
