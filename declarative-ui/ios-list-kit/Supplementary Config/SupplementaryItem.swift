//
//  SupplementaryItem.swift
//  spx-ios
//
//  Created by Russell Warwick on 05/02/2023.
//

import UIKit

protocol SupplementaryViewBinding {
    associatedtype Model: Hashable
    func update(_ model: Model)
    func didChangePage(_ page: Int)
}

extension SupplementaryViewBinding {
    func didChangePage(_ page: Int) {}
}

protocol SupplementaryItemEraser {
    func toSupplementaryItem() -> SupplementaryItem
}

protocol SupplementaryItemConfig {
    func supplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView
    func supplementaryLayout() -> NSCollectionLayoutBoundarySupplementaryItem?
    func didChangePage(_ page: Int)
}

struct SupplementaryItem: Hashable  {
    
    let id: Int
    
    // MARK: Blocks
    
    private let viewBlock: (UICollectionView, String, IndexPath) -> UICollectionReusableView
    private let supplementaryLayoutBlock: () -> NSCollectionLayoutBoundarySupplementaryItem?
    private var didChangePageBlock: ((Int) -> Void)?
    
    // MARK: Init
  
    init<V: Hashable & SupplementaryItemConfig>(_ value: V) {
        id = value.hashValue
        
        viewBlock = { collectionView, kind, indexPath in
            value.supplementary(collectionView: collectionView, kind: kind, indexPath: indexPath)
        }
        
        supplementaryLayoutBlock = { value.supplementaryLayout() }
                
        didChangePageBlock = { page in value.didChangePage(page) }
    }
    
    // MARK: Hashable
    
    static func == (lhs: SupplementaryItem, rhs: SupplementaryItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: SupplementaryItemConfig

extension SupplementaryItem: SupplementaryItemConfig {
    func supplementaryLayout() -> NSCollectionLayoutBoundarySupplementaryItem? {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                                heightDimension: .fractionalHeight(1.0)))
    }
    
    func supplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        viewBlock(collectionView, kind, indexPath)
    }
    
    func didChangePage(_ page: Int) {
        didChangePageBlock?(page)
    }
    
    func supplementaryBoundaryItem() -> NSCollectionLayoutBoundarySupplementaryItem? {
        supplementaryLayoutBlock()
    }
}
