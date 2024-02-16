//
//  ViewState.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 07.02.2024.
//

import UIKit

struct ViewState: OptionSet, Hashable {

    // MARK: - Properties
    
    let rawValue: UInt

    // MARK: - Init
    init(rawValue: UInt) {
        self.rawValue = rawValue
    }

    // MARK: - Options
    static let normal = ViewState(rawValue: 1 << 0)
    static let highlighted = ViewState(rawValue: 1 << 1)
    static let selected = ViewState(rawValue: 1 << 2)
    static let disabled = ViewState(rawValue: 1 << 3)
    
    // MARK: - Static
    static func from(_ control: UIControl) -> ViewState {
        guard control.isEnabled else {
            return .disabled
        }

        return makeEnabledStateState(
            isHighlighted: control.isHighlighted,
            isSelected: control.isSelected
        )
    }

    // MARK: - Private
    private static func makeEnabledStateState(isHighlighted: Bool, isSelected: Bool) -> Self {
        var state: ViewState = []

        if isHighlighted {
            state.insert(.highlighted)
        }
        if isSelected {
            state.insert(.selected)
        }

        return state.isEmpty ? .normal : state
    }
}
