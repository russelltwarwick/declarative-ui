//
//  File.swift
//  
//
//  Created by Russell Warwick on 26/07/2022.
//

import UIKit

extension UICollectionView {
    func register<V: UICollectionViewCell>(_ cell: V.Type) {
        register(V.self, forCellWithReuseIdentifier: V.id)
    }
    
    func dequeue<V: UICollectionViewCell>(for indexPath: IndexPath) -> V? {
        dequeueReusableCell(withReuseIdentifier: V.id, for: indexPath) as? V
    }
    
    // MARK: Supplementary View
    
    func registerSupplementaryView<V: UICollectionReusableView>(kind: String, _ cell: V.Type) {
        register(V.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: V.id)
    }
    
    func dequeueSupplementaryView<V: UICollectionReusableView>(ofKind kind: String, for indexPath: IndexPath) -> V? {
        dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: V.id, for: indexPath) as? V
    }
}

extension UICollectionReusableView {
    static var id: String { String(describing: self) }
}
