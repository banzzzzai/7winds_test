//
//  NearestCoffeeView.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 21.02.2024.
//

import UIKit

protocol DisplaysNearestCoffee: AnyObject {
    
}

final class NearestCoffeeView: UIView {
    
    // MARK: - UIElements
    
    
    //MARK: - Initializers
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Private extension
private extension NearestCoffeeView {
    
    func setup() {
        backgroundColor = .systemBackground
    }
    
}

// MARK: - DisplaysNearestCoffee
extension NearestCoffeeView: DisplaysNearestCoffee {
    
}

// MARK: - Constants
private extension NearestCoffeeView {
    enum Constants {
        
    }
}
