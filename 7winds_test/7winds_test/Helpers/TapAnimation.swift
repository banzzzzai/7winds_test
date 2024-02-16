//
//  TapAnimation.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 07.02.2024.
//

import UIKit

protocol TapAnimator {
    
    func animate(view: UIView, for state: ViewState, duration: TimeInterval, completion: ((Bool) -> Void)?)
    
    /// Анимирует сжатие UIView элемента при нажатии на него
    ///
    /// - Parameters:
    ///   - view: UIView объект.
    ///   - state: Состояние объекта из структуры ViewState.
    ///   - duration: Общая продолжительность анимации, измеряемая в секундах.
    ///   Если указать отрицательное значение или 0, изменения вносятся без анимации.
    func animate(view: UIView, for state: ViewState, duration: TimeInterval)
}

final class TapAnimation: TapAnimator {
    func animate(
        view: UIView,
        for state: ViewState,
        duration: TimeInterval,
        completion: ((Bool) -> Void)?) {
            guard
                let animations = animations(for: view, state: state)
            else {
                completion?(false)
                return
            }
            
        animate(
            animations: animations,
            for: state,
            duration: duration,
            completion: completion
        )
    }
    
    // MARK: - Private
    private func animations(for view: UIView, state: ViewState) -> (() -> Void)? {
        switch state {
        case .highlighted:
            return { [weak view] in
                view?.transform = CGAffineTransform(scaleX: Constants.transformScale, y: Constants.transformScale)
            }
        case .normal:
            return { [weak view] in
                view?.transform = .identity
            }
        default:
            return nil
        }
    }
    
    private func animate(
        animations: @escaping () -> Void,
        for state: ViewState,
        duration: TimeInterval,
        completion: ((Bool) -> Void)?
    ) {
        UIView.animate(
            withDuration: duration,
            delay: .zero,
            options: [.beginFromCurrentState],
            animations: animations,
            completion: completion
        )
    }
}

// MARK: - TapAnimator Extension
extension TapAnimator {
    func animate(view: UIView, for state: ViewState, duration: TimeInterval) {
        animate(
            view: view,
            for: state,
            duration: duration,
            completion: nil
        )
    }
}

// MARK: - TapAnimation Extension
private extension TapAnimation {
    enum Constants {
        static let transformScale: Double = 0.94
    }
}
