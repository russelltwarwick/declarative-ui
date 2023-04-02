//
//  ExpandedButton.swift
//  declarative-ui
//
//  Created by Russell Warwick on 01/04/2023.
//

import UIKit

final class ExpandedButton: UIButton {
    
    private var hitSize = CGFloat(0)
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isHidden { return nil }
        let buttonSize = frame.size
        
        let newFrame = CGRect(x: -hitSize, y: -hitSize, width: buttonSize.width + (hitSize*2), height: buttonSize.height + (hitSize*2))
        
        return (CGRectContainsPoint(newFrame, point)) ? self : nil
    }
    
    @discardableResult
    func hitPadding(_ value: CGFloat) -> Self {
        hitSize = value
        return self
    }
}
