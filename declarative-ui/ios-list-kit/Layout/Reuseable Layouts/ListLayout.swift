//
//  ListLayout.swift
//  spx-ios
//
//  Created by Russell Warwick on 01/03/2023.
//

import UIKit

@available(iOS 13.0, *)
struct ListLayout: LayoutProvider {
    
    private let width: NSCollectionLayoutDimension
    private let height: NSCollectionLayoutDimension
    private let spacing: CGFloat
    private let inset: NSDirectionalEdgeInsets
 
    init(width: NSCollectionLayoutDimension,
         height: NSCollectionLayoutDimension,
         spacing: CGFloat,
         inset: NSDirectionalEdgeInsets = .horizontal(20)) {
        self.width = width
        self.height = height
        self.spacing = spacing
        self.inset = inset
    }
    
    func layout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        let item = NSCollectionLayoutItem(layoutSize: size)
        let section = NSCollectionLayoutSection(group: .horizontal(layoutSize: size, subitem: item, count: 1))
        section.contentInsets = inset
        section.interGroupSpacing = spacing
        return section
    }
}
