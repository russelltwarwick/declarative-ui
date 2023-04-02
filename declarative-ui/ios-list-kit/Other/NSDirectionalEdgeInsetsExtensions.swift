//
//  NSDirectionalEdgeInsetsExtensions.swift
//  nate-list-kit
//
//  Created by Russell Warwick on 16/08/2022.
//

import UIKit

extension NSDirectionalEdgeInsets {
    static func all(_ value: CGFloat) -> Self {
        .init(top: value, leading: value, bottom: value, trailing: value)
    }
    
    static func axis(horizontal: CGFloat, vertical: CGFloat) -> Self {
        .init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
    
    static func horizontal(_ value: CGFloat) -> Self {
        .init(top: .zero, leading: value, bottom: .zero, trailing: value)
    }
    
    static func vertical(_ value: CGFloat) -> Self {
        .init(top: value, leading: .zero, bottom: value, trailing: .zero)
    }
    
    static func edges(top: CGFloat = .zero, leading: CGFloat = .zero,
                      bottom: CGFloat = .zero, trailing: CGFloat = .zero) -> Self {
        .init(top: top, leading: leading, bottom: bottom, trailing: trailing)
    }
}
