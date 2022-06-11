import AppUtils

class LoginAppUseCase: UseCase {
    
    private let actionDispatcher: ActionDispatcher
    private let password: String
    
    init(actionDispatcher: ActionDispatcher, password: String) {
        self.actionDispatcher = actionDispatcher
        self.password = password
    }
    
    func start() {
        print("useCase => \(password)")
        if password == "123" {
            actionDispatcher.dispatch(LoginSuccessAction())
        } else {
            actionDispatcher.dispatch(LoginFailureAction())
        }
    }
}
