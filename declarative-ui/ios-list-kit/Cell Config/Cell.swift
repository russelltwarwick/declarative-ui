//
//  Cell.swift
//  ios-list-kit
//
//  Created by Russell Warwick on 17/06/2022.
//

import UIKit

protocol ItemEraser {
    func toItem() -> Item
}

protocol CellBinding {
    associatedtype Model: Hashable
    func update(_ model: Model, indexPath: IndexPath)
}

final class Cell<V: CellBinding & UICollectionViewCell>: ItemEraser, Hashable {

    let id: String
    let data: V.Model

    // MARK: Init
    
    init(data: V.Model) {
        self.id = data.hashValue.description
        self.data = data
    }
    
    func toItem() -> Item { .init(self) }
    
    // MARK: Hasher
    
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // MARK: Selectable
    
    private var didSelectBlock: ((IndexPath) -> Void)?

    func didSelect(_ block: ((IndexPath) -> Void)?) -> Self {
        didSelectBlock = { indexPath in block?(indexPath) }
        return self
    }
}

extension Cell: ItemConfigurator {
    func cell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(V.self)
        guard let cell: V = collectionView.dequeue(for: indexPath) else { fatalError("Failed to dequeue cell") }
        cell.update(data, indexPath: indexPath)
        return cell
    }
    
    func didSelect(indexPath: IndexPath) {
        didSelectBlock?(indexPath)
    }
}
