import Foundation
import Combine
import AppUtils

final class LoginObserver: Observer {
    
    //let state: AnyPublisher<LoginViewState, Never>
    
    @Published public private(set) var state: LoginViewState = .empty
    var loginViewControllerStateSubscription: AnyCancellable?
    
    weak var eventReponder: LoginObserverResponder? {
        willSet { if newValue == nil { stopObserving() } }
    }
    
//    public init(appState: AnyPublisher<LoginViewState, Never>) {
//        self.state = appState
//    }
    
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
        NotificationCenter.default.removeObserver(self)
    }
    
    private func subscribeToMainViewState() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(loginFail),
            name: NSNotification.Name("\(LoginFailureAction())"), object: nil
        )
        NotificationCenter.default.addObserver(
            self, selector: #selector(loginSuccess),
            name: NSNotification.Name("\(LoginSuccessAction())"), object: nil
        )
        
        loginViewControllerStateSubscription =
        $state
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] state in
                self?.received(state: state)
            }
    }
    
    @objc func loginFail() {
        print("login fail")
        state = .errorLogin
    }
    
    @objc func loginSuccess() {
        print("login success")
        state = .successLogin
    }
    
    private var isObserving: Bool {
        return (loginViewControllerStateSubscription != nil)
    }
    
    private func received(state: LoginViewState) {
        eventReponder?.render(newState: state)
    }
}
