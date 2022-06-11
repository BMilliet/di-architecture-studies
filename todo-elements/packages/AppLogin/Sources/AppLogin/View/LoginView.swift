import UIKit
import ViewCode

public class LoginView: UIView {
    
    weak var ixResponder: LoginIxResponder?
    
    private lazy var field: UITextField = {
        let field = UITextField()
        field.borderStyle = .line
        return field
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("next", for: .normal)
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        return stack
    }()
    
    @objc
    private func buttonTap() {
        ixResponder?.login(password: field.text ?? "")
    }
}

extension LoginView: ViewCode {
    public func setSubviews() {
        addSubview(stack)
        stack.addArrangedSubview(UIView())
        stack.addArrangedSubview(field)
        stack.addArrangedSubview(button)
        stack.addArrangedSubview(Spacer(size: 250, orientation: .height))
    }
    
    public func setConstraints() {
        stack.setAnchorsEqual(to: self)
        field.size(height: 60, width: 200)
        button.size(height: 80, width: 200)
    }
}

extension LoginView: LoginUserInterface {
    func render(newState: LoginViewState) {
        switch newState {
        case .errorLogin:
            backgroundColor = .red
        case .successLogin:
            backgroundColor = .green
            //ixResponder?.goToHome()
        case .empty:
            backgroundColor = .gray
        }
    }
    
    public func setup() {
       setupView()
    }
}
