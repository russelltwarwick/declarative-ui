//
//  GridLayout.swift
//  ios-list-kit
//
//  Created by Russell Warwick on 15/06/2022.
//

import UIKit

struct GridLayout: LayoutProvider {
    
    private let rows: Int
    
    private let itemHeight: NSCollectionLayoutDimension
    private let columnSpacing: CGFloat
    private let rowSpacing: CGFloat
    
    private let inset: NSDirectionalEdgeInsets
    
    private let supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem]
    
    init(rows: Int,
         itemHeight: NSCollectionLayoutDimension,
         columnSpacing: CGFloat,
         rowSpacing: CGFloat,
         inset: NSDirectionalEdgeInsets = .zero,
         supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem] = SupplementaryItemsStandard.items) {
        self.rows = rows
        self.rowSpacing = rowSpacing
        self.columnSpacing = columnSpacing
        self.inset = inset
        self.itemHeight = itemHeight
        self.supplementaryItems = supplementaryItems
    }
    
    func layout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                          heightDimension: itemHeight)
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: rows)
        group.interItemSpacing = .fixed(columnSpacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = inset
        section.interGroupSpacing = rowSpacing
        
        section.boundarySupplementaryItems = supplementaryItems
        return section
    }
}

struct SupplementaryItemsStandard {
    static var items: [NSCollectionLayoutBoundarySupplementaryItem] {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(55))
        return [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottomLeading),
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topTrailing)
        ]
    }
}
