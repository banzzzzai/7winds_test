//
//  AppColors.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 05.02.2024.
//

import UIKit

enum AppColors {
    case primary
    case regular
    case placeholderText
    case buttonForeground
    case buttonText
    
    var color: UIColor {
        switch self {
        case .primary:
            return UIColor(red: 250/255, green: 249/255, blue: 249/255, alpha: 1)
        case .regular:
            return UIColor(red: 132/255, green: 99/255, blue: 64/255, alpha: 1)
        case .placeholderText:
            return UIColor(red: 175/255, green: 148/255, blue: 121/255, alpha: 1)
        case .buttonForeground:
            return UIColor(red: 52/255, green: 45/255, blue: 26/255, alpha: 1)
        case .buttonText:
            return UIColor(red: 246/255, green: 229/255, blue: 209/255, alpha: 1)
        }
    }
}
