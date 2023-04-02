//
//  CarouselLayout.swift
//  ios-list-kit
//
//  Created by Russell Warwick on 15/06/2022.
//

import UIKit

final class CarouselLayout: NSCollectionLayoutSection, LayoutProvider {
    
    convenience init(width: NSCollectionLayoutDimension,
                     height: NSCollectionLayoutDimension,
                     behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
                     spacing: CGFloat,
                     inset: NSDirectionalEdgeInsets) {
                        
        self.init(group: .horizontal(layoutSize: .init(widthDimension: width, heightDimension: height),
                                     subitem: .init(layoutSize: .init(widthDimension: width, heightDimension: height)),
                                     count: 1))
        
        orthogonalScrollingBehavior = behavior
        interGroupSpacing = spacing
        contentInsets = inset
        boundarySupplementaryItems = SupplementaryItemsStandard.items
    }
    
    func layout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection { self }
}
