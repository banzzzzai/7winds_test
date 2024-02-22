//
//  NearestCoffeePresenter.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 21.02.2024.
//

import Foundation

protocol NearestCoffeePresenterProtocol: AnyObject {
    func viewDidLoad()
}

protocol NearestCoffeeInteractorOutputProtocol: AnyObject {
    
}

final class NearestCoffeePresenter {
    
    // MARK: - Properties
    weak var view: NearestCoffeeDisplayLogic?
    private var interactor: NearestCoffeeInteractorProtocol
    private var router: NearestCoffeeRouterProtocol
    
    // MARK: - Init
    init(
        interactor: NearestCoffeeInteractorProtocol, 
        router: NearestCoffeeRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - NearestCoffeePresenterProtocol
extension NearestCoffeePresenter: NearestCoffeePresenterProtocol {
    
    func viewDidLoad() {
        view?.displayNearestCoffeeView()
    }
    
}
