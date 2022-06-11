import Foundation

protocol LoginIxResponder: AnyObject {
    func login(password: String)
    func goToHome()
}
