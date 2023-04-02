//
//  Section.swift
//  ios-list-kit
//
//  Created by Russell Warwick on 13/06/2022.
//

import UIKit

@available(iOS 13.0, *)
final class Section: Hashable {
    
    // MARK: Dependencies
    
    let id: String
    let items: [Item]
    let header: SupplementaryItem?
    let footer: SupplementaryItem?
    let background: DecorationItem?
    let layoutType: LayoutType
    
    private var currentPage: Int = 0

    // MARK: Init
    
    init(id: String, // Do not use UUID().uuidString the ID
         header: SupplementaryItemEraser? = nil,
         footer: SupplementaryItemEraser? = nil,
         background: DecorationItemEraser? = nil,
         layout: LayoutType = .list(height: .estimated(55)),
         @ResultBuilder<ItemEraser> items: () -> [ItemEraser]) {
        self.id = id
        self.header = header?.toSupplementaryItem()
        self.footer = footer?.toSupplementaryItem()
        self.background = background?.toDecorationItem()
        self.layoutType = layout
        self.items = items().map { $0.toItem() }
    }
    
    // MARK: Hashable
    
    static func == (lhs: Section, rhs: Section) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // MARK:
    
    func setPage(_ page: Int) {
        guard page != currentPage else { return }
        currentPage = page
        header?.didChangePage(page)
        footer?.didChangePage(page)
    }
    
    var boundarySupplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem] {
        [header?.supplementaryBoundaryItem(), footer?.supplementaryBoundaryItem()].compactMap({ $0 })
    }
}
