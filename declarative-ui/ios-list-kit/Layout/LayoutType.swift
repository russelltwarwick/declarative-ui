//
//  LayoutType.swift
//  ios-list-kit
//
//  Created by Russell Warwick on 15/06/2022.
//

import UIKit

protocol LayoutProvider {
    func layout(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection
}

enum LayoutType {
    case custom(_ provider: LayoutProvider)
    
    case list(height: NSCollectionLayoutDimension,
              spacing: CGFloat = .zero,
              inset: NSDirectionalEdgeInsets = .zero)
    
    case advancedList(width: NSCollectionLayoutDimension,
                    height: NSCollectionLayoutDimension,
                    spacing: CGFloat = .zero,
                    inset: NSDirectionalEdgeInsets = .zero)
    
    case grid(rows: Int,
              itemHeight: NSCollectionLayoutDimension,
              columnSpacing: CGFloat,
              rowSpacing: CGFloat,
              inset: NSDirectionalEdgeInsets = .zero)
    
    case carousel(width: NSCollectionLayoutDimension,
                  height: NSCollectionLayoutDimension,
                  spacing: CGFloat,
                  inset: NSDirectionalEdgeInsets = .zero)
    
    case pagedCarousel(width: NSCollectionLayoutDimension,
                       height: NSCollectionLayoutDimension,
                       spacing: CGFloat,
                       centered: Bool = false,
                       inset: NSDirectionalEdgeInsets = .zero)
    
    // MARK: Provider

    var provider: LayoutProvider {
        switch self {
            case .custom(let provider):
                return provider
                
            case .list(let height, let spacing, let inset):
                return ListLayout(width: .fractionalWidth(1.0),
                                  height: height,
                                  spacing: spacing,
                                  inset: inset)
                
            case .advancedList(let width, let height, let spacing, let inset):
                return ListLayout(width: width,
                                  height: height,
                                  spacing: spacing,
                                  inset: inset)
                
            case .grid(let rows,
                       let itemHeight,
                       let columnSpacing,
                       let rowSpacing,
                       let inset):
                return GridLayout(rows: rows,
                                  itemHeight: itemHeight,
                                  columnSpacing: columnSpacing,
                                  rowSpacing: rowSpacing,
                                  inset: inset)
                
            case .carousel(let width,
                           let height,
                           let spacing,
                           let inset):
                return CarouselLayout(width: width,
                                      height: height,
                                      behavior: .continuous,
                                      spacing: spacing,
                                      inset: inset)
                
            case .pagedCarousel(let width,
                                let height,
                                let spacing,
                                let centered,
                                let inset):
                return CarouselLayout(width: width,
                                      height: height,
                                      behavior: centered ? .groupPagingCentered : .groupPaging,
                                      spacing: spacing,
                                      inset: inset)
        }
    }
}
