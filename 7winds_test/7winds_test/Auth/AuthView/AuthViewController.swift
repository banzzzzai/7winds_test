//
//  AuthViewController.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 05.02.2024.
//  
//

import UIKit
import SnapKit

protocol AuthDisplayLogic: AnyObject {
    func displayAuthView(with viewModel: AuthDataFlow.ViewModel.AuthViewModel)
    func showAlert(with viewModel: AuthDataFlow.ViewModel.AlertViewModel)
    func updateUI(with viewModel: AuthDataFlow.ViewModel.ChangeStateViewModel)
}

final class AuthViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: AuthPresenterProtocol?
    
    //MARK: - UIElements
    private let contentView: DisplaysAuthView = AuthView()

    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setup()
    }
    
}

// MARK: - Private methods
private extension AuthViewController {
    
    func setupView() {
        contentView.viewDelegate = self
        view = contentView as? AuthView
    }
    
    func setup() {
        setupNavBar()
    }
    
    func setupNavBar() {
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: AppColors.regular.color,
            .font: AppFonts.title.font ?? UIFont.systemFont(ofSize: UIFont.labelFontSize)
        ]
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppColors.primary.color
        appearance.titleTextAttributes = textAttributes
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
}

// MARK: - AuthViewProtocol
extension AuthViewController: AuthDisplayLogic {
    
    func displayAuthView(with viewModel: AuthDataFlow.ViewModel.AuthViewModel) {
        title = viewModel.title
        contentView.configure(with: viewModel)
    }
    
    func showAlert(with viewModel: AuthDataFlow.ViewModel.AlertViewModel) {
        let alertController = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func updateUI(with viewModel: AuthDataFlow.ViewModel.ChangeStateViewModel) {
        title = viewModel.title
        contentView.updateUI(with: viewModel)
    }
    
}

// MARK: - AuthViewDelegate
extension AuthViewController: AuthViewDelegate {
    
    func showAlert(for option: AuthValidation) {
        presenter?.dataValidationError(for: option)
    }
    
    func registerUser(login: String, password: String) {
        presenter?.registerRequested(login: login, password: password)
    }
    
    func login(login: String, password: String) {
        presenter?.loginRequested(login: login, password: password)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func updateUI(for state: AuthState) {
        presenter?.updateUI(for: state)
    }
    
}
