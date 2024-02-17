//
//  AuthPresenter.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 05.02.2024.
//  
//

import Foundation

protocol AuthPresenterProtocol: AnyObject {
    func viewDidLoad()
    func loginRequested(login: String, password: String)
    func registerRequested(login: String, password: String)
    func dataValidationError(for option: AuthValidation)
    func updateUI(for state: AuthState)
}

protocol InteractorOutputProtocol: AnyObject {
    func networkError(error: NetworkError)
    func authSuccess()
}

final class AuthPresenter {

    // MARK: - Properties
    weak var view: AuthDisplayLogic?
    var interactor: AuthInteractorProtocol
    var router: AuthRouterProtocol

    // MARK: - Init
    init(
        interactor: AuthInteractorProtocol,
        router: AuthRouterProtocol
    ) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - AuthPresenterProtocol
extension AuthPresenter: AuthPresenterProtocol {
    
    func viewDidLoad() {
        view?.displayAuthView(with: makeAuthViewModel(for: .register))
    }
    
    func loginRequested(login: String, password: String) {
        interactor.login(login: login, password: password)
    }
    
    func registerRequested(login: String, password: String) {
        interactor.register(login: login, password: password)
    }
    
    func dataValidationError(for option: AuthValidation) {
        switch option {
        case .noLogin:
            view?.showAlert(with: makeAlertViewModel(title: Constants.Alert.title, message: Constants.Alert.Message.noLogin))
        case .invalidLogin:
            view?.showAlert(with: makeAlertViewModel(title: Constants.Alert.title, message: Constants.Alert.Message.invalidLogin))
        case .noPassword:
            view?.showAlert(with: makeAlertViewModel(title: Constants.Alert.title, message: Constants.Alert.Message.noPassword))
        case .noRepeatPassword:
            view?.showAlert(with: makeAlertViewModel(title: Constants.Alert.title, message: Constants.Alert.Message.noRepeatPassword))
        case .passwordsDontMatch:
            view?.showAlert(with: makeAlertViewModel(title: Constants.Alert.title, message: Constants.Alert.Message.passwordsDontMatch))
        }
    }
    
    func updateUI(for state: AuthState) {
        switch state {
        case .login:
            let viewModel = AuthDataFlow.ViewModel.ChangeStateViewModel(title: Constants.Title.loginTitle, signUpInBtnLabel: Constants.SignUpInBtn.registerLabel, authBtnLabel: Constants.AuthBtn.loginLabel)
            view?.updateUI(with: viewModel)
        case .register:
            let viewModel = AuthDataFlow.ViewModel.ChangeStateViewModel(title: Constants.Title.registerTitle, signUpInBtnLabel: Constants.SignUpInBtn.loginLabel, authBtnLabel: Constants.AuthBtn.registerLabel)
            view?.updateUI(with: viewModel)
        }
    }
}

// MARK: - Private methods
private extension AuthPresenter {
    
    func makeAuthViewModel(for viewState: AuthState) -> AuthDataFlow.ViewModel.AuthViewModel {
        let authBtn = makeAuthButtonViewModel(for: viewState)
        let signUpInBtn = makeSignUpInButtonViewModel(for: viewState)
        let title = viewState == .login ? Constants.Title.loginTitle : Constants.Title.registerTitle
        
        return AuthDataFlow.ViewModel.AuthViewModel(
            title: title,
            emailLabel: Constants.Labels.loginLabel,
            passwordLabel: Constants.Labels.passwordLabel,
            repeatPasswordLabel: Constants.Labels.repeatPasswordLabel,
            loginPlaceholderText: Constants.TextField.loginPlaceholder,
            passwordPlaceholderText: Constants.TextField.passwordPlaceholder,
            signUpInBtn: signUpInBtn,
            authBtn: authBtn
        )
    }
    
    func makeAuthButtonViewModel(for viewState: AuthState) -> DefaultButtonModel {
        switch viewState {
        case .login:
            DefaultButtonModel(title: Constants.AuthBtn.loginLabel, titleColor: AppColors.buttonText.color, color: AppColors.buttonForeground.color, font: AppFonts.title.font)
        case .register:
            DefaultButtonModel(title: Constants.AuthBtn.registerLabel, titleColor: AppColors.buttonText.color, color: AppColors.buttonForeground.color, font: AppFonts.title.font)
        }
    }
    
    func makeSignUpInButtonViewModel(for viewState: AuthState) -> DefaultButtonModel {
        switch viewState {
        case .login:
            DefaultButtonModel(title: Constants.SignUpInBtn.registerLabel, titleColor: AppColors.buttonText.color, font: AppFonts.label.font)
        case .register:
            DefaultButtonModel(title: Constants.SignUpInBtn.loginLabel, titleColor: AppColors.regular.color, font: AppFonts.label.font)
        }
    }
    
    func makeAlertViewModel(title: String, message: String) -> AuthDataFlow.ViewModel.AlertViewModel {
        AuthDataFlow.ViewModel.AlertViewModel(title: title, message: message)
    }
    
}

// MARK: - InteractorOutput
extension AuthPresenter: InteractorOutputProtocol {
    
    func networkError(error: NetworkError) {
        switch error {
        case .successfulConnection:
            view?.showAlert(with: makeAlertViewModel(title: "Ошибка", message: "test"))
        case .connectionFailed:
            view?.showAlert(with: makeAlertViewModel(title: "Ошибка", message: "connectionFailed"))
        case .redirection:
            view?.showAlert(with: makeAlertViewModel(title: "Ошибка", message: "redirection"))
        case .encodingFailed:
            view?.showAlert(with: makeAlertViewModel(title: "Ошибка", message: "encodingFailed"))
        case .missingUrl:
            view?.showAlert(with: makeAlertViewModel(title: "Ошибка", message: "missingUrl"))
        case .serverError:
            view?.showAlert(with: makeAlertViewModel(title: "Ошибка", message: "serverError"))
        case .clientError:
            view?.showAlert(with: makeAlertViewModel(title: "Ошибка", message: "clientError"))
        }
    }
    
    func authSuccess() {
        router.showNextSreen()
    }
    
}

// MARK: - Constants
private extension AuthPresenter {
    
    enum Constants {
        
        enum Title {
            static let loginTitle: String = "Вход"
            static let registerTitle: String = "Регистрация"
        }
        
        enum AuthBtn {
            static let loginLabel: String = "Войти"
            static let registerLabel: String = "Регистрация"
        }
        
        enum SignUpInBtn {
            static let loginLabel: String = "Войти"
            static let registerLabel: String = "Регистрация"
        }
        
        enum Labels {
            static let loginLabel: String = "e-mail"
            static let passwordLabel: String = "Пароль"
            static let repeatPasswordLabel: String = "Повторите пароль"
        }
        
        enum TextField {
            static let loginPlaceholder: String = "example@example.ru"
            static let passwordPlaceholder: String = "******"
        }
        
        enum Alert {
            static let title: String = "Ошибка"
            
            enum Message {
                static let noLogin: String = "Введите логин"
                static let invalidLogin: String = "Логин должен состоять из 6 и больше символов"
                static let noPassword: String = "Введите пароль"
                static let noRepeatPassword: String = "Введите повтор пароля"
                static let passwordsDontMatch: String = "Пароли не совпадают"
            }
        }
        
    }
    
}
