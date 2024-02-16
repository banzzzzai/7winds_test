//
//  DefaultButtonConfigurable.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 07.02.2024.
//

import UIKit
import SnapKit

protocol DefaultButtonConfigurable: UIControl {
    func configure(with viewModel: DefaultButtonModel)
    func changeTitle(to newTitle: String?)
    func setTouchUpInsideHandler(with handler: @escaping () -> Void)
}

final class DefaultButton: UIControl {
    typealias SelectionHandler = () -> Void
    
    // MARK: - Properties
    var selectHandler: SelectionHandler?
    public var animator: TapAnimator = TapAnimation()
    
    override var isHighlighted: Bool {
        didSet {
            animator.animate(view: self,
                             for: .from(self),
                             duration: Constants.buttonAnimationDuration)
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.buttonText.color
        label.font = AppFonts.label.font
        label.numberOfLines = Constants.buttonNumberOfLines
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycle
    init() {
        super.init(frame: .zero)
        self.addSubviews()
        self.setupButtonGesture()
        self.setupCornerRadius()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private
private extension DefaultButton {
    
    func setupButtonGesture() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonDidTap))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func buttonDidTap() {
        self.selectHandler?()
    }
    
    func setupCornerRadius() {
        self.layer.cornerRadius = Constants.cornerRadius
    }
    
    func addSubviews() {
        self.addSubview(titleLabel)
    }
    
    func makeConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
}

// MARK: - Constants
private extension DefaultButton {
    enum Constants {
        static let buttonNumberOfLines: Int = 1
        static let buttonAnimationDuration: Double = 0.15
        static let cornerRadius: CGFloat = 23
        static let borderWidth: CGFloat = 0
    }
}

// MARK: - DefaultButtonConfigurable
extension DefaultButton: DefaultButtonConfigurable {
    
    func configure(with viewModel: DefaultButtonModel) {
        self.titleLabel.text = viewModel.title
        self.isEnabled = viewModel.isActive
        self.titleLabel.textColor = viewModel.titleColor
        self.backgroundColor = viewModel.buttonColor
        self.selectHandler = viewModel.buttonTapHandler
        if viewModel.font != nil {
            titleLabel.font = viewModel.font
        }
    }
    
    func changeTitle(to newTitle: String?) {
        self.titleLabel.text = newTitle
    }
    
    func setTouchUpInsideHandler(with handler: @escaping () -> Void) {
        self.selectHandler = handler
    }
}
