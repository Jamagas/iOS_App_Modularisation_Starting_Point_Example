import UIKit
import ModuleCore
import UIComponents

public class OnboardingViewController: UIViewController {
    
    @Injected private var networkWorker: Networking
    
    private lazy var registerButton: UIButton = {
        let button = PrimaryButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside) // when using addTarget() always use lazy, otherwise self might not point to right self causing button being not responsive
        return button
    }()
    
    private let completion: (Result<User, OnboardingError>) -> Void
    
    public init(completion: @escaping (Result<User, OnboardingError>) -> Void) {
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        
        view.addSubview(registerButton)
        NSLayoutConstraint.activate([
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: 200),
            registerButton.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    @objc private func didTapRegister() {
        registerUser()
    }
    
    private func registerUser() {
        let request = RegisterUser(
            email: "jon@example.com",
            name: "Jon",
            surname: "Johnson",
            password: "password"
        )
        networkWorker.perform(request: request) { [weak self] (result: Result<User, StandardError>) in
            switch result {
            case let .success(user):
                self?.handleSuccess(user)
            case let .failure(error):
                self?.handleFailure(error)
            }
        }
    }
    
    private func handleSuccess(_ user: User) {
        completion(.success(user))
    }
    
    private func handleFailure(_ error: StandardError) {
        guard error.origin == "Onboarding" else {
            showGenericErrorToast()
            return
        }
        
        switch error.code {
        case "123":
            showErrorToast("Password is weak")
        case "800":
            showErrorToast("User already exist")
            completion(.failure(.userAlreadyExist))
        default:
            showGenericErrorToast()
        }
    }
    
    private func showGenericErrorToast() {
        ErrorToastManager.showErrorToast("Something went wrong")
    }
    
    private func showErrorToast(_ message: String) {
        ErrorToastManager.showErrorToast(message)
    }
}
