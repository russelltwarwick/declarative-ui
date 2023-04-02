//
//  UIImageViewBuilders.swift
//  declarative-ui
//
//  Created by Russell Warwick on 01/04/2023.
//

import UIKit

extension UIImageView {
    @discardableResult
    func image(_ value: UIImage) -> Self {
        image = value
        return self
    }
    
    @discardableResult
    func image(_ named: String) -> Self {
        image = UIImage(named: named)
        return self
    }
    
    @discardableResult
    func systemImage(_ named: String) -> Self {
        image = UIImage(systemName: named)
        return self
    }
    
    @discardableResult
    func contentMode(_ mode: UIView.ContentMode) -> Self {
        contentMode = mode
        return self
    }
}

