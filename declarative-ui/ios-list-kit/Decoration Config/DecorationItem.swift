//
//  DecorationItem.swift
//  spx-ios
//
//  Created by Russell Warwick on 06/02/2023.
//

import UIKit

protocol DecorationItemEraser {
    func toDecorationItem() -> DecorationItem
}

protocol DecorationItemConfig {
    func decoration(layout: UICollectionViewLayout) -> NSCollectionLayoutDecorationItem
}

struct DecorationItem: Hashable  {
    
    let id: Int
    
    // MARK: Blocks
    
    private let decorationBlock: (UICollectionViewLayout) -> NSCollectionLayoutDecorationItem
    
    // MARK: Init
  
    init<V: Hashable & DecorationItemConfig>(_ value: V) {
        id = value.hashValue
        
        decorationBlock = { layout in value.decoration(layout: layout) }
    }
    
    // MARK: Hashable
    
    static func == (lhs: DecorationItem, rhs: DecorationItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: SupplementaryItemConfig

extension DecorationItem: DecorationItemConfig {
    func decoration(layout: UICollectionViewLayout) -> NSCollectionLayoutDecorationItem {
        decorationBlock(layout)
    }
}
