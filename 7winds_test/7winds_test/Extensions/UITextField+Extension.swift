//
//  UITextField+Extension.swift
//  7winds_test
//
//  Created by Афанасьев Александр Иванович on 05.02.2024.
//

import UIKit

extension UITextField {
    
    func indent(offset: CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: offset, height: self.frame.height))
        self.leftViewMode = .always
    }
    
}
