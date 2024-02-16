//
//  AppFonts.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 05.02.2024.
//

import UIKit

enum AppFonts {
    case title
    case label
    case placeholder
    
    var font: UIFont? {
        switch self {
        case .title:
            return UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: UIFont.Weight(700).rawValue))
        case .label:
            return UIFont.systemFont(ofSize: 15)
        case .placeholder:
            return UIFont.systemFont(ofSize: 18)
        }
    }
}
