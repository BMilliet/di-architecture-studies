final class LoginAppUseCaseFactory {
    func makeLoginAppUseCase(password: String) -> LoginAppUseCase {
        return LoginAppUseCase(password: password)
    }
}
