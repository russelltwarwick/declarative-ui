//
//  UIButtonBuilders.swift
//  declarative-ui
//
//  Created by Russell Warwick on 01/04/2023.
//

import UIKit
import Foundation

extension UIButton {
    @discardableResult
    func text(_ value: String, state: UIControl.State = .normal) -> Self {
        setTitle(value, for: state)
        return self
    }
    
    @discardableResult
    func textColor(_ color: UIColor, state: UIControl.State = .normal) -> Self {
        setTitleColor(color, for: state)
        return self
    }
    
    @discardableResult
    func font(_ size: CGFloat, weight: UIFont.Weight) -> Self {
        titleLabel?.font = .systemFont(ofSize: size, weight: weight)
        return self
    }
    
    @available(iOS 13.0, *)
    @discardableResult
    func systemImage(_ name: String) -> Self {
        setImage(.init(systemName: name), for: .normal)
        return self
    }
    
    @discardableResult
    func image(_ name: String) -> Self {
        setImage(UIImage(named: name), for: .normal)
        return self
    }
    
    @discardableResult
    func image(_ image: UIImage) -> Self {
        setImage(image, for: .normal)
        return self
    }
    
    @discardableResult
    func titleEdgeInsets(_ value: [PaddingEdges]) -> Self {
        // Will come back to this
        //https://medium.com/short-swift-stories/using-uiedgeinsets-to-layout-a-uibutton-44ba04dd085c
        DisplayQueue.sharedInstance.addItem {
            let buttonWidth = self.frame.width
            let imageWidth = self.imageView?.frame.width ?? 0
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: buttonWidth-imageWidth, bottom: 0, right: -(buttonWidth-imageWidth))
            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: 0, right: imageWidth)
//            let buttonWidth = self.frame.width
//            let imageWidth = self.imageView!.frame.width
//            let spacing: CGFloat = 80.0
//            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: buttonWidth-imageWidth + spacing, bottom: 0, right: -(buttonWidth-imageWidth) - spacing)
//            self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth - spacing, bottom: 0, right: imageWidth + spacing)
//            self.contentEdgeInsets = UIEdgeInsets(top: 10, left: spacing, bottom: 10, right: spacing)
//            print(self.frame.width)
        }
        return self
    }
}
