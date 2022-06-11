import AppUtils

protocol LoginAppUseCaseFactory {
    func makeLoginAppUseCase(password: String) -> LoginAppUseCase
}
