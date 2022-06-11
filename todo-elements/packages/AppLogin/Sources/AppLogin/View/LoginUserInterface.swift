import Foundation
import UIKit

typealias LoginUserInterfaceView = LoginUserInterface & UIView

protocol LoginUserInterface {
    func setup()
    func render(newState: LoginViewState)
}
