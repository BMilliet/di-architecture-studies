import Foundation

protocol LoginObserverResponder: AnyObject {
    func render(newState: LoginViewState)
}
