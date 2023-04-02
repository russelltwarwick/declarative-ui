//
//  Footer.swift
//  nate-list-kit
//
//  Created by Russell Warwick on 15/08/2022.
//

import UIKit

final class Footer<V: SupplementaryViewBinding & UICollectionReusableView>: SupplementaryItemEraser, Hashable {

    let id: String
    let data: V.Model?
    let layout: NSCollectionLayoutBoundarySupplementaryItem?
    
    private var didChangePageBlock: ((Int) -> Void)?

    // MARK: Init
    
    init(data: V.Model? = nil,
         width: NSCollectionLayoutDimension = .fractionalWidth(1.0),
         height: NSCollectionLayoutDimension,
         alignment: NSRectAlignment = .bottom) {
        self.id = data.hashValue.description
        self.data = data
        self.layout = .init(layoutSize: .init(widthDimension: width, heightDimension: height),
                           elementKind: UICollectionView.elementKindSectionFooter,
                           alignment: alignment)
    }
    
    func toSupplementaryItem() -> SupplementaryItem { .init(self) }
    
    // MARK: Hasher
    
    static func == (lhs: Footer, rhs: Footer) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Footer: SupplementaryItemConfig {
    func supplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView {
        collectionView.registerSupplementaryView(kind: kind, V.self)
        
        guard let view: V = collectionView.dequeueSupplementaryView(ofKind: kind, for: indexPath) else { fatalError("Failed to dequeue cell")
        }
        
        if let data { view.update(data) }
        
        didChangePageBlock = { page in view.didChangePage(page) }
        
        return view
    }
    
    func supplementaryLayout() -> NSCollectionLayoutBoundarySupplementaryItem? {
        layout
    }
    
    func didChangePage(_ page: Int) {
        didChangePageBlock?(page)
    }
}
