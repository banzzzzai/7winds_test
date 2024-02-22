//
//  NearestCoffeeViewController.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 17.02.2024.
//

import UIKit

protocol NearestCoffeeDisplayLogic: AnyObject {
    func displayNearestCoffeeView()
}

final class NearestCoffeeViewController: UIViewController {
    
    // MARK: - Properties
    var presenter: NearestCoffeePresenterProtocol?
    
    //MARK: - UIElements
    private let contentView: DisplaysNearestCoffee = NearestCoffeeView()

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
private extension NearestCoffeeViewController {
    
    func setupView() {
        view = contentView as? NearestCoffeeView
    }
    
    func setup() {
        
    }
    
}

// MARK: - NearestCoffeeViewProtocol
extension NearestCoffeeViewController: NearestCoffeeDisplayLogic {
    
    func displayNearestCoffeeView() {
        
    }
    
}
