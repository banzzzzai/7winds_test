//
//  AuthView.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 06.02.2024.
//

import UIKit


protocol AuthViewDelegate: AnyObject {
    func registerUser(login: String, password: String)
    func login(login: String, password: String)
    func showAlert(for option: AuthValidation)
    func updateUI(for state: AuthState)
}

protocol DisplaysAuthView: AnyObject {
    var delegate: AuthViewDelegate? { get set }
    func configure(with viewModel: AuthDataFlow.ViewModel.AuthViewModel)
    func updateUI(with viewModel: AuthDataFlow.ViewModel.ChangeStateViewModel)
}

final class AuthView: UIView, UITableViewDelegate {
    
    // MARK: - UIElements
    private let emailLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = AppFonts.label.font
        lbl.textColor = AppColors.regular.color
        lbl.textAlignment = .left
        return lbl
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.font = AppFonts.placeholder.font
        tf.textColor = AppColors.placeholderText.color
        tf.tintColor = AppColors.regular.color
        tf.borderStyle = .roundedRect
        tf.clipsToBounds = true
        tf.layer.borderWidth = Constants.TextField.borderWidth
        tf.layer.borderColor = Constants.TextField.borderColor
        tf.indent(offset: Constants.TextField.textOffset)
        tf.layer.cornerRadius = Constants.TextField.cornerRadius
        return tf
    }()
    
    private let emailView = UIView()
    
    private let passwordLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = AppFonts.label.font
        lbl.textColor = AppColors.regular.color
        lbl.textAlignment = .left
        return lbl
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.font = AppFonts.placeholder.font
        tf.textColor = AppColors.placeholderText.color
        tf.borderStyle = .roundedRect
        tf.clipsToBounds = true
        tf.layer.borderWidth = Constants.TextField.borderWidth
        tf.layer.borderColor = Constants.TextField.borderColor
        tf.indent(offset: Constants.TextField.textOffset)
        tf.layer.cornerRadius = Constants.TextField.cornerRadius
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let passwordView = UIView()
    
    private let repeatPasswordLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = AppFonts.label.font
        lbl.textColor = AppColors.regular.color
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let repeatPasswordTextField: UITextField = {
        let tf = UITextField()
        tf.font = AppFonts.placeholder.font
        tf.textColor = AppColors.placeholderText.color
        tf.borderStyle = .roundedRect
        tf.clipsToBounds = true
        tf.layer.borderWidth = Constants.TextField.borderWidth
        tf.layer.borderColor = Constants.TextField.borderColor
        tf.indent(offset: Constants.TextField.textOffset)
        tf.layer.cornerRadius = Constants.TextField.cornerRadius
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let repeatPasswordView = UIView()
    
    private let authBtn: DefaultButtonConfigurable = DefaultButton()
    
    private let stackView = UIStackView()
    
    private let signUpInBtn: DefaultButtonConfigurable = DefaultButton()
    
    private let haveAnAccountQuestionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = AppFonts.label.font
        lbl.textColor = AppColors.regular.color
        lbl.textAlignment = .right
        return lbl
    }()
    
    private let bottomStackView = UIStackView()
    
    private let bottomView = UIView()
    
    private var isLogin = false
    
    //MARK: - AuthViewDelegate
    weak var delegate: AuthViewDelegate?
    
    //MARK: - Initializers
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Private methods
private extension AuthView {
    
    func setup() {
        backgroundColor = .systemBackground
        setupStackView()
        setupBottomStackView()
        setupBackgroundTap()
    }
    
    func setupStackView() {
        emailView.addSubview(emailLabel)
        emailView.addSubview(emailTextField)
        
        emailLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.height.equalTo(Constants.Label.height)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(Constants.InputView.spacing)
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(Constants.TextField.height)
        }
        
        passwordView.addSubview(passwordLabel)
        passwordView.addSubview(passwordTextField)
        
        passwordLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.height.equalTo(Constants.Label.height)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(Constants.InputView.spacing)
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(Constants.TextField.height)
        }
        
        repeatPasswordView.addSubview(repeatPasswordLabel)
        repeatPasswordView.addSubview(repeatPasswordTextField)
        
        repeatPasswordLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.height.equalTo(Constants.Label.height)
        }
        
        repeatPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordLabel.snp.bottom).offset(Constants.InputView.spacing)
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(Constants.TextField.height)
        }
        
        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(passwordView)
        stackView.addArrangedSubview(repeatPasswordView)
        stackView.addArrangedSubview(authBtn)
        stackView.axis = Constants.StackView.axis
        stackView.spacing = Constants.StackView.spacing
        
        authBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(Constants.AuthButton.height)
        }
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(Constants.elementsWidthFromSuperviewMultiplier)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(Constants.StackView.topConstraintToSuperview)
        }
        
    }
    
    func setupBottomStackView() {
        bottomStackView.addArrangedSubview(haveAnAccountQuestionLabel)
        bottomStackView.addArrangedSubview(signUpInBtn)
        bottomStackView.axis = Constants.BottomStackView.axis
        bottomStackView.spacing = Constants.BottomStackView.spacing
        bottomStackView.distribution = .fillEqually
        
        haveAnAccountQuestionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
        
        signUpInBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
        
        addSubview(bottomStackView)

        bottomStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
        
    }
    
    func authBtnTapped() {
        validateAuthData()
    }
    
    func validateAuthData() {
        guard let login = emailTextField.text
        else {
            delegate?.showAlert(for: .noLogin)
            return
        }
        if login.count < 6 {
            delegate?.showAlert(for: .invalidLogin)
            return
        }
        
        guard let password = passwordTextField.text,
              let repeatPassword = repeatPasswordTextField.text
        else {
            delegate?.showAlert(for: .noPassword)
            return
        }
        
        if password == "" {
            delegate?.showAlert(for: .noPassword)
            return
        }
        
        
        if !isLogin {
            if repeatPassword == "" {
                delegate?.showAlert(for: .noRepeatPassword)
                return
            }
            
            if password != repeatPassword {
                delegate?.showAlert(for: .passwordsDontMatch)
                return
            }
        }
        
        delegate?.login(login: login, password: password)
        
    }
    
    func signUpInBtnTapped() {
        isLogin.toggle()
        if isLogin {
            delegate?.updateUI(for: .login)
        } else {
            delegate?.updateUI(for: .register)
        }
    }
    
    func setupBackgroundTap() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        addGestureRecognizer(tapGesture)
        
    }
    
    @objc func backgroundTap() {
        endEditing(false)
    }

}

// MARK: - DisplaysAuthView
extension AuthView: DisplaysAuthView {
    
    func configure(with viewModel: AuthDataFlow.ViewModel.AuthViewModel) {
        
        authBtn.configure(with: viewModel.authBtn)
        signUpInBtn.configure(with: viewModel.signUpInBtn)
        emailLabel.text = viewModel.emailLabel
        passwordLabel.text = viewModel.passwordLabel
        repeatPasswordLabel.text = viewModel.repeatPasswordLabel
        haveAnAccountQuestionLabel.text = viewModel.haveAccountText
        emailTextField.placeholder = viewModel.loginPlaceholderText
        passwordTextField.placeholder = viewModel.passwordPlaceholderText
        repeatPasswordTextField.placeholder = viewModel.passwordPlaceholderText
        
        authBtn.setTouchUpInsideHandler { [ weak self ] in
            self?.authBtnTapped()
        }
        
        signUpInBtn.setTouchUpInsideHandler { [ weak self ] in
            self?.signUpInBtnTapped()
        }
    }
    
    //MARK: - Animations
    func updateUI(with viewModel: AuthDataFlow.ViewModel.ChangeStateViewModel) {
        
        authBtn.changeTitle(to: viewModel.authBtnLabel)
        signUpInBtn.changeTitle(to: viewModel.signUpInBtnLabel)
        haveAnAccountQuestionLabel.text = viewModel.haveAccountText
        
        UIView.animate(withDuration: 0.5) { [ weak self ] in
            guard let self else { return }
            self.repeatPasswordView.isHidden = isLogin
            if isLogin {
                self.repeatPasswordLabel.isHidden = isLogin
                self.repeatPasswordTextField.isHidden = isLogin
            }
        } completion: { _ in
            UIView.animate(withDuration: 0.3) { [ weak self ] in
                guard let self else { return }
                if !self.isLogin {
                    self.repeatPasswordView.alpha = 0
                    self.repeatPasswordLabel.isHidden = self.isLogin
                    self.repeatPasswordTextField.isHidden = self.isLogin
                    UIView.animate(withDuration: 0.5) { [ weak self ] in
                        guard let self else { return }
                        self.repeatPasswordView.alpha = 1
                    }
                }
            }
        }
    }
    
}

// MARK: - Constants
private extension AuthView {
    enum Constants {
        
        static let elementsWidthFromSuperviewMultiplier: CGFloat = 0.9
        
        enum InputView {
            static let spacing: CGFloat = 8
        }
        
        enum AuthButton {
            static let height: CGFloat = 48
        }
        
        enum SignUpInButton {
            static let height: CGFloat = 20
        }
        
        enum Label {
            static let height: CGFloat = 18
        }
        
        enum TextField {
            static let textOffset: CGFloat = 15
            static let cornerRadius: CGFloat = 23
            static let borderWidth: CGFloat = 2
            static let borderColor: CGColor = CGColor(red: 132/255, green: 99/255, blue: 64/255, alpha: 1)
            static let height: CGFloat = 47
        }
        
        enum StackView {
            static let axis: NSLayoutConstraint.Axis = .vertical
            static let spacing: CGFloat = 24
            static let topConstraintToSuperview: CGFloat = 278
        }
        
        enum BottomStackView {
            static let axis: NSLayoutConstraint.Axis = .horizontal
            static let spacing: CGFloat = 10
        }
        
    }
}
