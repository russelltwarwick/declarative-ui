//
//  DecorationView.swift
//  spx-ios
//
//  Created by Russell Warwick on 01/02/2023.
//

import UIKit

@available(iOS 13.0, *)
final class DecorationView<V: UICollectionReusableView>: DecorationItemEraser, Hashable {
    
    var id: String
    
    // MARK: Init
    
    init(id: String = UUID().uuidString) {
        self.id = id
    }
    
    func toDecorationItem() -> DecorationItem { .init(self) }
    
    // MARK: Hasher
    
    static func == (lhs: DecorationView, rhs: DecorationView) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

@available(iOS 13.0, *)
extension DecorationView: DecorationItemConfig {
    func decoration(layout: UICollectionViewLayout) -> NSCollectionLayoutDecorationItem {
        let item = NSCollectionLayoutDecorationItem.background(elementKind: V.id)
        layout.register(V.self, forDecorationViewOfKind: V.id)
        return item
    }
}
