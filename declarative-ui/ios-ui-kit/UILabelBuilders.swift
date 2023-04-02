//
//  UILabelBuilders.swift
//  declarative-ui
//
//  Created by Russell Warwick on 01/04/2023.
//

import UIKit

extension UILabel {
    @discardableResult
    func font(_ size: CGFloat, weight: UIFont.Weight) -> Self {
        font = .systemFont(ofSize: size, weight: weight)
        return self
    }
    
    @discardableResult
    func textColor(_ color: UIColor) -> Self {
        textColor = color
        return self
    }
    
    @discardableResult
    func alignment(_ alignment: NSTextAlignment) -> Self {
        textAlignment = alignment
        return self
    }
    
    @discardableResult
    func numberOfLines(_ value: Int) -> Self {
        numberOfLines = value
        return self
    }
}
