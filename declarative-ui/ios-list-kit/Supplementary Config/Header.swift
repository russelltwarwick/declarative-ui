//
//  Header.swift
//  spx-ios
//
//  Created by Russell Warwick on 04/02/2023.
//

import UIKit

final class Header<V: SupplementaryViewBinding & UICollectionReusableView>: SupplementaryItemEraser, Hashable {

    let id: String
    let data: V.Model?
    let layout: NSCollectionLayoutBoundarySupplementaryItem

    private var didChangePageBlock: ((Int) -> Void)?
    
    // MARK: Init
    
    init(data: V.Model? = nil,
         width: NSCollectionLayoutDimension = .fractionalWidth(1.0),
         height: NSCollectionLayoutDimension,
         alignment: NSRectAlignment = .top) {
        self.id = data.hashValue.description
        self.data = data
        self.layout = .init(layoutSize: .init(widthDimension: width, heightDimension: height),
                           elementKind: UICollectionView.elementKindSectionHeader,
                           alignment: alignment)
    }
    
    func toSupplementaryItem() -> SupplementaryItem { .init(self) }
    
    // MARK: Hasher
    
    static func == (lhs: Header, rhs: Header) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Header: SupplementaryItemConfig {
    func supplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        collectionView.registerSupplementaryView(kind: kind, V.self)
        
        guard let view: V = collectionView.dequeueSupplementaryView(ofKind: kind, for: indexPath) else { fatalError("Failed to dequeue cell")
        }
        
        if let data { view.update(data) }
                
        didChangePageBlock = { view.didChangePage($0) }

        return view
    }
    
    func supplementaryLayout() -> NSCollectionLayoutBoundarySupplementaryItem? {
        layout
    }
    
    func didChangePage(_ page: Int) {
        didChangePageBlock?(page)
    }
}
