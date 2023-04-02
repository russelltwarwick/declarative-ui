//
//  Item.swift
//  ios-list-kit
//
//  Created by Russell Warwick on 13/06/2022.
//

import Foundation
import UIKit

protocol ItemConfigurator {
    func cell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func didSelect(indexPath: IndexPath)
}

struct Item: Hashable  {
    
    let id: Int
    
    // MARK: Blocks
    
    private let cellBindingBlock: (UICollectionView, IndexPath) -> UICollectionViewCell
    private var didSelectBlock: ((IndexPath) -> Void)?
    
    // MARK: Init
  
    init<V: Hashable & ItemConfigurator>(_ value: V) {
        id = value.hashValue
        
        cellBindingBlock = { collectionView, indexPath in
            value.cell(collectionView: collectionView, indexPath: indexPath)
        }

        didSelectBlock = {
            indexPath in value.didSelect(indexPath: indexPath)
        }
    }
    
    // MARK: Hashable
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
 
// MARK: ItemConfigurator

extension Item: ItemConfigurator {
    func cell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        cellBindingBlock(collectionView, indexPath)
    }

    func didSelect(indexPath: IndexPath) {
        didSelectBlock?(indexPath)
    }
}
