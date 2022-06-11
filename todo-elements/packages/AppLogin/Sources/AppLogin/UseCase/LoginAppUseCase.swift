import AppUtils

class LoginAppUseCase: UseCase {
    
    private let password: String
    
    init(password: String) {
        self.password = password
    }
    
    func start() {
        print("useCase => \(password)")
        if password == "123" {
            // success
            // actionDispatcher.dispatch
        } else {
            // error
            // actionDispatcher.dispatch
        }
    }
}
