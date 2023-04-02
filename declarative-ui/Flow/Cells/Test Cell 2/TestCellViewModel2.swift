//
//  TestCellViewModel2.swift
//  declarative-ui
//
//  Created by Russell Warwick on 02/04/2023.
//

import Foundation

struct TestCellViewModel2: Hashable {
    
    // MARK: Dependencies

    private let id: String
    private let title: String
    private let subtitle: String
    
    // MARK: Init
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
        self.id = UUID().uuidString
    }
    
    var titleText: String {
        title.uppercased()
    }
    
    var subtitleText: String {
        subtitle.capitalized
    }
        
    // MARK: Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(subtitle)
    }
}
