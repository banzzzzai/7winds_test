//
//  DefaultButtonModel.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 07.02.2024.
//

import UIKit

struct DefaultButtonModel {
    let title: String
    let titleColor: UIColor
    let buttonColor: UIColor?
    var buttonTapHandler: (() -> Void)?
    var isActive: Bool
    var font: UIFont?

    init(
        title: String,
        titleColor: UIColor,
        color: UIColor? = nil,
        buttonTapHandler: (() -> Void)? = nil,
        isActive: Bool = true,
        font: UIFont? = nil
    ) {
        self.title = title
        self.titleColor = titleColor
        self.buttonColor = color
        self.buttonTapHandler = buttonTapHandler
        self.isActive = isActive
        self.font = font
    }
}
