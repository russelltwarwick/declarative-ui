//
//  TestCellViewModel.swift
//  declarative-ui
//
//  Created by Russell Warwick on 31/03/2023.
//

import Foundation

struct TestCellViewModel: Hashable {
    
    // MARK: Dependencies

    private let title: String
    private let id: String
    
    // MARK: Init
    
    init(title: String) {
        self.title = title
        self.id = UUID().uuidString
    }
    
    var titleText: String {
        title.uppercased()
    }
        
    // MARK: Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
    }
}
